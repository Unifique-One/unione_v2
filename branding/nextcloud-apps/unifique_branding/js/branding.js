/*
 * SPDX-License-Identifier: AGPL-3.0-or-later
 * UNIFIQUE ONE branding: text and link rewriting only.
 */
(function () {
	'use strict';

	var NAME = /nextcloud/gi;
	var HAS_NAME = /nextcloud/i;
	var REPLACEMENT = 'UNIFIQUE ONE';
	var DESTINATION = 'https://unifique.com.br';
	var SKIP_ELEMENTS = { SCRIPT: 1, STYLE: 1, NOSCRIPT: 1 };
	var LOGIN_HEADLINE_SELECTOR = '[data-login-form-headline], .login-form__headline';
	var LOGIN_HEADLINE_PREFIX = /faça login em|faca login em|log in to/i;

	function tidy(value) {
		return String(value).replace(NAME, REPLACEMENT).replace(/\s+/g, ' ').trim();
	}

	function isSvgTitle(parent) {
		return parent && parent.localName === 'title' &&
			parent.namespaceURI === 'http://www.w3.org/2000/svg';
	}

	function rewriteText(node) {
		if (!node || typeof node.nodeValue !== 'string') {
			return;
		}
		if (!HAS_NAME.test(node.nodeValue)) {
			return;
		}
		node.nodeValue = node.nodeValue.replace(NAME, REPLACEMENT);
	}

	function isDisallowed(url) {
		var host, path;
		try {
			host = url.hostname.toLowerCase();
			path = (url.pathname || '/').toLowerCase();
		} catch (e) {
			return false;
		}
		if (host === 'docs.nextcloud.com' || host === 'help.nextcloud.com' ||
			host === 'nextcloud.com' || host === 'www.nextcloud.com' ||
			host === 'newsletter.nextcloud.com' || host === 'portal.nextcloud.com' ||
			host === 'enable-javascript.com' || host === 'www.enable-javascript.com' ||
			host === 'bsky.app' || host === 'mastodon.xyz') {
			return true;
		}
		if (host === 'github.com' && path.indexOf('/nextcloud') === 0) {
			return true;
		}
		return (host === 'facebook.com' || host === 'www.facebook.com') &&
			path.toLowerCase().indexOf('nextcloud') !== -1;
	}

	function isAllowed(url) {
		var host = url.hostname.toLowerCase();
		return host === 'unifique.com.br' || host === 'lp.unifique.com.br' ||
			host === 'csphere.cloud' || host === 'www.gnu.org';
	}

	function rewriteLink(link) {
		if (!link || !link.getAttribute || !link.setAttribute) {
			return;
		}
		var raw = link.getAttribute('href');
		if (!raw || !/^\s*https?:\/\//i.test(raw)) {
			return;
		}
		var url;
		try {
			url = new URL(raw, window.location.href);
		} catch (e) {
			return;
		}
		if ((url.protocol !== 'http:' && url.protocol !== 'https:') ||
			isAllowed(url) || !isDisallowed(url)) {
			return;
		}
		link.setAttribute('href', DESTINATION);
		if (link.textContent && HAS_NAME.test(link.textContent)) {
			walk(link);
		}
	}

	function walk(root) {
		if (!root || !root.getElementsByTagName || !document.createTreeWalker ||
			typeof NodeFilter === 'undefined') {
			return;
		}
		var walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT, null, false);
		var node, parent;
		while ((node = walker.nextNode())) {
			parent = node.parentNode;
			if (!parent || !parent.nodeName ||
				SKIP_ELEMENTS[parent.nodeName.toUpperCase()] || isSvgTitle(parent)) {
				continue;
			}
			rewriteText(node);
		}
		var links = root.getElementsByTagName('a');
		for (var i = 0; i < links.length; i++) {
			rewriteLink(links[i]);
		}
	}

	// The Vue login form renders "Faça login em UNIFIQUE ONE" into the card
	// headline. Keep only the canonical product name in that element.
	function rewriteLoginHeadline(root) {
		if (!root || !root.querySelectorAll) {
			return;
		}
		var nodes = root.querySelectorAll(LOGIN_HEADLINE_SELECTOR);
		for (var i = 0; i < nodes.length; i++) {
			var text = nodes[i].textContent || '';
			if (LOGIN_HEADLINE_PREFIX.test(text)) {
				nodes[i].textContent = REPLACEMENT;
			}
		}
	}

	function apply() {
		try {
			if (document.title) {
				document.title = tidy(document.title);
			}
			var meta = document.querySelector &&
				document.querySelector('meta[name="apple-mobile-web-app-title"]');
			if (meta && meta.getAttribute && HAS_NAME.test(meta.getAttribute('content') || '')) {
				meta.setAttribute('content', tidy(meta.getAttribute('content')));
			}
			walk(document.documentElement || document.body);
			rewriteLoginHeadline(document.documentElement || document.body);
		} catch (e) {
			/* Defensive: never break rendering. */
		}
	}

	var timer = null;
	function schedule() {
		if (timer !== null && window.clearTimeout) {
			window.clearTimeout(timer);
		}
		timer = window.setTimeout(apply, 60);
	}

	apply();

	if (document.addEventListener) {
		document.addEventListener('DOMContentLoaded', apply, false);
	}
	if (window.MutationObserver && document.documentElement) {
		new MutationObserver(schedule).observe(document.documentElement, {
			childList: true,
			subtree: true
		});
	}
})();

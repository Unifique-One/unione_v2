/*
 * SPDX-License-Identifier: MPL-2.0
 * UNIFIQUE ONE editor branding. The upstream branding.js is kept untouched in
 * the image; this read-only mount replaces only the product name, the logo
 * destination and the visible upstream product wording. Legal attributions
 * (MPL/LibreOffice links) are preserved.
 */
(function () {
	'use strict';

	var NAME = 'UNIFIQUE ONE';
	var DESTINATION = 'https://unifique.com.br';
	var menuItems = [];
	var passes = 0;

	function input(id, fallback) {
		var node = document.getElementById(id);
		return node && node.value ? node.value : fallback;
	}

	function rewrite(root) {
		if (!root || !root.getElementsByTagName || typeof NodeFilter === 'undefined') {
			return;
		}
		var walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT, null, false);
		var node;
		while ((node = walker.nextNode())) {
			var parent = node.parentNode;
			if (parent && /^(SCRIPT|STYLE|NOSCRIPT)$/i.test(parent.nodeName || '')) {
				continue;
			}
			var value = node.nodeValue;
			if (/collabora online development edition \(code\)|collabora online development edition|collabora online|collabora|\bCODE\b/i.test(value)) {
				node.nodeValue = value
					.replace(/Collabora Online Development Edition \(CODE\)/gi, NAME)
					.replace(/Collabora Online Development Edition/gi, NAME)
					.replace(/Collabora Online/gi, NAME)
					.replace(/Collabora/gi, NAME)
					.replace(/\bCODE\b/g, NAME);
			}
		}
		var links = root.getElementsByTagName('a');
		for (var i = 0; i < links.length; i++) {
			var href = links[i].getAttribute('href') || '';
			if (/^https?:\/\/(www\.)?collaboraonline\.com\//i.test(href)) {
				links[i].setAttribute('href', DESTINATION);
			}
		}
	}

	function apply() {
		NAME = input('init-product-branding-name', NAME);
		DESTINATION = input('init-product-branding-url', DESTINATION);
		var root = document.documentElement || document.body;
		rewrite(root);

		var logoHeader = document.getElementById('document-header');
		var logo = logoHeader && document.querySelector('#document-header > a');
		if (logo) {
			logo.setAttribute('data-cooltip', NAME);
			logo.setAttribute('href', DESTINATION);
			if (!logo.getAttribute('data-unifique-branded')) {
				logo.setAttribute('data-unifique-branded', 'true');
				logo.addEventListener('click', function (event) {
					event.preventDefault();
					window.open(DESTINATION, '_blank');
				});
			}
		}
		menuItems = document.querySelectorAll('#main-menu > li > a');
		if (!logo && passes++ < 40) {
			window.setTimeout(apply, 250);
		} else if (passes < 3) {
			// The menu is built asynchronously; refresh wording once it exists.
			window.setTimeout(apply, 500);
		}
	}

	// Keep the upstream LibreOffice technology attribution in the About dialog.
	function addAttribution() {
		var version = document.getElementById('lokit-version');
		var about = document.getElementById('about-dialog-info');
		if ((!version || !about) && passes++ < 40) {
			window.setTimeout(addAttribution, 250);
			return;
		}
		if (!version || !about || document.getElementById('lokit-extra')) {
			return;
		}
		var div = document.createElement('div');
		div.style.marginInlineEnd = 'auto';
		div.id = 'lokit-extra';
		var span = document.createElement('span');
		span.setAttribute('dir', 'ltr');
		span.textContent = 'built on\u00A0';
		var anchor = document.createElement('a');
		anchor.href = 'https://col.la/lot';
		anchor.setAttribute('target', '_blank');
		anchor.textContent = 'a great technology base';
		div.appendChild(span);
		div.appendChild(anchor);
		version.parentNode.parentNode.insertBefore(div, version.parentNode);
	}

	window.onload = function () {
		apply();
		addAttribution();
	};

	document.onkeyup = function (event) {
		if (event.altKey && event.shiftKey) {
			for (var i = 0; i < menuItems.length; i++) {
				menuItems[i].style.setProperty('text-decoration', 'underline', 'important');
			}
		}
	};
})();

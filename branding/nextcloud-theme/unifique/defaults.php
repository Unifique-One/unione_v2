<?php
/*
 * SPDX-FileCopyrightText: 2026 UNIFIQUE
 * SPDX-License-Identifier: AGPL-3.0-or-later
 *
 * Runtime strings below are UNIFIQUE ONE branding only: no upstream product
 * naming and no upstream documentation/help URLs are returned. The three
 * contact destinations and icons are verbatim copies of unifique.com.br.
 */

class OC_Theme {
	/** Canonical corporate identity. */
	private const BRAND = 'UNIFIQUE ONE';

	/** Canonical external destination. */
	private const SITE = 'https://unifique.com.br';

	/** Public entry point for end users. */
	private const USER_HELP = self::SITE . '/server/34/go.php?to=user';

	/** Official contact redirects, copied from unifique.com.br. */
	private const WHATSAPP_URL = 'https://api.whatsapp.com/send/?phone=554733800800&text=Ol%C3%A1%2C+visitei+o+site+e+preciso+de+ajuda.&type=phone_number&app_absent=0';
	private const TELEGRAM_URL = 'https://t.me/UnifiqueOficialBot';
	private const EMAIL_URL = 'https://email2.unifique.com.br/';

	public function getBaseUrl() {
		return self::SITE;
	}

	public function getDocBaseUrl() {
		return self::USER_HELP;
	}

	public function getSyncClientUrl() {
		return self::SITE;
	}

	public function getTitle() {
		return self::BRAND;
	}

	public function getName() {
		return self::BRAND;
	}

	public function getHTMLName() {
		return self::BRAND;
	}

	public function getEntity() {
		return self::BRAND;
	}

	public function getSlogan() {
		return '';
	}

	/**
	 * Official contact icons served from the theme so the login page CSP
	 * (img-src 'self') does not block them. The files are byte-identical
	 * copies of the SVGs published by unifique.com.br.
	 */
	private function contactLinks() {
		$iconBase = (class_exists('OC') ? \OC::$WEBROOT : '') . '/themes/unifique/core/img/';

		return '<span class="unifique-contacts">'
			. '<a href="' . self::WHATSAPP_URL . '" target="_blank" rel="noopener noreferrer" aria-label="WhatsApp" title="WhatsApp">'
			. '<img src="' . $iconBase . 'contact-whatsapp.svg" alt="WhatsApp" width="20" height="20">'
			. '</a>'
			. '<a href="' . self::TELEGRAM_URL . '" target="_blank" rel="noopener noreferrer" aria-label="Telegram" title="Telegram">'
			. '<img src="' . $iconBase . 'contact-telegram.svg" alt="Telegram" width="20" height="20">'
			. '</a>'
			. '<a href="' . self::EMAIL_URL . '" target="_blank" rel="noopener noreferrer" aria-label="E-mail" title="E-mail">'
			. '<img src="' . $iconBase . 'contact-email.svg" alt="E-mail" width="20" height="20">'
			. '</a>'
			. '</span>';
	}

	public function getShortFooter() {
		return $this->contactLinks();
	}

	public function getLongFooter() {
		return $this->contactLinks();
	}
}

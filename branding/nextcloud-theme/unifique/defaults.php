<?php
/*
 * SPDX-FileCopyrightText: 2026 UNIFIQUE
 * SPDX-License-Identifier: AGPL-3.0-or-later
 *
 * Derived from the Nextcloud example theme (class OC_Theme), AGPL-3.0-or-later.
 * Runtime strings below are UNIFIQUE ONE branding only: no upstream product
 * naming and no upstream documentation/help URLs are returned.
 */

class OC_Theme {
	/** Canonical corporate identity. */
	private const BRAND = 'UNIFIQUE ONE';

	/** Canonical external destination. */
	private const SITE = 'https://unifique.com.br';

	/** Public entry point for end users. */
	private const USER_HELP = self::SITE . '/server/34/go.php?to=user';

	/** Public entry point for administrators. */
	private const ADMIN_HELP = self::SITE . '/server/34/go.php?to=admin';

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

	public function getShortFooter() {
		return '<a href="' . self::SITE . '" target="_blank" rel="noopener noreferrer">'
			. self::BRAND . '</a>'
			. '<br>' . 'Código licenciado sob a AGPL v3 ou posterior (AGPL-3.0-or-later).';
	}

	public function getLongFooter() {
		return '<a href="' . self::SITE . '" target="_blank" rel="noopener noreferrer">'
			. self::BRAND . '</a>'
			. '<br>' . 'Código licenciado sob a AGPL v3 ou posterior (AGPL-3.0-or-later).'
			. '<br>' . '<a href="' . self::ADMIN_HELP . '" target="_blank" rel="noopener noreferrer">'
			. 'Suporte e administração</a>';
	}
}

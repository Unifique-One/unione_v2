<?php
declare(strict_types=1);
// SPDX-License-Identifier: AGPL-3.0-or-later

namespace OCA\UnifiqueBranding\Listener;

use OCP\EventDispatcher\Event;
use OCP\EventDispatcher\IEventListener;
use OCP\Util;

class BeforeTemplateRenderedListener implements IEventListener {
	private static bool $registered = false;

	public function handle(Event $event): void {
		if (self::$registered) {
			return;
		}
		self::$registered = true;
		Util::addScript('unifique_branding', 'branding');
	}
}

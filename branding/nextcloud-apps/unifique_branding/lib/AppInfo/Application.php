<?php
declare(strict_types=1);
// SPDX-License-Identifier: AGPL-3.0-or-later

namespace OCA\UnifiqueBranding\AppInfo;

use OCA\UnifiqueBranding\Listener\BeforeTemplateRenderedListener;
use OCP\AppFramework\App;
use OCP\AppFramework\Bootstrap\IBootContext;
use OCP\AppFramework\Bootstrap\IBootstrap;
use OCP\AppFramework\Bootstrap\IRegistrationContext;
use OCP\AppFramework\Http\Events\BeforeLoginTemplateRenderedEvent;
use OCP\AppFramework\Http\Events\BeforeTemplateRenderedEvent;

class Application extends App implements IBootstrap {
	public function __construct() {
		parent::__construct('unifique_branding');
	}

	public function register(IRegistrationContext $context): void {
		// The login screen uses a dedicated event; all other templates use the
		// generic one. Both must inject the same branding cleanup script.
		$context->registerEventListener(
			BeforeLoginTemplateRenderedEvent::class,
			BeforeTemplateRenderedListener::class
		);
		$context->registerEventListener(
			BeforeTemplateRenderedEvent::class,
			BeforeTemplateRenderedListener::class
		);
	}

	public function boot(IBootContext $context): void {
		// All work is done through registered event listeners.
	}
}

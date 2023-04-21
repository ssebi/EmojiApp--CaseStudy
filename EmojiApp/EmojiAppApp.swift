//
//  EmojiAppApp.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 16.04.2023.
//

import SwiftUI
import Combine

@main
struct EmojiAppApp: App {

    var body: some Scene {
		WindowGroup {
			RandomEmojiUIComposer
				.makeRandomEmoji(
					with: { Just("✨").eraseToAnyPublisher() }
				)
		}
    }

}

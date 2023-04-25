//
//  EmojiApp.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 16.04.2023.
//

import SwiftUI
import Combine

struct EmojiApp: App {

	private let dependencyContainer = DependencyContainer()

    var body: some Scene {
		WindowGroup {
			RandomEmojiUIComposer
				.makeRandomEmoji(
					with: dependencyContainer.randomEmojiLoader
				)
		}
    }

}

struct EmptyApp: App {
	var body: some Scene {
		WindowGroup {
			EmptyView()
		}
	}
}

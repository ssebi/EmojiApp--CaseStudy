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

	private let dependencyContainer = DependencyContainer(apiClient: AlwaysSucceedingAPIServiceStub())

    var body: some Scene {
		WindowGroup {
			RandomEmojiUIComposer
				.makeRandomEmoji(
					with: dependencyContainer.randomEmojiLoader
				)
		}
    }

}

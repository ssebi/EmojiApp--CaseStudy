//
//  RandomEmojiViewModel.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import Foundation

public final class RandomEmojiViewModel: ObservableObject {
	@Published public private(set) var emoji: String?

	private let randomEmojiProvider: () async -> String?

	public init(randomEmojiProvider: @escaping () async -> String?) {
		self.randomEmojiProvider = randomEmojiProvider
	}

	@MainActor public func getRandomEmoji() async {
		emoji = await randomEmojiProvider()
	}
}

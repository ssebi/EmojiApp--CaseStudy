//
//  RandomEmojiViewModel.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import Foundation

public final class RandomEmojiViewModel {
	@Published public private(set) var emoji: String?

	private let randomEmojiProvider: () -> String?

	public init(randomEmojiProvider: @escaping () -> String?) {
		self.randomEmojiProvider = randomEmojiProvider
	}

	public func getRandomEmoji() {
		emoji = randomEmojiProvider()
	}
}

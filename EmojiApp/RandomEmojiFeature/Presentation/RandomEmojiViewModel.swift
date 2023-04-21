//
//  RandomEmojiViewModel.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import Foundation
import Combine

public final class RandomEmojiViewModel: ObservableObject {
	@Published public private(set) var emoji: String?

	private let randomEmojiProvider: () -> AnyPublisher<String?, Never>

	public init(randomEmojiProvider: @escaping () -> AnyPublisher<String?, Never>) {
		self.randomEmojiProvider = randomEmojiProvider
	}

	public func getRandomEmoji() {
		randomEmojiProvider()
			.assign(to: &$emoji)
	}
}

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

	private let randomEmojiLoader: () -> AnyPublisher<String?, Never>

	public init(randomEmojiLoader: @escaping () -> AnyPublisher<String?, Never>) {
		self.randomEmojiLoader = randomEmojiLoader
	}

	public func getRandomEmoji() {
		randomEmojiLoader()
			.assign(to: &$emoji)
	}
}

//
//  RandomEmojiViewModelTests.swift
//  EmojiAppTests
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import XCTest
import EmojiApp

final class RandomEmojiViewModel {
	@Published private(set) var emoji: String?

	private let randomEmojiProvider: () -> String?

	init(randomEmojiProvider: @escaping () -> String?) {
		self.randomEmojiProvider = randomEmojiProvider
	}

	func getRandomEmoji() {
		emoji = randomEmojiProvider()
	}
}

final class RandomEmojiViewModelTests: XCTestCase {

	func test_init_doesNotSendAnyMessages() {
		let spy = GetRndomEmojiSpy()
		let _ = RandomEmojiViewModel(randomEmojiProvider: spy.getEmoji)

		XCTAssertEqual(spy.callCount, 0)
	}

	func test_getRandomEmoji_callsClosure() {
		let spy = GetRndomEmojiSpy()
		let sut = RandomEmojiViewModel(randomEmojiProvider: spy.getEmoji)

		sut.getRandomEmoji()

		XCTAssertEqual(spy.callCount, 1)
	}

	func test_getRandomEmoji_setsLocalVariable() {
		let spy = GetRndomEmojiSpy()
		let expectedEmoji = "✨"
		let sut = RandomEmojiViewModel(randomEmojiProvider: spy.getEmoji)

		spy.completeWithEmoji(expectedEmoji)
		sut.getRandomEmoji()

		XCTAssertEqual(sut.emoji, expectedEmoji)
	}

}

// MARK: - Helpers

final class GetRndomEmojiSpy {
	private(set) var callCount: Int = 0

	private var emojiToCompleteWith: String?

	func getEmoji() -> String? {
		callCount += 1
		return emojiToCompleteWith ?? nil
	}

	func completeWithEmoji(_ emoji: String) {
		emojiToCompleteWith = emoji
	}
}

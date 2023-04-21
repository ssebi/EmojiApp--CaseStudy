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

	private let getEmoji: () -> String?

	init(getEmoji: @escaping () -> String?) {
		self.getEmoji = getEmoji
	}

	func getRandomEmoji() {
		emoji = getEmoji()
	}
}

final class RandomEmojiViewModelTests: XCTestCase {

	func test_init_doesNotSendAnyMessages() {
		let spy = GetEmojiSpy()
		let _ = RandomEmojiViewModel(getEmoji: spy.getEmoji)

		XCTAssertEqual(spy.callCount, 0)
	}

	func test_getRandomEmoji_callsClosure() {
		let spy = GetEmojiSpy()
		let sut = RandomEmojiViewModel(getEmoji: spy.getEmoji)

		sut.getRandomEmoji()

		XCTAssertEqual(spy.callCount, 1)
	}

	func test_getRandomEmoji_setsLocalVariable() {
		let spy = GetEmojiSpy()
		let expectedEmoji = "✨"
		let sut = RandomEmojiViewModel(getEmoji: spy.getEmoji)

		spy.completeWithEmoji(expectedEmoji)
		sut.getRandomEmoji()

		XCTAssertEqual(sut.emoji, expectedEmoji)
	}

}

// MARK: - Helpers

final class GetEmojiSpy {
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

//
//  EmojiViewModelTests.swift
//  EmojiAppTests
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import XCTest
import EmojiApp

final class EmojiViewModel {
	private let getEmoji: () -> String

	init(getEmoji: @escaping () -> String) {
		self.getEmoji = getEmoji
	}
}

final class EmojiViewModelTests: XCTestCase {

	func test_init_doesNotSendAnyMessages() {
		let spy = GetEmojiSpy()
		let _ = EmojiViewModel(getEmoji: spy.getEmoji)

		XCTAssertEqual(spy.callCount, 0)
	}

}

// MARK: - Helpers

final class GetEmojiSpy {
	private(set) var callCount: Int = 0

	func getEmoji() -> String {
		callCount += 1
		return "✨"
	}
}

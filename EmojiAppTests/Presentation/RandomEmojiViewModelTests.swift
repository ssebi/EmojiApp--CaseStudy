//
//  RandomEmojiViewModelTests.swift
//  EmojiAppTests
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import XCTest
import Combine
import EmojiApp

final class RandomEmojiViewModelTests: XCTestCase {

	func test_init_doesNotSendAnyMessages() {
		let (_, spy) = makeSUT()

		XCTAssertEqual(spy.callCount, 0)
	}

	func test_getRandomEmoji_callsClosure() async {
		let (sut, spy) = makeSUT()

		sut.getRandomEmoji()

		XCTAssertEqual(spy.callCount, 1)
	}

	func test_getRandomEmoji_setsLocalVariable() async {
		let expectedEmoji = "✨"
		let (sut, spy) = makeSUT()

		sut.getRandomEmoji()
		spy.completeWithEmoji(expectedEmoji)

		XCTAssertEqual(sut.emoji, expectedEmoji)
	}

	// MARK: - Helpers
	private func makeSUT(line: UInt = #line) -> (RandomEmojiViewModel, GetRandomEmojiSpy) {
		let spy = GetRandomEmojiSpy()
		let sut = RandomEmojiViewModel(randomEmojiLoader: spy.getEmojiPublisher)

		trackForMemoryLeaks(sut, file: #filePath, line: line)
		trackForMemoryLeaks(spy, file: #filePath, line: line)

		return (sut, spy)
	}

}

// MARK: - Helpers

final class GetRandomEmojiSpy {
	var callCount: Int {
		requests.count
	}

	private var requests: [PassthroughSubject<String?, Never>] = []

	func getEmojiPublisher() -> AnyPublisher<String?, Never> {
		let publisher = PassthroughSubject<String?, Never>()
		requests.append(publisher)
		return publisher.eraseToAnyPublisher()
	}

	func completeWithEmoji(_ emoji: String, at index: Int = 0) {
		requests[index].send(emoji)
	}
}

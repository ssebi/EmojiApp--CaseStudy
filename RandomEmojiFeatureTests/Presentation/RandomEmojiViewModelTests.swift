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

		expect(sut.$emoji.eraseToAnyPublisher(), toDeliver: expectedEmoji)
	}

	func test_getRandomEmoji_setsLocalVariableAsEmptyOnError() async {
		let (sut, spy) = makeSUT()

		sut.getRandomEmoji()
		spy.completeWithError(NSError())

		expect(sut.$emoji.eraseToAnyPublisher(), toDeliver: "")
	}

	// MARK: - Helpers
	private func makeSUT(line: UInt = #line) -> (RandomEmojiViewModel, GetRandomEmojiSpy) {
		let spy = GetRandomEmojiSpy()
		let sut = RandomEmojiViewModel(randomEmojiLoader: spy.getEmojiPublisher)

		trackForMemoryLeaks(sut, file: #filePath, line: line)
		trackForMemoryLeaks(spy, file: #filePath, line: line)

		return (sut, spy)
	}

	private func expect(_ publisher: AnyPublisher<String, Never>, toDeliver expectedValue: String, line: UInt = #line) {
		var receivedValue: String?
		let exp = expectation(description: "Waiting for expectation")
		exp.assertForOverFulfill = false
		let subscription = publisher
			.filter { expectedValue.isEmpty ? true : !$0.isEmpty }
			.sink { completion in
				XCTFail()
			} receiveValue: { value in
				receivedValue = value
				exp.fulfill()
			}
		wait(for: [exp], timeout: 0.1)
		subscription.cancel()

		XCTAssertEqual(receivedValue, expectedValue, file: #filePath, line: line)
	}

}

// MARK: - Helpers

final class GetRandomEmojiSpy {
	var callCount: Int {
		requests.count
	}

	private var requests: [PassthroughSubject<String, Error>] = []

	func getEmojiPublisher() -> AnyPublisher<String, Error> {
		let publisher = PassthroughSubject<String, Error>()
		requests.append(publisher)
		return publisher.eraseToAnyPublisher()
	}

	func completeWithEmoji(_ emoji: String, at index: Int = 0) {
		requests[index].send(emoji)
	}

	func completeWithError(_ error: Error, at index: Int = 0) {
		requests[index].send(completion: .failure(error))
	}
}

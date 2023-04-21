//
//  RandomEmojiMapperTests.swift
//  EmojiAppTests
//
//  Created by Sebastian Vidrea on 19.04.2023.
//

import XCTest
import EmojiApp

final class RandomEmojiMapperTests: XCTestCase {
	
	func test_map_throwsExpectedErrorOnNon200HTTPResponse() {
		let data = Data()
		
		let samples = [199, 201, 300, 400, 500]
		
		samples.forEach { code in
			do {
				_ = try RandomEmojiMapper.map(data, from: HTTPURLResponse(statusCode: code))
				XCTFail("Expected to throw error")
			} catch let receivedError as MappingError {
				XCTAssertEqual(receivedError, MappingError.invalidStatusCode)
			} catch {
				XCTFail("Expected to throw error of type MappingError")
			}
		}
	}

	func test_map_throwsExpectedErrorOn200HTTPResponseWithInvalidJSON() {
		let invalidJSON = Data("invalid json".utf8)

		do {
			_ = try RandomEmojiMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
			XCTFail("Expected to throw error")
		} catch let receivedError as MappingError {
			XCTAssertEqual(receivedError, MappingError.invalidData)
		} catch {
			XCTFail("Expected to throw error of type MappingError")
		}
	}

	func test_map_deliversEmojiOn200HTTPResponseWithValidJSON() throws {
		let (validJSON, expectedResult) = makeEmoji()

		let receivedResult = try RandomEmojiMapper.map(validJSON, from: HTTPURLResponse(statusCode: 200))

		XCTAssertEqual(receivedResult, expectedResult)
	}

	// MARK: - Helpers
	private func makeEmoji() -> (data: Data, model: Emoji) {
		let validJSON = Data(
		"""
			{
			   "name": "hugging face",
			   "category": "smileys and people",
			   "group": "face positive",
			   "htmlCode": ["&#129303;"],
			   "unicode": ["U+1F917"]
			}
		""".utf8)
		let emoji = Emoji(
			name: "hugging face",
			category: "smileys and people",
			group: "face positive",
			value: "🤗"
		)
		return (validJSON, emoji)
	}
	
}

// MARK: - Test Helpers
func anyURL() -> URL {
	URL(string: "https://any-url.com")!
}

extension HTTPURLResponse {
	convenience init(statusCode: Int) {
		self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
	}
}

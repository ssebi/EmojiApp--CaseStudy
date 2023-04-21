//
//  RandomEmojiMapperTests.swift
//  EmojiAppTests
//
//  Created by Sebastian Vidrea on 19.04.2023.
//

import XCTest

public enum MappingError: Error {
	case invalidStatusCode
}

struct RandomEmojiMapper {
	static func map(_ data: Data, from response: HTTPURLResponse) throws {
		guard response.statusCode == 200 else {
			throw MappingError.invalidStatusCode
		}
	}
}

final class RandomEmojiMapperTests: XCTestCase {
	
	func test_map_throwsExpectedErrorOnNon200HTTPResponse() {
		let data = Data()
		
		let samples = [199, 201, 300, 400, 500]
		
		samples.forEach { code in
			do {
				let _ = try RandomEmojiMapper.map(data, from: HTTPURLResponse(statusCode: code))
				XCTFail("Expected to throw error")
			} catch let receivedError as NSError {
				XCTAssertEqual(receivedError, MappingError.invalidStatusCode as NSError)
			}
		}
	}
	
}

// MARK: - Helpers
func anyURL() -> URL {
	URL(string: "https://any-url.com")!
}

extension HTTPURLResponse {
	convenience init(statusCode: Int) {
		self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
	}
}

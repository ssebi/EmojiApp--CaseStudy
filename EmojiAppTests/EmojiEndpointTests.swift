//
//  EmojiEndpointTests.swift
//  EmojiAppTests
//
//  Created by Sebastian Vidrea on 19.04.2023.
//

import XCTest

enum RandomEmojiEndpoint {
	case get

	func url(baseURL: URL) -> URL {
		switch self {
			case .get:
				return baseURL.appending(path: "api/random")
		}
	}
}

final class EmojiEndpointTests: XCTestCase {

	func test_randomEmoji_endpointURL() {
		let baseURL = URL(string: "http://base-url.com")!

		let received = RandomEmojiEndpoint.get.url(baseURL: baseURL)

		XCTAssertEqual(received.scheme, "http", "scheme")
		XCTAssertEqual(received.host, "base-url.com", "host")
		XCTAssertEqual(received.path, "/api/random", "path")
	}

}

//
//  APIServiceStubs.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 24.04.2023.
//

import Foundation

struct FailingAPIServiceStub: APIService {
	func getResponse(for url: URL) async throws -> (data: Data, httpURLResponse: HTTPURLResponse) {
		throw NSError(domain: "emoji.app", code: 0)
	}
}

struct AlwaysSucceedingAPIServiceStub: APIService {
	func getResponse(for url: URL) async throws -> (data: Data, httpURLResponse: HTTPURLResponse) {
		(
			Data(
			"""
				{
					"name": "hugging face",
					"category": "smileys and people",
					"group": "face positive",
					"htmlCode": ["&#129303;"],
					"unicode": ["U+1F917"]
				}
			""".utf8),
			HTTPURLResponse(
				url: URL(string: "http://some-url")!,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil
			)!
		)
	}
}

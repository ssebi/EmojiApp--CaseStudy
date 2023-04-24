//
//  DependencyContainer.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import Foundation
import Combine

class DependencyContainer {
	private lazy var apiClient: APIService = {
		URLSessionAPIService()
	}()

	private lazy var baseURL: URL = {
		URL(string: "https://emojihub.yurace.pro")!
	}()

	convenience init(apiClient: APIService) {
		self.init()
		self.apiClient = apiClient
	}

	func randomEmojiLoader() -> AnyPublisher<String, Error> {
		let url = RandomEmojiEndpoint.get.url(baseURL: baseURL)
		return apiClient
			.getResponsePublisher(url: url)
			.tryMap(RandomEmojiMapper.map)
			.map(\.value)
			.eraseToAnyPublisher()
	}
}

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

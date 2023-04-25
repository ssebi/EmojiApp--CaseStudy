//
//  DependencyContainer.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import Foundation
import Combine

class DependencyContainer {
	private lazy var httpClient: HTTPClient = {
		URLSessionHTTPClient()
	}()

	private lazy var baseURL: URL = {
		URL(string: "https://emojihub.yurace.pro")!
	}()

	convenience init(httpClient: HTTPClient) {
		self.init()
		self.httpClient = httpClient
	}

	func randomEmojiLoader() -> AnyPublisher<String, Error> {
		let url = RandomEmojiEndpoint.get.url(baseURL: baseURL)
		return httpClient
			.getResponsePublisher(url: url)
			.tryMap(RandomEmojiMapper.map)
			.map(\.value)
			.eraseToAnyPublisher()
	}
}

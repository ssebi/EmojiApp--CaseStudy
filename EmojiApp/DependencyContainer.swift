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

	func randomEmojiLoader() -> AnyPublisher<String, Error> {
		let url = RandomEmojiEndpoint.get.url(baseURL: baseURL)
		return apiClient
			.getResponsePublisher(url: url)
			.tryMap(RandomEmojiMapper.map)
			.map(\.value)
			.eraseToAnyPublisher()
	}
}

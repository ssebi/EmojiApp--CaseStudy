//
//  URLSessionHTTPClient.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 19.04.2023.
//

import Foundation

final public class URLSessionHTTPClient: HTTPClient {
	enum HTTPClientError: Error {
		case nonHTTPURLResponse
	}

	private let session: URLSession

	public init(session: URLSession = .shared) {
		self.session = session
	}

	public func getResponse(for url: URL) async throws -> (data: Data, httpURLResponse: HTTPURLResponse) {
		let response = try await URLSession(configuration: .default).data(from: url)
		guard let httpURLResponse = response.1 as? HTTPURLResponse else {
			throw HTTPClientError.nonHTTPURLResponse
		}

		return (
			response.0,
			httpURLResponse
		)
	}
}

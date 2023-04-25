//
//  HTTPClient.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 19.04.2023.
//

import Foundation

public protocol HTTPClient {
	func getResponse(for url: URL) async throws -> (data: Data, httpURLResponse: HTTPURLResponse)
}

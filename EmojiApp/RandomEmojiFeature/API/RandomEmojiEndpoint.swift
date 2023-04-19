//
//  RandomEmojiEndpoint.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 19.04.2023.
//

import Foundation

public enum RandomEmojiEndpoint {
	case get

	public func url(baseURL: URL) -> URL {
		switch self {
			case .get:
				return baseURL.appending(path: "api/random")
		}
	}
}

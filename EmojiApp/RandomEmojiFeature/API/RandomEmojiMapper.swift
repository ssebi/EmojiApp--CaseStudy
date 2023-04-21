//
//  RandomEmojiMapper.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import Foundation

public struct RandomEmojiMapper {
	private struct RemoteEmoji: Decodable {
		let name: String
		let category: String
		let group: String
		let unicode: [String]
	}

	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Emoji {
		guard response.statusCode == 200 else {
			throw MappingError.invalidStatusCode
		}

		guard let remoteEmoji = try? JSONDecoder().decode(RemoteEmoji.self, from: data) else {
			throw MappingError.invalidData
		}

		return Emoji(
			name: remoteEmoji.name,
			category: remoteEmoji.category,
			group: remoteEmoji.group,
			value: ""
		)
	}
}

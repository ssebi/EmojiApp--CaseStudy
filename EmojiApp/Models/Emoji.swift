//
//  Emoji.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 18.04.2023.
//

import Foundation

public struct Emoji: Equatable {
	public let name: String
	public let category: String
	public let group: String
	public let value: String

	public init(name: String, category: String, group: String, value: String) {
		self.name = name
		self.category = category
		self.group = group
		self.value = value
	}
}

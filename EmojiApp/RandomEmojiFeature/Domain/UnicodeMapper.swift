//
//  UnicodeMapper.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import Foundation

public struct UnicodeMapper {
	public static func map(_ unicode: [String]) -> String {
		unicode
			.map { $0.replacing("U+", with: "") }
			.compactMap { UInt32($0, radix: 16) }
			.compactMap(UnicodeScalar.init)
			.map(String.init)
			.joined()
	}
}

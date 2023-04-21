//
//  RandomEmojiUIComposer.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import Foundation
import SwiftUI

public struct RandomEmojiUIComposer {
	private init() { }

	public static func makeRandomEmoji(with randomEmojiProvider: @escaping () async -> String?) -> some View {
		let viewModel = RandomEmojiViewModel(randomEmojiProvider: randomEmojiProvider)
		return RandomEmojiView(viewModel: viewModel)
	}
}

//
//  RandomEmojiUIComposer.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import Foundation
import SwiftUI
import Combine

public struct RandomEmojiUIComposer {
	private init() { }

	public static func makeRandomEmoji(
		with randomEmojiLoader: @escaping () -> AnyPublisher<String?, Never>
	) -> some View {
		let viewModel = RandomEmojiViewModel(randomEmojiLoader: randomEmojiLoader)
		return RandomEmojiView(viewModel: viewModel)
	}
}

//
//  RandomEmojiView.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 16.04.2023.
//

import SwiftUI

struct RandomEmojiView: View {
	@StateObject private var viewModel: RandomEmojiViewModel

	init(viewModel: RandomEmojiViewModel) {
		self._viewModel = StateObject(wrappedValue: viewModel)
	}

	var body: some View {
		if let emoji = viewModel.emoji {
			Text(emoji)
		} else {
			ProgressView()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		RandomEmojiUIComposer.makeRandomEmoji(with: {
			"✨"
		})
    }
}

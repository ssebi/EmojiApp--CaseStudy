//
//  RandomEmojiView.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 16.04.2023.
//

import SwiftUI
import Combine

struct RandomEmojiView: View {
	@StateObject private var viewModel: RandomEmojiViewModel

	init(viewModel: RandomEmojiViewModel) {
		self._viewModel = StateObject(wrappedValue: viewModel)
	}

	var body: some View {
		if viewModel.emoji.isEmpty {
			ProgressView()
				.onAppear(perform: viewModel.getRandomEmoji)
		} else {
			VStack {
				Text(viewModel.emoji)
					.font(.system(size: 200))

				Button("Random", action: viewModel.getRandomEmoji)
					.buttonStyle(.borderedProminent)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		RandomEmojiUIComposer
			.makeRandomEmoji(
				with: {
					Deferred {
						Future { completion in
							completion(.success("✨"))
						}
					}
					.eraseToAnyPublisher()
				}
			)
    }
}

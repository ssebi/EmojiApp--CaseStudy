//
//  APIService+Combine.swift
//  EmojiApp
//
//  Created by Sebastian Vidrea on 21.04.2023.
//

import Foundation
import Combine

extension APIService {
	typealias Publisher = AnyPublisher<(Data, HTTPURLResponse), Error>

	func getResponsePublisher(url: URL) -> Publisher {
		return Deferred {
			Future { completion in
				Task {
					let result = try await getResponse(for: url)
					completion(.success(result))
				}
			}
		}
		.eraseToAnyPublisher()
	}
}

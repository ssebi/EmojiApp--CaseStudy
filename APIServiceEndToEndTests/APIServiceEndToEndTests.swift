//
//  APIServiceEndToEndTests.swift
//  APIServiceEndToEndTests
//
//  Created by Sebastian Vidrea on 18.04.2023.
//

import XCTest

final class APIService {
	private let session: URLSession

	init(session: URLSession = .shared) {
		self.session = session
	}

	func getResponse(for url: URL) async throws -> (Data, URLResponse) {
		try await URLSession(configuration: .default)
			.data(from: url)
	}
}

final class APIServiceEndToEndTests: XCTestCase {

	func test_getResponse_deliversErrorOnInvalidURL() async {
		let sut = APIService(session: .init(configuration: .ephemeral))
		let someInvalidURL = URL(string: "some-invalid-url")!

		do {
			_ = try await sut.getResponse(for: someInvalidURL)
			XCTFail("Expected th throw an error")
		} catch {
			let receivedError = error as NSError
			XCTAssertEqual(receivedError.code, -1002)
		}
	}

}

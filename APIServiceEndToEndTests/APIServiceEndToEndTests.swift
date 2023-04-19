//
//  APIServiceEndToEndTests.swift
//  APIServiceEndToEndTests
//
//  Created by Sebastian Vidrea on 18.04.2023.
//

import XCTest

protocol APIService {
	func getResponse(for url: URL) async throws -> (data: Data, httpURLResponse: HTTPURLResponse)
}

final class URLSessionAPIService: APIService {
	enum APIServiceError: Error {
		case nonHTTPURLResponse
	}

	private let session: URLSession

	init(session: URLSession = .shared) {
		self.session = session
	}

	func getResponse(for url: URL) async throws -> (data: Data, httpURLResponse: HTTPURLResponse) {
		let response = try await URLSession(configuration: .default).data(from: url)
		guard let httpURLResponse = response.1 as? HTTPURLResponse else {
			throw APIServiceError.nonHTTPURLResponse
		}

		return (
			response.0,
			httpURLResponse
		)
	}
}

final class APIServiceEndToEndTests: XCTestCase {

	func test_getResponse_deliversErrorOnInvalidURL() async {
		let sut = makeSUT()
		let someInvalidURL = URL(string: "some-invalid-url")!

		do {
			_ = try await sut.getResponse(for: someInvalidURL)
			XCTFail("Expected th throw an error")
		} catch {
			let receivedError = error as NSError
			XCTAssertEqual(receivedError.code, -1002)
		}
	}

	func test_getResponse_deliversDataOnValidURL() async throws {
		let sut = makeSUT()
		let someInvalidURL = URL(string: "https://google.com")!

		let receivedDataResponse = try await sut.getResponse(for: someInvalidURL).data

		XCTAssertEqual(receivedDataResponse.isEmpty, false)
	}

	func test_getResponse_deliversValidHTTPURLReponseOnValidURL() async throws {
		let sut = makeSUT()
		let someInvalidURL = URL(string: "https://google.com")!

		let receivedHTTPURLResponse = try await sut.getResponse(for: someInvalidURL).httpURLResponse

		XCTAssertEqual(receivedHTTPURLResponse.statusCode, 200)
	}

	// MARK: - Helpers
	private func makeSUT() -> APIService {
		URLSessionAPIService(session: .init(configuration: .ephemeral))
	}

}

//
//  UnicodeScalarTests.swift
//  EmojiAppTests
//
//  Created by Sebastian Vidrea on 16.04.2023.
//

import XCTest

final class UnicodeScalarTests: XCTestCase {

	func test_conversion_fromUIntToString() {
		let codepoint: UInt32 = 127881
		let sut = Unicode.Scalar(codepoint)

		XCTAssertEqual(sut, "🎉")
	}
	
}

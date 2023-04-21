//
//  UnicodeScalarTests.swift
//  EmojiAppTests
//
//  Created by Sebastian Vidrea on 16.04.2023.
//

import XCTest
import EmojiApp

final class UnicodeScalarTests: XCTestCase {

	func test_conversion_fromUIntToString() {
		let codepoint: UInt32 = 127881
		let sut = Unicode.Scalar(codepoint)

		XCTAssertEqual(sut, "🎉")
	}

	func test_conversion_fromStringUInt32() {
		let emojiString = "1F1E8"
		let sut = UInt32(emojiString, radix: 16)

		XCTAssertNotNil(sut)
		XCTAssertEqual(sut, 127464)
	}

	func test_map_fromStringArrayToUnicodeScalar() {
		let sut = UnicodeMapper.map(["1F1E8", "1F1EB"])

		XCTAssertEqual(sut, "🇨🇫")
	}

	func test_map_fromStringArrayWithPrefixToUnicodeScalar() {
		let sut = UnicodeMapper.map(["U+1F1E8", "U+1F1EB"])

		XCTAssertEqual(sut, "🇨🇫")
	}

}

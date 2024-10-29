//
//  IBANValidatorTest.swift
//  BForBankTests
//
//  Created by Fadhl Nader on 29/10/2024.
//

import XCTest

import XCTest
@testable import BForBank

final class IBANValidatorTests: XCTestCase {
    
    func testValidIBAN() {
        let validIBANs = [
            "FR7630006000011234567890189",
            "FR1420041010050500013M02606",
            "FR7630001007941234567890185"
        ]
        
        for iban in validIBANs {
            XCTAssertTrue(IBANValidator.isValidIBAN(iban), "Expected \(iban) to be valid")
        }
    }
    
    func testInvalidIBAN() {
        let invalidIBANs = [
            "FR7630006000011234567890188", // Incorrect check digits
            "FR76300060000112345678",      // Too short
            "DE89370400440532013000",      // Not a French IBAN
            "FR76300060000A1234567890189", // Contains a letter in an invalid place
            "FR 76 3000 6000 0112 3456 7890 188" // Incorrect check digit with spaces
        ]
        
        for iban in invalidIBANs {
            XCTAssertFalse(IBANValidator.isValidIBAN(iban), "Expected \(iban) to be invalid")
        }
    }
    
    func testIBANWithSpaces() {
        let ibanWithSpaces = "FR76 3000 6000 0112 3456 7890 189"
        XCTAssertTrue(IBANValidator.isValidIBAN(ibanWithSpaces), "Expected \(ibanWithSpaces) with spaces to be valid")
    }
}

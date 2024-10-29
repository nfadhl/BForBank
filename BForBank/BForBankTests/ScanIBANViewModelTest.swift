//
//  ScanIBANViewModelTest.swift
//  BForBankTests
//
//  Created by Fadhl Nader on 29/10/2024.
//

import XCTest
import Combine
import SwiftUI
@testable import BForBank // Replace with the actual name of your module

final class ScanIBANViewModelTests: XCTestCase {
    @State private var testIBAN = ""
    private var viewModel: ScanIBANViewModel!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        viewModel = ScanIBANViewModel(iban: Binding(get: { self.testIBAN }, set: { self.testIBAN = $0 }))
    }

    override func tearDown() {
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertTrue(viewModel.isScanning, "Expected isScanning to be true initially")
        XCTAssertFalse(viewModel.displayValidationView, "Expected displayValidationView to be false initially")
        XCTAssertEqual(viewModel.recognizedText, "", "Expected recognizedText to be empty initially")
    }

    func testSinkRecognizedTextDisplaysValidationView() {
        viewModel.recognizedText = "FR7630006000011234567890189"

        let expectation = XCTestExpectation(description: "displayValidationView should be set to true after recognizedText is updated")
        viewModel.$displayValidationView
            .sink { displayValidationView in
                if displayValidationView == true {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(viewModel.isScanning, "Expected isScanning to be false after recognizedText is set")
    }

    func testValidateIban() {
        viewModel.recognizedText = "FR7630006000011234567890189"
        viewModel.validateIban()

        XCTAssertFalse(viewModel.displayValidationView, "Expected displayValidationView to be false after validation")
    }

    func testRestartScanning() {
        viewModel.recognizedText = "FR7630006000011234567890189"
        viewModel.displayValidationView = true
        viewModel.isScanning = false

        viewModel.restartScanning()

        XCTAssertEqual(viewModel.recognizedText, "", "Expected recognizedText to be reset")
        XCTAssertFalse(viewModel.displayValidationView, "Expected displayValidationView to be false after restartScanning")
        XCTAssertTrue(viewModel.isScanning, "Expected isScanning to be true after restartScanning")
    }
}

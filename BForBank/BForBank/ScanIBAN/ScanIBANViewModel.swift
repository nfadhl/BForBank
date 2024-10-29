//
//  ScanIBANViewModel.swift
//  BForBank
//
//  Created by Fadhl Nader on 29/10/2024.
//

import Combine
import SwiftUI

final class ScanIBANViewModel: ObservableObject {
    
    @Binding var iban: String

    @Published var displayValidationView: Bool = false
    @Published var recognizedText: String = ""
    @Published var isScanning = true
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(iban: Binding<String>) {
        _iban = iban
        sinkReconizedText()
    }
    
    private func sinkReconizedText() {
        $recognizedText.sink { recognizedText in
            if !recognizedText.isEmpty {
                self.displayValidationView = true
                self.isScanning = false
            }
        }
        .store(in: &cancellableSet)
    }
    
    func restartScanning() {
        recognizedText = ""
        displayValidationView = false
        self.isScanning = true
    }
    
    func validateIban() {
        iban = recognizedText
        displayValidationView = false
    }
}

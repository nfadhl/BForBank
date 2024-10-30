//
//  DataScannerView.swift
//  BForBank
//
//  Created by Fadhl Nader on 29/10/2024.
//

import Foundation
import SwiftUI
import VisionKit

struct DataScannerView: UIViewControllerRepresentable {
    @Binding var recognizedText: String
    @Binding var isScanning: Bool
    
    var recognizedTextValidation: ((String) -> (Bool))?
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let scanner = DataScannerViewController(
            recognizedDataTypes: [.text()],
            qualityLevel: .balanced,
            recognizesMultipleItems: false
        )
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
            try? uiViewController.startScanning()
    }
    
    func makeCoordinator() -> IbanScannerCoordinator {
        IbanScannerCoordinator(self)
    }
    
    final class IbanScannerCoordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DataScannerView
        
        init(_ parent: DataScannerView) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            for item in addedItems {
                switch item {
                case .text(let text):
                    print(text.transcript)
                    if let validateRecognizedText = parent.recognizedTextValidation, validateRecognizedText(text.transcript) {
                        parent.recognizedText = text.transcript
                    }
                default:
                    break
                }
            }
        }
    }
}

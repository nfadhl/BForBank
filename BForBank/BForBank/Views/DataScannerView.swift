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
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DataScannerView
        
        init(_ parent: DataScannerView) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .text(let text):
                if let validateRecognizedText = parent.recognizedTextValidation, validateRecognizedText(text.transcript) {
                    parent.recognizedText = text.transcript
                }
                
            default:
                break
            }
            
        }
    }
}

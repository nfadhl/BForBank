//
//  ScanIBANView.swift
//  BForBank
//
//  Created by Fadhl Nader on 29/10/2024.
//

import SwiftUI
import Foundation

struct ScanIBANView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: ScanIBANViewModel
    
    init(iban: Binding<String>) {
        viewModel = ScanIBANViewModel(iban: iban)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Text("Placez votre IBAN dans le cadre pour le scanner")
                    .multilineTextAlignment(.center)
                
                scannerView
            }
            
            if viewModel.displayValidationView {
                validationView
            }
        }
        .padding(0)
        .background(Color("customColor"))
        .foregroundColor(.white)
        .navigationTitle("Scanner votre IBAN")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
    
    var scannerView: some View {
        ZStack {
            DataScannerView(recognizedText: $viewModel.recognizedText, isScanning: $viewModel.isScanning, recognizedTextValidation: { iban in
                IBANValidator.isValidIBAN(iban)
            })
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Rectangle()
                    .strokeBorder(Color("customColor"), lineWidth: 2)
                    .frame(height: 60)
                    .background(Color.clear)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
    
    var  validationView: some View {
        VStack(spacing: 10) {
            Text("l'IBAN du bénéficiare a été scanné")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 20)
            VStack(spacing: 10) {
                Text("Pensez à le vérifier avant de valider")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(viewModel.recognizedText)
                    .font(.title2)
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    Button(action: {
                        viewModel.validateIban()
                        dismiss()
                    }) {
                        Text("Valider")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("customColor"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        viewModel.restartScanning()
                    }) {
                        Text("Recommencer")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color("customColor"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("customColor"), lineWidth: 2)
                            )
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 40)
            }
        }
        .background(.black)
    }
}

//
//  AddBeneficiaryView.swift
//  BForBank
//
//  Created by Fadhl Nader on 29/10/2024.
//

import SwiftUI

struct AddBeneficiaryView: View {
    @State private var iban: String = ""
    
    var body: some View {
        NavigationStack() {
            VStack(spacing: 30) {
                instructionText
                scannerButton
                ibanTextField
                
                Spacer()
            }
            .padding()
            .background(.black)
            .foregroundColor(.white)
            .navigationTitle("Ajouter un bénéficiaire")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
    
    private var instructionText: some View {
            Text("Scannez, importez ou saisissez l’IBAN")
                .foregroundColor(.gray)
        }
    
    private var scannerButton: some View {
           NavigationLink(destination: ScanIBANView(iban: $iban)) {
               HStack {
                   Image(systemName: "camera")
                   Text("Scanner")
                       .fontWeight(.semibold)
               }
               .padding(10)
               .foregroundColor(Color("customColor"))
               .overlay(
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(Color("customColor"), lineWidth: 2)
               )
               .cornerRadius(10)
           }
       }
    
    private var ibanTextField: some View {
            TextField("FR76 XXXX", text: $iban)
                .padding()
                .background(Color("customColor"))
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal, 10)
        }
}

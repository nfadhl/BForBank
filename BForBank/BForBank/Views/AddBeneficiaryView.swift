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
                Text("Scannez, importez ou saisissez l’IBAN")
                    .foregroundColor(.gray)
                
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
                
                TextField("FR76 XXXX", text: $iban)
                    .padding()
                    .background(Color("customColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                
                Spacer()
            }
            .padding()
            .foregroundColor(.white)
            .navigationTitle("Ajouter un bénéficiaire")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

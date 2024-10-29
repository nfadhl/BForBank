//
//  IBANValidator.swift
//  BForBank
//
//  Created by Fadhl Nader on 29/10/2024.
//

import Foundation

final class IBANValidator {
    static func isValidIBAN(_ iban: String) -> Bool {
        
        let trimmedIBAN = iban.replacingOccurrences(of: " ", with: "").uppercased()
        
        guard trimmedIBAN.hasPrefix("FR"), trimmedIBAN.count == 27 else {
            return false
        }
        
        let rearrangedIBAN = String(trimmedIBAN.dropFirst(4) + trimmedIBAN.prefix(4))
        
        let numericIBAN = rearrangedIBAN.compactMap { character -> String? in
            if let number = character.wholeNumberValue {
                return String(number)
            } else if let asciiValue = character.asciiValue {
                return String(Int(asciiValue) - 55)
            }
            return nil
        }.joined()
        
        var remainder = 0
        let chunkSize = 9
        var index = numericIBAN.startIndex

        while index < numericIBAN.endIndex {
            let endIndex = numericIBAN.index(index, offsetBy: chunkSize, limitedBy: numericIBAN.endIndex) ?? numericIBAN.endIndex
            let chunk = String(numericIBAN[index..<endIndex])
            
            if let value = Int("\(remainder)\(chunk)") {
                remainder = value % 97
            } else {
                return false
            }
            
            index = endIndex
        }
        
        return remainder == 1
    }

}

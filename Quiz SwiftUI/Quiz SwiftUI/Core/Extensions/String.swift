//
//  String.swift
//  Quiz SwiftUI
//
//  Created by a021 DIT UPM on 27/10/21.
//

import Foundation

infix operator =+-= : ComparisonPrecedence

extension String {
    
    //Devuelve el string lowered y trimmed
    func loweredTrimmed() -> String {
        self.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    //Compara igualdad después de lowered y trimmed
    func isLoweredTrimmedEqual(_ str: String) -> Bool {
        self.loweredTrimmed() == str.loweredTrimmed()
    }
    
    //Compara si dos string son más o menos iguales, o mejor dicho,
    //igualdad después de lowered y trimmed
    static func =+-= (s1: String, s2: String) -> Bool {
        s1.isLoweredTrimmedEqual(s2)
    }
}

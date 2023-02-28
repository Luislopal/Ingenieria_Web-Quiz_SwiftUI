//
//  ScoresModel.swift
//  Quiz SwiftUI
//
//  Created by a021 DIT UPM on 27/10/21.
//

import Foundation

class ScoresModel : ObservableObject {
    
    @Published private (set) var acertadas : Set<Int> = []

    @Published private (set) var record: Set<Int> = []
    
    init() {
        if let record = UserDefaults.standard.object(forKey: "record") as? [Int] {
            self.record = Set(record)
        }
    }
    
    func check (respuesta : String, quiz: QuizItem) {
        
        if respuesta =+-= quiz.answer {
            
            acertadas.insert(quiz.id)
            record.insert(quiz.id)
            
            UserDefaults.standard
                .set(Array<Int>(record), forKey: "record")
            
        }
    }
    
    func acertada (quizItem: QuizItem) -> Bool {
        return acertadas.contains(quizItem.id)
    }
    
    
    func limpiar() {
        acertadas = []
    }
    
}

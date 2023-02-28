//
//  Quiz_SwiftUIApp.swift
//  Quiz SwiftUI
//
//  Created by a021 DIT UPM on 27/10/21.
//

import SwiftUI

@main
struct Quiz_SwiftUIApp: App {
    
    let quizzesModel = QuizzesModel()
    let scoresModel = ScoresModel()
    
    var body: some Scene {
        WindowGroup {
            QuizzesListView()
                .environmentObject(quizzesModel)
                .environmentObject(scoresModel)
        }
    }
}

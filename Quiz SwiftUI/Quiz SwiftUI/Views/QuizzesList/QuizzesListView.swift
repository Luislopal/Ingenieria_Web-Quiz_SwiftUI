//
//  ContentView.swift
//  Quiz SwiftUI
//
//  Created by a021 DIT UPM on 27/10/21.
//

import SwiftUI

struct QuizzesListView: View {
    
    @EnvironmentObject var quizzesModel: QuizzesModel
    
    @EnvironmentObject var scoresModel: ScoresModel
    
    @State var verlosTodos: Bool = true
    
    var body: some View {
        
        NavigationView {
            List {
                Toggle("Ver todos los Quizzes", isOn: $verlosTodos)
                ForEach(quizzesModel.quizzes) { qi in
                    if verlosTodos || !scoresModel.acertada(quizItem: qi) {
                        NavigationLink(destination: QuizPlayView(quizItem: qi)) {
                            QuizRowView(quizItem: qi)
                        }
                    }
                }
            }
            .padding()
            .navigationBarTitle(Text("Quiz SwiftUI"))
            .navigationBarItems(leading: Text("Recarga Quizzes").font(.callout),
                                trailing: Button(action: {
                                    quizzesModel.download()
                                    scoresModel.limpiar()
                                }) {
                                    Label("Recargar", systemImage: "arrow.triangle.2.circlepath")
                                }
            )
            .onAppear {
                if (quizzesModel.quizzes.isEmpty){
                    quizzesModel.download()
                }
            }
            
          }
        
        Text("Totales acertados desde inicio: \(scoresModel.record.count)")
        
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizzesListView()
//    }
//}

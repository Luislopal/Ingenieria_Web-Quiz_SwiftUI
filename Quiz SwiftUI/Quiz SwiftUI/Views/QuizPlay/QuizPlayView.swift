//
//  QuizPlayView.swift
//  Quiz SwiftUI
//
//  Created by a021 DIT UPM on 27/10/21.
//

import SwiftUI

struct QuizPlayView: View {
    
    var quizItem: QuizItem
    
    @EnvironmentObject var quizzesModel: QuizzesModel
    
    @EnvironmentObject var scoresModel : ScoresModel
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @State var answer: String = ""
    
    @State var showAlert = false
    
    var body: some View {
        
        
        if (verticalSizeClass == .compact) {
            
            VStack {
                
                title
                
                HStack {
                    
                    VStack {
                        
                        TextField("Introduce la respuesta correcta",
                                  text: $answer,
                                  onCommit: {
                                    showAlert = true
                                    scoresModel.check(respuesta: answer, quiz: quizItem)
                                  })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .alert(isPresented: $showAlert) {
                                
                                Alert(title: Text("Resultado"),
                                      message: Text(self.quizItem.answer.isLoweredTrimmedEqual(answer) ? "Correcto" : "Incorrecto"),
                                      dismissButton: .default(Text("Ok"))
                                )
                            }
                        
                        Button(action: {
                            self.showAlert = true
                            scoresModel.check(respuesta: answer, quiz: quizItem)
                        }, label: {
                            Label("Comprobar", systemImage: "questionmark.circle.fill")
                        })
                    }
                    
                    attachment
                }
                
                HStack (alignment: .bottom, spacing: 150) {
                    
                    VStack (alignment: .center) {
                        author
                    }
                    
                    VStack (alignment: .center) {
                        Text("Score: \(scoresModel.acertadas.count)")
                    }
                }
            }
        } else {
            
            VStack {
                
                title
                
                TextField("Introduce la respuesta correcta",
                          text: $answer,
                          onCommit: {
                            showAlert = true
                            scoresModel.check(respuesta: answer, quiz: quizItem)
                          })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .alert(isPresented: $showAlert) {
                        
                        Alert(title: Text("Resultado"),
                              message: Text(self.quizItem.answer.isLoweredTrimmedEqual(answer) ? "Correcto" : "Incorrecto"),
                              dismissButton: .default(Text("Ok"))
                        )
                    }
                
                Button(action: {
                    self.showAlert = true
                    scoresModel.check(respuesta: answer, quiz: quizItem)
                }, label: {
                    Label("Comprobar", systemImage: "questionmark.circle.fill")
                })
                
                attachment
                
                HStack (alignment: .bottom, spacing: 150) {
                    
                    VStack (alignment: .center) {
                        author
                    }
                    
                    VStack (alignment: .center) {
                        Text("Score: \(scoresModel.acertadas.count)")
                    }
                }
            }
        }
    }
    
    private var title: some View {
        HStack {
            Text(quizItem.question)
                .font(.largeTitle)
            
            Button(action: {
                quizzesModel.toggleFavourite(quizItem: quizItem)
            }, label: {
                Image(quizItem.favourite ? "star_yellow" : "star_grey")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
            })
            
        }
    }
    
    @State var angle = 0.0
    @State var scale : CGFloat = 1.0
    
    private var attachment: some View {
        
        let aurl = quizItem.attachment?.url
        let anivm = NetworkImageViewModel(url: aurl)
        
        return GeometryReader { g in
            NetworkImageView(viewModel: anivm)
                .scaledToFill()
                .frame(width: g.size.width, height: g.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .contentShape(RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 4))
                .saturation(self.showAlert ? 0.1 : 1)
                .animation(.easeInOut, value: self.showAlert)
                .rotationEffect(Angle(degrees: angle))
                .scaleEffect(x:scale, y:scale)
                .onTapGesture(count: 2) {
                    answer = self.quizItem.answer
                    
                    withAnimation(.easeInOut(duration: 2)) {
                        angle += 360
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        withAnimation(.easeInOut(duration: 2)) {
                            scale = 1.3 - scale
                        }
                    }
                }
        }
        .padding()
    }
    
    private var author: some View {
        
        let uurl = quizItem.author?.photo?.url
        let univm = NetworkImageViewModel(url: uurl)
        
        return HStack(alignment: .bottom, spacing: 10) {
            Text(quizItem.author?.username ?? "anonimo")
                .font(.callout)
                .foregroundColor(.green)
                .padding(.leading)
            
            NetworkImageView(viewModel: univm)
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(lineWidth: 3))
                .contextMenu {
                    Button("Borrar Respuesta") {
                        answer = ""
                    }
                    Button("Respuesta Correcta") {
                        answer = quizItem.answer
                    }
                }
        }
    }
}



//struct QuizPlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizPlayView()
//    }
//}

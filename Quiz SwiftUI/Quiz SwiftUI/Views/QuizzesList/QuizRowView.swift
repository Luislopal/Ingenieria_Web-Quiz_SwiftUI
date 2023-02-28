//
//  QuizRowView.swift
//  Quiz SwiftUI
//
//  Created by a021 DIT UPM on 27/10/21.
//

import SwiftUI

struct QuizRowView: View {
    
    var quizItem: QuizItem
    
    var body: some View {
        
        let aurl = quizItem.attachment?.url
        let anivm = NetworkImageViewModel(url: aurl)
        
        let uurl = quizItem.author?.photo?.url
        let univm = NetworkImageViewModel(url: uurl)
        
        return
            HStack {
                NetworkImageView(viewModel: anivm)
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 4))
                
                VStack {
                    HStack {
                        Text(quizItem.question)
                            .font(.headline)
                        
                        Image(quizItem.favourite ? "star_yellow" : "star_grey")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                    }
                    
                    VStack (alignment: .trailing, spacing: 5) {
                        HStack (alignment: .bottom, spacing: 5) {
                            Text(quizItem.author?.username ?? "anonimo")
                                .font(.callout)
                                .foregroundColor(.green)
                                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        }
                        
                        NetworkImageView(viewModel: univm)
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(lineWidth: 3))
                    }
                    
                }
                
            }
        
    }
}



//struct QuizRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizRowView()
//    }
//}

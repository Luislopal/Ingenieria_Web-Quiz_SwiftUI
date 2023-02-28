//
//  NetworkImageView.swift
//  P1 Quiz SwiftUI
//
//  Created by Santiago Pavón Gómez on 9/9/21.
//

import SwiftUI

struct NetworkImageView: View {
       
    @ObservedObject var viewModel: NetworkImageViewModel
    
    var body: some View {
        Image(uiImage: viewModel.uiImage)
            .resizable()
    }
}

struct NetworkImageView_Previews: PreviewProvider {
    static let url = URL(string: "https://www.etsit.upm.es/fileadmin/user_upload/banner_portada_escuela.jpg")

    static var previews: some View {
        NetworkImageView(viewModel: NetworkImageViewModel(url: url))
    }
}

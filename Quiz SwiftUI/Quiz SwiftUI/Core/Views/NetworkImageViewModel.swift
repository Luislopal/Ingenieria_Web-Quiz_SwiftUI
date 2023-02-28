//
//  NetworkImageViewModel.swift
//  P1 Quiz SwiftUI
//
//  Created by Santiago Pavón Gómez on 9/9/21.
//

import SwiftUI
import Combine

class NetworkImageViewModel: ObservableObject {

    // El modelo: url de la imagena descargar.
    private var url: URL?

    static let noneImage = UIImage(systemName: "x.circle")!
    static let errorImage = UIImage(systemName: "exclamationmark.triangle.fill")!
    static let loadingImage = UIImage(systemName: "arrow.2.circlepath.circle.fill")!
    
    // Cache para las imagenes ya descargadas.
    static var imagesCache = [URL:UIImage]()
    
    // Me subscribo a los avisos de memoria baja para limpiar la cache.
    var memoryWarningCancellable = NotificationCenter.default
        .publisher(for: UIApplication.didReceiveMemoryWarningNotification)
        .sink() { _ in
            NetworkImageViewModel.imagesCache.removeAll()
        }

    // Suscripcion de la descarga de una imagen
    private var fetchImageCancellable: AnyCancellable?

    // Publisher para la vista:
    @Published private(set) var uiImage: UIImage!
    
    init(url: URL?) {
        self.url = url
        fetchImage()
    }
    
    private func fetchImage() {
        guard let url = url else {
            uiImage = Self.noneImage
            return
        }
        if let img = Self.imagesCache[url] {
            uiImage = img
            return
        }
        uiImage = Self.loadingImage
        fetchImageCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: {[unowned self] completion in
                    if case .failure = completion {
                        self.uiImage = Self.errorImage
                    }
                },
                receiveValue: {[unowned self] data in
                    guard let image = UIImage(data: data) else {
                        self.uiImage = Self.errorImage
                        return
                    }
                    self.uiImage = image
                    NetworkImageViewModel.imagesCache[url] = image
                })
    }
}

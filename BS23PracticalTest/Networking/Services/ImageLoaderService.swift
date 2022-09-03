//
//  ImageLoaderService.swift
//  BS23PracticalTest
//
//  Created by Shakhawat Hossain Shahin on 4/9/22.
//

import Foundation
import SwiftUI
import Combine

class ImageLoaderService {
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let url: String
    
    init(url: String) {
        self.url = url
        downloadImage()
    }

    
    private func downloadImage() {
        guard let url = URL(string: AppConstants.imageW500Url + url) else { return }
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
            })
    }
}

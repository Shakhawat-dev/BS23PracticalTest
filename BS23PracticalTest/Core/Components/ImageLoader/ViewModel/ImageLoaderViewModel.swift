//
//  ImageLoaderViewModel.swift
//  BS23PracticalTest
//
//  Created by Shakhawat Hossain Shahin on 4/9/22.
//

import Foundation
import Combine
import SwiftUI

class ImageLoaderViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = true
    
    private let url: String
    private let dataService: ImageLoaderService
    private var cancellables = Set<AnyCancellable>()
    
    init(url: String) {
        self.url = url
        self.dataService = ImageLoaderService(url: url)
        self.addSubscriber()
        self.isLoading = true
    }
    
    private func addSubscriber() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}

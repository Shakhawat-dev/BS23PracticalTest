//
//  MovieDbService.swift
//  BS23PracticalTest
//
//  Created by Shakhawat Hossain Shahin on 4/9/22.
//

import Foundation
import Combine

class MovieDbService {
    @Published var movieResponse: ResponseModel<MovieModel>?
    
    var movieSubscription: AnyCancellable?
    
    init() {
        self.getMovies()
    }
    
    func getMovies(query: String = "marvel", page: Int = 1) {
        if query.isEmpty {
            return
        }
        
        guard var url = URL(string: AppConstants.search) else { return }
        url.appendQueryItem(name: "query", value: "\(query)")
        url.appendQueryItem(name: "page", value: String(page))
        
        movieSubscription = NetworkManager.download(url: url)
            .decode(type: ResponseModel<MovieModel>.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedMovies in
                self?.movieResponse = returnedMovies
            })
    }
}

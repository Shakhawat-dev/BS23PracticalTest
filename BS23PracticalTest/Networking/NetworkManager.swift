//
//  NetworkManager.swift
//  BS23PracticalTest
//
//  Created by Shakhawat Hossain Shahin on 4/9/22.
//

import Foundation
import Combine

class NetworkManager {
    
    /// This method is used for donwloading JSON data
    /// - Parameter url: URL must be provided
    /// - Returns: Data and Error
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleURLResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    /// This method is used for handling URL Responses
    /// - Parameters:
    ///   - output: Takes DataTaskPublisher output  must be provided
    ///   - url: a URL must be provided
    /// - Returns: Data
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    /// This method is used for handling completions
    /// - Parameter completion: must provide a Comlpletion
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    /// This method is used for handling Networking erros
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad Response from URL: \(url)"
            case .unknown: return "[⚠️] Unknown error occure"
                
            }
        }
    }
}

//
//  AppConstants.swift
//  BS23PracticalTest
//
//  Created by Shakhawat Hossain Shahin on 4/9/22.
//

import Foundation

struct AppConstants {
    static private let baseUrl = "https://api.themoviedb.org/"
    static private let version = "3"
    static private let api_key = "38e61227f85671163c275f9bd95a8803"
    static private let imageBaseUrl = "https://image.tmdb.org"
    
    // Query Paths
    static let search = baseUrl + version + "/search/movie?api_key=\(api_key)"
    
    // Image URLs
    static let imageW500Url = imageBaseUrl + "/t/p/w500"
}

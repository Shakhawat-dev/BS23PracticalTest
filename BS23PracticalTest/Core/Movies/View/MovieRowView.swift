//
//  MovieRowView.swift
//  BS23PracticalTest
//
//  Created by Shakhawat Hossain Shahin on 4/9/22.
//

import SwiftUI

struct MovieRowView: View {
    var movie: MovieModel?
    
    var body: some View {
        HStack() {
            if let movie = movie {
                if let path = movie.posterPath {
                    ImageLoaderView(url: AppConstants.imageW500Url + path)
                        .frame(width: 64, height: 128)
                } else {
                    Image(systemName: "questionmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.gray)
                        .frame(width: 64, height: 128)
                }
                
                VStack(alignment: .leading) {
                    Text(movie.title ?? "")
                        .font(.headline)
                    
                    Text(movie.overview ?? "")
                        .font(.caption)
                }
            }
            
            Spacer(minLength: 0)
        }
    }
}

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView()
            .previewLayout(.sizeThatFits)
    }
}

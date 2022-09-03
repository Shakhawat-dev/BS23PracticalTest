//
//  MoviesView.swift
//  BS23PracticalTest
//
//  Created by Shakhawat Hossain Shahin on 4/9/22.
//

import SwiftUI

struct MoviesView: View {
    @EnvironmentObject private var vm: MoviesViewModel
    
    var body: some View {
        ZStack {
            if let movies = vm.movieList {
                List(movies, id: \.id) { movie in
                    MovieRowView(movie: movie)
                        .onAppear() {
                            DispatchQueue.global().sync {
                                // For infinite scroll
                                if movie.id == movies.last?.id {
                                    vm.goNext()
                                }
                            }
                        }
                }
                .listStyle(PlainListStyle())
            } else {
                NoDataView()
            }
            
            if vm.movieList.isEmpty {
                NoDataView()
            }
        }
        .searchable(text: $vm.searchText, prompt: "Search Something")
        .navigationTitle("Movie List")
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
            .environmentObject(MoviesViewModel())
    }
}

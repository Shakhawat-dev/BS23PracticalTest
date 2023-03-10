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
            ScrollViewReader { proxy in
                if let movies = vm.movieList {
                    VStack {
                        List(movies, id: \.id) { movie in
                            MovieRowView(movie: movie)
                                .id(movie.id)
                                .onAppear() {
                                    DispatchQueue.global().sync {
                                        // For infinite scroll
                                        if movie.id == movies.last?.id {
                                            vm.goNext()
                                            
                                            withAnimation {
                                                vm.showTop = true
                                            }
                                        }
                                    }
                                }
                        }
                        .listStyle(PlainListStyle())
                        .overlay(alignment: Alignment.bottomTrailing) {
                            if vm.showTop {
                                Button {
                                    withAnimation {
                                        proxy.scrollTo(movies.first?.id)
                                        vm.showTop = false
                                        vm.showLoader = false
                                    }
                                } label: {
                                    Image(systemName: "arrow.up")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background {
                                            Circle()
                                        }
                                }
                                .padding(.all)
                            }
                            
                        }
                        
                        
                    }
                    .overlay(alignment: .bottom) {
                        if vm.showLoader {
                            ProgressView()
                        }
                    }
                } else {
                    NoDataView()
                }
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

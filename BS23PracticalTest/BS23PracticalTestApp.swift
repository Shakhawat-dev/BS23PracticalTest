//
//  BS23PracticalTestApp.swift
//  BS23PracticalTest
//
//  Created by Shakhawat Hossain Shahin on 4/9/22.
//

import SwiftUI

@main
struct BS23PracticalTestApp: App {
    @StateObject private var vm = MoviesViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MoviesView()
                    .environmentObject(vm)
            }
        }
    }
}

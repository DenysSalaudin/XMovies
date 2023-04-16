//
//  XMoviesProjectApp.swift
//  XMoviesProject
//
//  Created by Denis on 4/2/23.
//

import SwiftUI

@main
struct XMoviesProjectApp: App {
    @StateObject var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

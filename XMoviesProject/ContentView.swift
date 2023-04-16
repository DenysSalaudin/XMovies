//
//  ContentView.swift
//  XMoviesProject
//
//  Created by Denis on 4/2/23.
//

import SwiftUI

struct ContentView: View {
    @State var isEdit = false
    @State private var isLoading = false
    @State private var hasError = false
    @State private var error: MovieError?
    @State var startingPage = 2
    @EnvironmentObject var viewModel : ViewModel
    init() {
        UITabBar.appearance().backgroundColor = .black
       }
    var body: some View {
        VStack {
               TopBarView(isEdit: $isEdit)
          //  Button(action: {viewModel.deleteAll()  }) {
          //      Image(systemName: "heart.fill")
          //  }
            TabView(selection: $startingPage) {
                AllMoviesListView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "list.and.film")
                        Text("All movies")
                    }
                    .tag(1)
                RecomendedView(isLoading: $isLoading, viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "star.square")
                            Text("Recomended")
                        }.tag(2)
                SavedMoviesView(viewModel: viewModel)
                    .onAppear { withAnimation{ isEdit = true 
                        viewModel.isDismiss = true
                    }}
                    .onDisappear { withAnimation{ isEdit = false
                        viewModel.isDismiss = false
                    }}
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                        Text("Saved")
                    }.tag(3)
            }
            .accentColor(Color(#colorLiteral(red: 0.2549019608, green: 0.1916709004, blue: 1, alpha: 1)))
        }
        .task {
           await fetchRecomended()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension ContentView {
    func fetchRecomended() async {
            isLoading = true
             do {
                 try await viewModel.fetchTranding()
                 try await viewModel.fetchUpComing()
                 try await viewModel.fetchPopular()
                 try await viewModel.fetchNowPlaying()
                 try await viewModel.fetchDiscover()
                 try await viewModel.fetchSearch()
             } catch {
                 self.error = error as? MovieError ?? .unexpectedError(error: error)
                 self.hasError = true
             }
             isLoading = false
         }
}

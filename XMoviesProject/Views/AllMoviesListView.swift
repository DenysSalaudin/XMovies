//
//  AllMoviesListView.swift
//  XMoviesProject
//
//  Created by Denis on 4/2/23.
//

import SwiftUI

struct AllMoviesListView: View {
    @State private var isLoading = false
    @State private var hasError = false
    @State private var error: MovieError?
    @State private var searchText = ""
    @ObservedObject var viewModel : ViewModel
    @FocusState var focus : Bool
      var body: some View {
        VStack {
        seachBar
                ScrollView(showsIndicators: false) {
                    if viewModel.movieName.isEmpty {
                        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
                            ForEach(viewModel.discover,id: \.id) { discover in
                                SavedImage_TitleView(posterPath: discover.posterPath, voteAverage: discover.voteAverage, movieTitle: discover.title, movieName: discover.originalTitle)
                                    .onTapGesture {
                                        viewModel.detailDiscover = discover
                                    }
                            }
                            .sheet(item: $viewModel.detailDiscover) { discover in
                                MovieDetailView(viewModel: viewModel, originalLanguage: discover.originalLanguage, backdropPath:discover.backdropPath, posterPath: discover.posterPath, title: discover.title, name: discover.originalTitle , voteAvarege: discover.voteAverage, overview: discover.overview, releaseDate: discover.releaseDate, genresIDS: discover.genreIDS?.first ?? 000)
                            }
                        }
                    } else {
                        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
                            ForEach(viewModel.searchMovies,id: \.id) { search in
                                SavedImage_TitleView(posterPath: search.posterPath, voteAverage: search.voteAverage, movieTitle: search.title, movieName: search.originalTitle)
                                    .onTapGesture {
                                        viewModel.detailSearch = search
                                    }
                            }
                            .sheet(item: $viewModel.detailSearch) { search in
                                MovieDetailView(viewModel: viewModel, originalLanguage: search.originalLanguage, backdropPath:search.backdropPath, posterPath: search.posterPath, title: search.title, name: search.originalTitle , voteAvarege: search.voteAverage, overview: search.overview, releaseDate: search.releaseDate, genresIDS: search.genreIDS?.first ?? 000)
                            }
                        }
                }
                }.padding(.horizontal)
        }
        .onTapGesture {
            focus = false
        }
    }
}

struct AllMoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        AllMoviesListView(viewModel: ViewModel())
    }
}
extension AllMoviesListView {
    var seachBar: some View {
        ZStack {
            RoundedRectangle(cornerSize: .init(width: 20, height: 20))
                .padding(.horizontal,38)
                .frame(height:20)
                .shadow(color: Color(#colorLiteral(red: 0.2549019608, green: 0.1916709004, blue: 1, alpha: 1)), radius: 15)
            HStack{
                Image(systemName: "magnifyingglass")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("Search", text: $viewModel.movieName)
                    .onChange(of: viewModel.movieName) { value in
                        if value.count > 2 {
                            Task {
                               await fetchSearch()
                            }
                        }
                    }
                    .focused($focus)
            }
            .padding(12)
            .background(Color.black)
            .cornerRadius(38)
            .padding(.horizontal, 30)
        }.padding(.top)
    }
    
    func fetchSearch() async {
            isLoading = true
             do {
                 try await viewModel.fetchSearch()
             } catch {
                 self.error = error as? MovieError ?? .unexpectedError(error: error)
                 self.hasError = true
             }
             isLoading = false
         }
    
}


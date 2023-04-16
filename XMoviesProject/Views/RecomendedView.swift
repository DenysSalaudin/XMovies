//
//  RecomendedView.swift
//  XMoviesProject
//
//  Created by Denis on 4/2/23.
//

import SwiftUI

struct RecomendedView: View {
   // @State var isSaved = false
    @State private var error: MovieError?
    @State private var baseURL = "https://image.tmdb.org/t/p/w500"
    @Binding var isLoading : Bool
    @ObservedObject var viewModel : ViewModel
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                   // if isLoading == false {
                        Title(titleName: "Trending")
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack(alignment: .center) {
                                ForEach(viewModel.tranding,id: \.id) { trandings in
                                    Image_TitleView(posterPath: trandings.posterPath, voteAverage: trandings.voteAverage, movieTitle: trandings.title, movieName: trandings.name)
                                        .onTapGesture {
                                            viewModel.detailTrangding = trandings
                                        }
                                        .sheet(item: $viewModel.detailTrangding) { trandings in
                                                MovieDetailView(viewModel: viewModel, originalLanguage: trandings.originalLanguage, backdropPath:trandings.backdropPath, posterPath: trandings.posterPath, title: trandings.title, name: trandings.name , voteAvarege: trandings.voteAverage, overview: trandings.overview, releaseDate: trandings.releaseDate)
                                        }
                                }
                            }.padding(.horizontal)
                        }
                        Title(titleName: "UpComing")
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack(alignment: .center) {
                                ForEach(viewModel.upComing,id: \.id) { upComing in
                                    Image_TitleView(posterPath: upComing.posterPath, voteAverage: upComing.voteAverage, movieTitle: upComing.title, movieName: upComing.originalTitle)
                                        .onTapGesture {
                                            viewModel.detailUpComing = upComing
                                        }
                                        .sheet(item: $viewModel.detailUpComing) { upComing in
                                            MovieDetailView(viewModel: viewModel, originalLanguage: upComing.originalLanguage, backdropPath:upComing.backdropPath, posterPath: upComing.posterPath, title: upComing.title, name: upComing.originalTitle , voteAvarege: upComing.voteAverage, overview: upComing.overview, releaseDate: upComing.releaseDate)
                                      }
                                }
                            }.padding(.horizontal)
                        }
                        Title(titleName: "Popular")
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack(alignment: .center) {
                                ForEach(viewModel.popular,id: \.id) { popular in
                                    Image_TitleView(posterPath: popular.posterPath, voteAverage: popular.voteAverage, movieTitle: popular.title, movieName: popular.originalTitle)
                                        .onTapGesture {
                                            viewModel.detailPopular = popular
                                        }
                                        .sheet(item: $viewModel.detailPopular) { popular in
                                            MovieDetailView(viewModel: viewModel, originalLanguage: popular.originalLanguage, backdropPath:popular.backdropPath, posterPath: popular.posterPath, title: popular.title, name: popular.originalTitle , voteAvarege: popular.voteAverage, overview: popular.overview, releaseDate: popular.releaseDate)
                                        }
                                }
                            }.padding(.horizontal)
                        }
                        Title(titleName: "Now Playing")
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack(alignment: .center) {
                                ForEach(viewModel.nowPlaying,id: \.id) { nowPlaying in
                                    Image_TitleView(posterPath: nowPlaying.posterPath, voteAverage: nowPlaying.voteAverage, movieTitle: nowPlaying.title, movieName: nowPlaying.originalTitle)
                                        .onTapGesture {
                                            viewModel.detailNowPlaing = nowPlaying
                                        }
                                        .sheet(item: $viewModel.detailNowPlaing) { nowPlaying in
                                            MovieDetailView(viewModel: viewModel, originalLanguage: nowPlaying.originalLanguage, backdropPath:nowPlaying.backdropPath, posterPath: nowPlaying.posterPath, title: nowPlaying.title, name: nowPlaying.originalTitle , voteAvarege: nowPlaying.voteAverage, overview: nowPlaying.overview, releaseDate: nowPlaying.releaseDate)
                                        }
                                }
                            }.padding(.horizontal)
                        }
                  /*  } else {
                        ProgressView()
                            .scaleEffect(3)
                            .padding(70)
                    }*/
                }
            }
        }
    }
}


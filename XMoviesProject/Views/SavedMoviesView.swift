//
//  SavedMoviesView.swift
//  XMoviesProject
//
//  Created by Denis on 4/2/23.
//

import SwiftUI

struct SavedMoviesView: View {
    @ObservedObject var viewModel : ViewModel
    @State private var selectedIndices = IndexSet()
    var body: some View {
        ScrollView(showsIndicators: false) {
            Title(titleName: "Saved")            
            if !viewModel.savedEntity.isEmpty {
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
                    ForEach(viewModel.savedEntity) { item in
                        SavedImage_TitleView(posterPath: item.posterPath, voteAverage: item.voteAverage, movieTitle: item.title, movieName: item.name)
                            .onTapGesture {
                                viewModel.detailEntity = item
                            }
                            .sheet(item:$viewModel.detailEntity) { item in
                                MovieDetailView(viewModel: viewModel, originalLanguage: item.originalLanguage, backdropPath: item.backdropPath, posterPath: item.posterPath, title: item.title, name: item.name, voteAvarege: item.voteAverage, overview: item.overview, releaseDate: item.releaseDate, genresIDS: Int(item.genresIDS), movie: item)
                            }
                    }
                }
                .padding(.horizontal)
            } else {
                        VStack {
                            Text("Add Movies which you would like to watch")
                            Image(systemName: "plus.app")
                                .resizable()
                                .frame(width: 35,height: 35)
                        }.font(.headline)
                    .frame(width: 2000,height: 500)
            }
        }
    }
}

struct SavedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedMoviesView(viewModel:ViewModel())
    }
}

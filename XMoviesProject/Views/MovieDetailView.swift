//
//  MovieDetailView.swift
//  XMoviesProject
//
//  Created by Denis on 4/2/23.
//

import SwiftUI

struct MovieDetailView: View {
  
    @ObservedObject var viewModel: ViewModel

    @Environment(\.presentationMode) var presentationMode
    @State private var baseURL = "https://image.tmdb.org/t/p/w500"
    let originalLanguage: String?
    let backdropPath : String?
    let posterPath : String?
    let title : String?
    let name : String?
    let voteAvarege : Double?
    let overview : String?
    let releaseDate: String?
    var id = UUID()
    var genresIDS : Int
    @State var isSaved : Bool?
    @State var movie = MovieEntity()
    
    var genres: String {
        if genresIDS == 28 {
            return "Action"
        }
        if genresIDS == 12 {
            return "Adventure"
        }
        if genresIDS == 16 {
            return "Animation"
        }
        if genresIDS == 35 {
            return "Comedy"
        }
        if genresIDS == 80 {
            return "Crime"
        }
        if genresIDS == 90 {
            return "Documentary"
        }
        if genresIDS == 18 {
            return "Drama"
        }
        if genresIDS == 10751 {
            return "Family"
        }
        if genresIDS == 14 {
            return "Fantasy"
        }
        if genresIDS == 36 {
            return "History"
        }
        if genresIDS == 27 {
            return "Horror"
        }
        if genresIDS == 10749 {
            return "Romance"
        }
        if genresIDS == 878 {
            return "Science Fiction"
        }
        if genresIDS == 10770 {
            return "TV Movie"
        }
        if genresIDS == 53 {
            return "Thriller"
        }
        if genresIDS == 10752 {
            return "War"
        }
        if genresIDS == 37 {
            return "Western"
        }
        else {
            return "Unknown"
        }
    }
    
    var body: some View {
            ZStack {
                ScrollView(showsIndicators: false) {
                        VStack {
                            if let backdrop = backdropPath {
                                BackGroungImageView(urlString: baseURL + (backdrop))
                            } else {
                                Image("BackGroundImage")
                                    .resizable()
                                    .frame(height: 280)
                            }
                            Spacer()
                        }
                        VStack {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .onTapGesture {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                    .font(.title)
                                Spacer()
                               // Button(action: {viewModel.deleteMovie(movie)}) { Image(systemName: "heart.fill")}
                                Image(systemName: isSaved ?? false ? "bookmark.fill" : "bookmark")
                                    .foregroundColor(Color(isSaved ?? false ? .yellow : .white))
                                    .onTapGesture {
                                        let hasPosterPath = viewModel.savedEntity.contains(where: { $0.posterPath == posterPath })
                                        if !(isSaved ?? false) {
                                        isSaved = true
                                            if !hasPosterPath  {
                                                viewModel.addMovie(title: title, id: id, voteAverage: voteAvarege, name: name, originalLanguage: originalLanguage, backdropPath: backdropPath, posterPath: posterPath, overview: overview, releaseDate: releaseDate, isSavedColor: isSaved ?? false, genresIDS: genresIDS)
                                            }
                                        } else {
                                            if viewModel.isDismiss {
                                                presentationMode.wrappedValue.dismiss()
                                                viewModel.deleteMovie(movie)
                                                
                                            }
                                        }
                                    }
                                    .font(.title)
                            }
                            .padding(10)
                            ImageView(urlString: baseURL + (posterPath ?? ""))
                            HStack {
                                Text(title ?? name ?? "Non Found")
                                    .multilineTextAlignment(.center)
                                    .font(.title.bold())
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.60)
                                    .fixedSize(horizontal: false, vertical: true)
                                Text("\(voteAvarege?.as1Decimals() ?? "0.0") / 10")
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                                    .padding(.vertical,8)
                                    .background(Color.yellow)
                                    .cornerRadius(38)
                                    .foregroundColor(.yellow)
                            }.padding(.horizontal)
                            VStack(alignment:.leading) {
                                Text("Overwiev")
                                    .font(.title)
                                    .scaleEffect(0.75)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2549019608, green: 0.1916709004, blue: 1, alpha: 1)))
                                    .padding(.bottom,-9)
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2549019608, green: 0.1916709004, blue: 1, alpha: 1)))
                                    .frame(height: 1)
                                Text(overview ?? "")
                                    .font(.headline)
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2549019608, green: 0.1916709004, blue: 1, alpha: 1)))
                                    .frame(height: 1)
                                        Text("Genres: \(genres)")
                                            .font(.headline)
                                        Text("Release: \(releaseDate ?? "")")
                                            .font(.headline)
                                        Text("Language: \(originalLanguage ?? "UnKnown")")
                                            .font(.headline)
                     
                            }
                            .onAppear {
                                if posterPath == viewModel.detailEntity?.posterPath {
                                    isSaved = true
                                }
                                let hasPosterPath = viewModel.savedEntity.contains(where: { $0.posterPath == posterPath })
                                if hasPosterPath {
                                    isSaved = true
                                    print("Do have this movie in saved!!")
                                } else {
                                    print("Don't have this movie in saved")
                                }
                            }
                            .onDisappear {
                                if posterPath == viewModel.detailEntity?.posterPath {
                                    isSaved = true
                                }
                                let hasPosterPath = viewModel.savedEntity.contains(where: { $0.posterPath == posterPath })
                                if hasPosterPath {
                                    isSaved = true
                                    print("Do have this movie in saved!!")
                                } else {
                                    print("Don't have this movie in saved")
                                }
                            }
                            
                         
                         //   Text("Country: \(trandings.originCountry?.first ?? "UnKnown Country")")
                         // Text("Budjet: 300 000 000")
                         //   Text("Status: Released")
                         //    Text("Age: 16+")
                                             
                        }.offset(y:-280)
                        .padding(.horizontal)
                }
        }
    }
}


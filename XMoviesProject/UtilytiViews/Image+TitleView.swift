//
//  Image+TitleView.swift
//  XMoviesProject
//
//  Created by Denis on 4/6/23.
//

import SwiftUI

struct Image_TitleView: View {
    let posterPath : String?
    let voteAverage : Double?
    let movieTitle : String?
    let movieName : String?
    @State private var baseURL = "https://image.tmdb.org/t/p/w500"
    var body: some View {
                VStack {
                    ImageView(urlString: baseURL + (posterPath ?? ""))
                    Text("\(movieTitle ?? movieName ?? "NONFOUND")")
                        .font(.headline)
                        .frame(width: 200)
                        .lineLimit(1)
                        .overlay {
                            Text("\(voteAverage?.as1Decimals() ?? "0.0") / 10")
                                .font(.headline.bold())
                                .padding(.horizontal)
                                .background(Color(#colorLiteral(red: 0.1190607041, green: 0.1157160473, blue: 0.1259864268, alpha: 1)))
                                .cornerRadius(12)
                                .offset(x:-45,y:-19)
                                .foregroundColor(.yellow)
            }
        }
    }
}

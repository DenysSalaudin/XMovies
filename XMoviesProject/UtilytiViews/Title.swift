//
//  Title.swift
//  XMoviesProject
//
//  Created by Denis on 4/6/23.
//

import SwiftUI

struct Title: View {
    let titleName : String?
    var body: some View {
        Text(titleName ?? "Unknown")
            .font(.headline.bold())
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 1000,height: 35)
                    .foregroundColor(.gray.opacity(0.1))
            }
            .foregroundColor(Color(#colorLiteral(red: 0.2549019608, green: 0.1916709004, blue: 1, alpha: 1)))
    }
}


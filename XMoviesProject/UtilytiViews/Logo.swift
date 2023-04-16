//
//  Logo.swift
//  XMoviesProject
//
//  Created by Denis on 4/11/23.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        HStack {
                Text("Mov")
                    .scaleEffect(2)
                    .font(.headline)
                    .shadow(radius: 10)
                Text("X")
                    .foregroundColor(Color(#colorLiteral(red: 0.2549019608, green: 0.1916709004, blue: 1, alpha: 1)))
                    .scaleEffect(3)
                    .padding()
                    .bold()
                    .shadow(radius: 10)
                Text("vies")
                    .scaleEffect(2)
                    .font(.headline)
                    .shadow(radius: 10)
            }
        //.padding(.horizontal)
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}

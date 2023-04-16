//
//  ImageView.swift
//  XMoviesProject
//
//  Created by Denis on 4/3/23.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    init(urlString:String?)  {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    static let defaultImage = UIImage(systemName: "newspaper")
    var body: some View {
            Image(uiImage: (urlImageModel.image ?? ImageView.defaultImage)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 300)
                .cornerRadius(15)
                .scaledToFit()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(urlString: "")
    }
}

//
//  SavedImageView.swift
//  XMoviesProject
//
//  Created by Denis on 4/7/23.
//

import SwiftUI
struct SavedImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    init(urlString:String?)  {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    static let defaultImage = UIImage(systemName: "newspaper")
    var body: some View {
            Image(uiImage: (urlImageModel.image ?? ImageView.defaultImage)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(15)
                .scaledToFit()
    }
}

struct SavedImageView_Previews: PreviewProvider {
    static var previews: some View {
        SavedImageView(urlString: "")
    }
}

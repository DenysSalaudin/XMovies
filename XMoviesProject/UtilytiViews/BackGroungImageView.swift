//
//  BackGroungImageView.swift
//  XMoviesProject
//
//  Created by Denis on 4/4/23.
//

import SwiftUI

struct BackGroungImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    init(urlString:String?)  {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    static let defaultImage = Image("BackGroundImage")
    var body: some View {
        Image(uiImage: (urlImageModel.image ?? ImageView.defaultImage)!)
            .resizable()
            .blur(radius: 2,opaque: true)
    }
}

struct BackGroungImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackGroungImageView(urlString: "")
    }
}

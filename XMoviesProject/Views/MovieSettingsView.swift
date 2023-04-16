//
//  MovieSettingsView.swift
//  XMoviesProject
//
//  Created by Denis on 4/9/23.
//

import SwiftUI

struct MovieSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Text("Settings")
                .navigationBarItems(leading: Image(systemName: "chevron.left")
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    })
        }
    }
}

struct MovieSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSettingsView()
    }
}

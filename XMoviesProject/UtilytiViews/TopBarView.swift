//
//  TopBarView.swift
//  XMoviesProject
//
//  Created by Denis on 4/2/23.
//

import SwiftUI

struct TopBarView: View {
    @Binding var isEdit: Bool
    @State var isSetting = false
    var body: some View {
        HStack {
            Logo()
                .padding(.horizontal)
            Spacer()
            Button(action:{ isSetting.toggle() }) {
                Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.white)
            }
            .sheet(isPresented: $isSetting) {
                MovieSettingsView()
            }
  
            if isEdit {
                Button(action:{}) {
                    Text("Edit")
                        
                }
                .padding(.leading,1)
                .foregroundColor(.white)
            }
        }.padding(.horizontal)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(isEdit: .constant(true))
    }
}

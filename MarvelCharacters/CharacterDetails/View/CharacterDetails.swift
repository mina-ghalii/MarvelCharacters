//
//  CharacterCell.swift
//  EtisalatTask
//
//  Created by Mina Atef on 20/01/2023.
//

import SwiftUI

struct CharacterDetails: View {
    var character: CharacterData
    var body: some View {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    AsyncImage(url: URL(string: "\(character.thumbnail?.getFullPath(size: .landscapeIncredible) ?? "")"))
                        .frame(width: UIScreen.main.bounds.width)
                        .scaledToFill()
                        .padding(.bottom)
                    Text(character.name ?? "")
                        .fontWeight(.black)
                    Text(character.description ?? "")
                    Spacer()
                }.padding()
            }.ignoresSafeArea()
    }
}

struct CharacterDetails_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetails(character: CharacterData(name: "Mina", userId: 1))
    }
}

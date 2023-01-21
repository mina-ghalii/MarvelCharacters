//
//  ContentView.swift
//  EtisalatTask
//
//  Created by Mina Atef on 05/01/2023.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject private var viewModel = CharactersListViewModel()
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.errorMessage.isEmpty {
                    List {
                        ForEach(viewModel.searchResults, id: \.self) { character in
                            CharacterCell(character: character)
                                .onAppear {
                                    self.listItemAppears(character)
                                }
                        }
                        if viewModel.isLoading {
                            ProgressView()
                        }
                    }
                    .navigationTitle("Marvel Characters")
                    .searchable(text: $viewModel.searchText)
                } else {
                    Text(viewModel.errorMessage)
                }
            }
            
        }
    }
    
}

struct CharacterCell: View {
    var character: CharacterData
    var body: some View {
        NavigationLink(destination: CharacterDetails(character: character), label: {
            HStack {
                VStack {
                    if let url = URL(string: character.thumbnail?.getFullPath(size: .standardMedium) ?? "") {
                        AsyncImage(url: url)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } else {
                        Image("Marvel_Logo")
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    Text(character.name ?? "")
                    Text(character.description ?? "")
                        .lineLimit(nil)
                        .foregroundColor(Color.gray)
                        .frame( maxHeight: 100, alignment: .leading)
                }
                
            }.padding()
            
        })
    }
}

extension CharactersListView {
    private func listItemAppears<Item: Identifiable>(_ item: Item) {
        if viewModel.characters.isThresholdItem(offset: 3, item: item) {
            if !viewModel.isLoading {
                Task {
                    await viewModel.getCharacters()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}

//
//  ContactViewModel.swift
//  EtisalatTask
//
//  Created by Mina Atef on 05/01/2023.
//

import Foundation
@MainActor
final class CharactersListViewModel: ObservableObject {
    private var dataSource: CharacterDataSourceProtocol?
    @Published var characters: [CharacterData] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = true
    @Published var searchText: String = ""
    var limit: Int = 25
    var offset: Int = -25
    init(dataSource: CharacterDataSourceProtocol = CharacterDataSource(), getCharactersImmidiatly: Bool = true) {
        self.dataSource = dataSource
        if getCharactersImmidiatly {
            Task {
                await getCharacters()
            }
        }
    }
    var searchResults: [CharacterData] {
        if searchText.isEmpty {
            return characters
        } else {
            return characters.filter { $0.name?.contains(searchText) ?? false }
        }
    }
    func incrementPage() {
        offset += limit
    }
    func getCharacters() async {
        incrementPage()
        isLoading = true
        let result = await dataSource?.getUsers(limit: limit, offset: offset)
        isLoading = false
        switch result {
        case .success(let data):
            characters.append(contentsOf: data.data?.results ?? [])
        case .failure(let error):
            errorMessage = error.localizedDescription
        case .none:
            errorMessage = "Somthing went wrong"
        }
    }
}

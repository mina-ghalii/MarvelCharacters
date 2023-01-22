//
//  MockCharactersDataSource.swift
//  EtisalatTaskTests
//
//  Created by Mina Atef on 21/01/2023.
//

import Foundation
@testable import MarvelCharacters
final class MockCharactersDataSource: CharacterDataSourceProtocol {
    var succeeded = true
    func getCharacters(limit: Int, offset: Int) async -> Result<CharacterResponse, Error> {
        if succeeded {
            let mockResult = Mockable().getResourcesMock(fileName: "Characters")
            switch mockResult {
            case .success(let characters):
                return .success(characters)
            case .failure(let error):
                return .failure(error)
            }
        } else {
            return .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Faild to parse response"]))
        }
    }
}

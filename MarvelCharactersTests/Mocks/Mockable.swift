//
//  Mockable.swift
//  EtisalatTaskTests
//
//  Created by Mina Atef on 21/01/2023.
//

import Foundation
@testable import MarvelCharacters
class Mockable {
    func getResourcesMock(fileName: String) -> Result<CharacterResponse, Error> {
        if let url = Bundle.init(for: type(of: self)).url(forResource: fileName, withExtension: "json") {
            let decoder = JSONDecoder()
            do {
                let jsonData = try Data(contentsOf: url)
                let resources = try decoder.decode(CharacterResponse.self, from: jsonData )
                return .success(resources)
            } catch {
                return .failure(NSError(domain: "", code: CustomError.faildtoPasrse.code, userInfo: [NSLocalizedDescriptionKey: CustomError.faildtoPasrse.key]))
            }
        } else {
            return .failure(NSError(domain: "", code: CustomError.fileNotFound.code, userInfo: [NSLocalizedDescriptionKey: CustomError.fileNotFound.key]))
        }
    }
}

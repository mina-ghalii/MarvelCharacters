//
//  UsersURLSessionDataSourceProtocol.swift
//  EtisalatTask
//
//  Created by Mina Atef on 05/01/2023.
//

import Foundation
protocol CharacterDataSourceProtocol {
    func getCharacters(limit: Int, offset: Int) async -> Result<CharacterResponse, Error>
}
final class CharacterDataSource: CharacterDataSourceProtocol {
    
    func getCharacters(limit: Int, offset: Int) async -> Result<CharacterResponse, Error> {
        do {
            let timeStamp = Date().timeIntervalSince1970
            let queryItems = [
                URLQueryItem(name: "apikey", value: Constant.marvelPublicKey),
                URLQueryItem(name: "hash", value: Hash.MD5(string: "\(timeStamp)\(Constant.marvelPrivateKey)\(Constant.marvelPublicKey)")),
                URLQueryItem(name: "ts", value: "\(timeStamp)"),
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "offset", value: "\(offset)")
            ]
            let result = try await NetworkManager.request(from: "\(Constant.baseURL)\(Constant.charactersPath)", method: .get, params: queryItems, successModel: CharacterResponse.self)
            switch result {
            case .success(let charactersResponse):
                return .success(charactersResponse)
            case .failure(let error):
                return .failure(error)
            }
        } catch let error {
            return .failure(error)
        }
    }
}

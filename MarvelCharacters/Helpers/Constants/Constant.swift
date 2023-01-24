//
//  Constants.swift
//  EtisalatTask
//
//  Created by Mina Atef on 21/01/2023.
//

import Foundation
class Constant {
    static let marvelPublicKey = "edf5432d9181ca33665808f18d20f170"
    static let marvelPrivateKey = "0c0287b891e1c959bbc977e330da70e4d47df411"
    static let baseURL = "http://gateway.marvel.com"
    static let charactersPath = "/v1/public/characters"
    
}
struct CustomError {
    static let faildtoPasrse = ErrorDetails(key: "faild_to_parse", code: 0)
    static let noHttpResponse = ErrorDetails(key: "no_http_response", code: 1)
    static let noURL = ErrorDetails(key: "no_url", code: 2)
    static let fileNotFound = ErrorDetails(key: "file_not_Found", code: 3)
}
struct ErrorDetails {
    let key: String
    let code: Int
}

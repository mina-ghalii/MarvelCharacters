//
//  Constants.swift
//  EtisalatTask
//
//  Created by Mina Atef on 21/01/2023.
//

import Foundation
class Constant {
    static let marvelPublicKey = "" // please fill this
    static let marvelPrivateKey = "" // please fill this 
    static let baseURL = "http://gateway.marvel.com"
    static let charactersPath = "/v1/public/characters"
    
}
struct CustomError {
    static let faildtoPasrse = ErrorDetails(key: "faild_to_parse", code: 0)
    static let noHttpResponse = ErrorDetails(key: "no_http_response", code: 1)
    static let noURL = ErrorDetails(key: "no_url", code: 2)
    static let fileNotFound = ErrorDetails(key: "file_not_Found", code: 2)
}
struct ErrorDetails {
    let key: String
    let code: Int
}

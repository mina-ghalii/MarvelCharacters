//
//  MarvelError.swift
//  EtisalatTask
//
//  Created by Mina Atef on 21/01/2023.
//

import Foundation
class MarvelError: Codable, Error {
    var code: String?
    var message: String?
}

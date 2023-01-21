//
//  MD5Hashing.swift
//  Assesment3
//
//  Created by Mina Atef on 19/01/2023.
//

import Foundation
import CryptoKit
class Hash {
    static func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

//
//  CharacterResponse.swift
//  EtisalatTask
//
//  Created by Mina Atef on 05/01/2023.
//

import Foundation
struct CharacterResponse: Codable {
    var data: CharacterDataContainer?
}
struct CharacterDataContainer: Codable {
    var results: [CharacterData]?
}

struct CharacterData: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String?
    var userId: Int?
    var thumbnail: Thumbnail?
    var description: String?
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case name, thumbnail, description
    }
}
struct Thumbnail: Codable, Hashable {
    let path: String?
    let imageExtension: String?

    func getFullPath(size: MarvelImageSizes) -> String {
        return "\(path ?? "")/\(size.rawValue).\(imageExtension ?? "")"
    }
    enum CodingKeys: String, CodingKey {
        case imageExtension = "extension"
        case path
    }
}

enum MarvelImageSizes: String {
    case standardMedium = "standard_medium"
    case standardLarge = "standard_large"
    case standardXlarge = "standard_xlarge"
    case landscapeIncredible = "landscape_incredible"
    case portraitFantastic = "portrait_fantastic"
}

//
//  ModelCharacter.swift
//  MCU
//
//  Created by Naman Vaishnav on 20/08/22.
//

import Foundation

// MARK: - ModelCharacter
struct ModelCharacter: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [CharacterResult]?
}

// MARK: - Result
class CharacterResult: Codable {
    let id: Int?
    let name: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let description: String?
    var comics: [ComicResult]?
 
    enum CodingKeys: String, CodingKey {
        case id, name
        case thumbnail, resourceURI, description
    }
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}




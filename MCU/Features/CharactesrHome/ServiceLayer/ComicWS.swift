//
//  ComicWS.swift
//  MCU
//
//  Created by Naman Vaishnav on 20/08/22.
//

import Foundation

struct ComicWS {
    /// constructor
    /// - Parameters:
    ///   - pageSize: pageSize required to show comics on single page
    ///   - offset: number of comics consumed till now
    ///   - characterId: search comis from given character ID
    internal init(
        characterId: String
    ) {
        self.pageSize = 5
        self.offset = 0
        self.characterId = characterId
    }
    
    let pageSize: Int
    let offset: Int
    let characterId: String
        
    
    /// fetch list of comics availiable for giver characters
    /// - Parameter completion: result of model of comics and and error
    func fetchComics(completion: @escaping (_ result: Result<ModelComic, Error>) -> Void) {
        URLSession.shared.request(target: .comics(pageSize, offset, characterId), expecting: ModelComic.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

//
//  CharacterWS.swift
//  MCU
//
//  Created by Naman Vaishnav on 20/08/22.
//

import Foundation

struct CharacterWS {
    /// constructor
    /// - Parameters:
    ///   - pageSize: pageSize required to show characters on single page
    ///   - offset: number of character consumed till now
    ///   - searchQuery: search query for characters
    internal init(
        pageSize: Int,
        offset: Int,
        searchQuery: String
    ) {
        self.pageSize = pageSize
        self.offset = offset
        self.searchQuery = searchQuery
    }
    
    let pageSize: Int
    let offset: Int
    let searchQuery: String
        
    
    /// fetch list of characters
    /// - Parameter completion: result object which contains model of characters and error if any
    func fetchCharacters(completion: @escaping (_ result: Result<ModelCharacter, Error>) -> Void) {
        URLSession.shared.request(target: .characters(pageSize, offset, searchQuery), expecting: ModelCharacter.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

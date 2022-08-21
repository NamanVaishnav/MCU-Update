//
//  FetchManager.swift
//  MCU
//
//  Created by Naman Vaishnav on 20/08/22.
//

import Foundation

class FetchManager {
    static let shared: FetchManager = FetchManager()
    private init() { }
    
    /// fetch data from storage service
    /// - Parameters:
    ///   - fetchType: fetch cached type
    ///   - completion: handler retures requested chaced data from storage service layer
    func fetchData(fetchType: CacheDataType, completion: @escaping ( _ arrCharacter: [CharacterResult]) -> Void){
        switch fetchType {
        case .character:
            self.fetchCharacters { arrCharacters in
                completion(arrCharacters)
            }
        case .bookmark, .bookmarks:
            self.fetchBookmarkedCharacters { arrCharacters in
                completion(arrCharacters)
            }
        }
    }
}

//MARK: - FETCH DATA
extension FetchManager {
    /// fetch list of characters
    /// - Parameter completion: handler returns list of characters
    private func fetchCharacters(completion: @escaping (_ arrCharacters: [CharacterResult])-> Void) {
        let storageService = StorageService(dataType: .character)
        storageService.fetchData { arrCharacters in
            completion(arrCharacters)
        }
    }
    
    /// fetch bookmarked characters
    /// - Parameter completion: handler returns bookmarked characters
    private func fetchBookmarkedCharacters(completion: @escaping (_ arrCharacters: [CharacterResult])-> Void) {
        let storageService = StorageService(dataType: .bookmark)
        storageService.fetchData { arrCharacters in
            completion(arrCharacters)
        }
    }
}


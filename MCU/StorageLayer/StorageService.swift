//
//  StorageService.swift
//  MCU
//
//  Created by Naman Vaishnav on 20/08/22.
//

import Foundation

class StorageService {
    internal init(
        dataType: CacheDataType
    ) {
        self.dataType = dataType
    }
    
    let dataType: CacheDataType
    
    /// Store data in user default
    /// - Parameter input: in case of character it will  be and array in case of bookmark it will be and single object
    func storeData<T>(data input: T){
        switch dataType {
        case .character:
            guard let data = input as? [CharacterResult] else { return }
            UDSettings.characters = data
            
        case .bookmark:
            guard let data = input as? CharacterResult else { return }
            if var bookmarks = UDSettings.bookmarks {
                bookmarks.insert(data, at: 0)
                UDSettings.bookmarks = bookmarks
            } else {
                UDSettings.bookmarks = [data]
            }
        case .bookmarks:
            guard let data = input as? [CharacterResult] else { return }
            UDSettings.bookmarks = data
        }
    }
    
    /// Fetch data from user default
    /// - Parameter completion: handler which returns characters or bookmarks
    func fetchData(completion: @escaping (_ arrCharacters: [CharacterResult]) -> Void) {
        switch dataType {
        case .character:
            if let characters = UDSettings.characters {
                completion(characters)
            } else {
                completion([])
            }
        case .bookmark, .bookmarks:
            if let bookmarks = UDSettings.bookmarks {
                completion(bookmarks)
            } else {
                completion([])
            }
        }
    }
}

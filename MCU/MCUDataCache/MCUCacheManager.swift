//
//  CacheManager.swift
//  MCU
//
//  Created by Naman Vaishnav on 20/08/22.
//

import Foundation

enum CacheDataType: String{
    case character
    case bookmark
}

class CacheManager {
    internal init(
        cacheType: CacheDataType,
        characters: [CharacterResult]? = nil,
        bookMark: CharacterResult? = nil
    ) {
        self.cacheType = cacheType
        self.characters = characters
        self.bookMark = bookMark
        storageService = StorageService(dataType: cacheType)
    }
    
    let cacheType: CacheDataType
    let characters: [CharacterResult]?
    let bookMark: CharacterResult?
    let storageService: StorageService
    
    /// Cache data as per supplied cached type
    func cacheData(){
        switch cacheType {
        case .character:
            if let characters = characters {
                self.cacheCharacters(forCharacters: characters)
            } else {
                debugPrint("Please pass characters")
            }
        case .bookmark:
            if let bookMark = bookMark {
                self.cacheBookMarks(forBookMarks: bookMark)
            } else {
                debugPrint("Please pass bookmark")
            }
        }
    }
}

//MARK: - CACHE DATA
extension CacheManager {
    /// chache characters
    /// - Parameter input: character array which needs to be chached
    private func cacheCharacters(forCharacters input: [CharacterResult]){
        storageService.storeData(data: input)
    }
    
    /// chace bookmark
    /// - Parameter input: bookmarked item
    private func cacheBookMarks(forBookMarks input: CharacterResult) {
        storageService.storeData(data: input)
    }
}


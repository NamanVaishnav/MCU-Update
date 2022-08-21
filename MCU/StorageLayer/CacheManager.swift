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
    case bookmarks
}

class CacheManager {
    internal init(
        cacheType: CacheDataType,
        characters: [CharacterResult]? = nil,
        bookMark: CharacterResult? = nil,
        bookMarks: [CharacterResult]? = nil
    ) {
        self.cacheType = cacheType
        self.characters = characters
        self.bookMark = bookMark
        self.bookMarks = bookMarks
        storageService = StorageService(dataType: cacheType)
    }
    
    let cacheType: CacheDataType
    let characters: [CharacterResult]?
    let bookMark: CharacterResult?
    let bookMarks: [CharacterResult]?
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
                self.cacheBookMark(forBookMark: bookMark)
            } else {
                debugPrint("Please pass bookmark")
            }
        case .bookmarks:
            if let bookMarks = bookMarks {
                self.cacheBookMarks(forBookMarks: bookMarks)
            } else {
                debugPrint("Please pass bookmarks")
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
    
    /// chache bookmark
    /// - Parameter input: bookmarked item
    private func cacheBookMark(forBookMark input: CharacterResult) {
        storageService.storeData(data: input)
    }
    
    /// chache bookmarks
    /// - Parameter input: bookmarked item
    private func cacheBookMarks(forBookMarks input: [CharacterResult]) {
        storageService.storeData(data: input)
    }
}


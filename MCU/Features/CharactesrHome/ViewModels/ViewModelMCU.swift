//
//  ViewModelMCU.swift
//  MCU
//
//  Created by Naman Vaishnav on 20/08/22.
//

import Foundation

class ViewModelMCU {
    /// used to determine whether data is being fetch from server or not
    var isFetching: Bool = false
    /// offset will be the integer of amout of data which has been already rendered on UI
    var offset = 0
    /// list of data which are avaliable on server
    var totalListOnServerCount = 0 // it must be returned from server
    /// size of response which we required in single request
    var pageSize = 10 // get 10 objects for instance
    /// list of characters which will be filled from network response
    var arrCharacters: [CharacterResult] = []
    
    
    /// fetch list of MCU characters from network
    /// - Parameters:
    ///   - searchQuery: search reseult which need to be requested by end user
    ///   - completion: handler which will get invoke once response arrived
    func getCharacters(searchCharacter searchQuery: String = "", completion: @escaping (_ arrCharacters:[CharacterResult]) -> Void) {
        // return from function if already fetching list
        guard !isFetching else {return}
        if offset == 0 {
            // empty list for first call i.e offset = 0
            self.arrCharacters.removeAll()
        }
        isFetching = true
        
        let characterWSObj = CharacterWS(pageSize: pageSize, offset: offset, searchQuery: searchQuery)
        
        characterWSObj.fetchCharacters { result in
            self.isFetching = false
            switch result {
            case .success(let objResponse):
                self.totalListOnServerCount = objResponse.data?.total ?? 0
                if let result = objResponse.data?.results {
                    if self.offset == 0 {
                        // fetch response from server for first fetch
                        self.arrCharacters = result
                    } else {
                        // append if already exist ( pagination )
                        self.arrCharacters.append(contentsOf: result)
                    }
                    
                    // MARK: - FETCH COMICS
                    let myGroup = DispatchGroup()
                    for character in self.arrCharacters {
                        myGroup.enter()
                        self.getComicsForCharacterId(forCharacterId: "\(character.id ?? 0)") { arrComics in
                            character.comics = arrComics
                            myGroup.leave()
                        }
                    }

                    myGroup.notify(queue: .main) {
                        //MARK: - check with bookmarked items
                        FetchManager.shared.fetchData(fetchType: .bookmark) { arrCharacter in
                            self.arrCharacters.forEach { item in
                                if arrCharacter.contains(item) {
                                    item.isBookmarked = true
                                }
                            }
                    
                            // perform comopletion
                            completion(self.arrCharacters)
                            // MARK: - CACHE RESPONSE
                            let cacheManager = CacheManager(cacheType: .character, characters: self.arrCharacters)
                            cacheManager.cacheData()
                        }
                    }
                } else {
                    // MARK: - GET CACHED RESPONSE
                    FetchManager.shared.fetchData(fetchType: .character) { arrCharacter in
                        completion(arrCharacter)
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
                // MARK: - GET CACHED RESPONSE
                FetchManager.shared.fetchData(fetchType: .character) { arrCharacter in
                    self.arrCharacters = arrCharacter
                    //MARK: - check with bookmarked items
                    FetchManager.shared.fetchData(fetchType: .bookmark) { arrCharacter1 in
                        self.arrCharacters.forEach { item in
                            if arrCharacter1.contains(item) {
                                item.isBookmarked = true
                            }
                        }
                    }
                    completion(self.arrCharacters)
                }
            }
        }
    }
    
    /// grab comics for supplied character id
    /// - Parameters:
    ///   - characterId: Id of character
    ///   - completion: handler for models of comics
    private func getComicsForCharacterId(forCharacterId characterId: String, completion: @escaping (_ arrComics: [ComicResult]) -> Void){
        let comicWSObj = ComicWS(characterId: characterId)
        comicWSObj.fetchComics { result in
            switch result {
            case .success(let objResponse):
                if let comics = objResponse.data?.results {
                    completion(comics)
                } else {
                    completion([])
                }
            case .failure(let error):
                completion([])
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - BOOKMARK
extension ViewModelMCU {
    /// remove item from bookmark
    func removeBookMark(forCharacter character: CharacterResult) {
        FetchManager.shared.fetchData(fetchType: .bookmark) { arrCharacter in
            var allBookmarks = arrCharacter
            print(allBookmarks.count)
            allBookmarks.removeAll { item in
                item == character
            }
            print(allBookmarks.count)
            
            // cache all bookmarks
            let cacheManager = CacheManager(cacheType: .bookmarks, bookMarks: allBookmarks)
            cacheManager.cacheData()
        }
    }
    
    /// Add item in bookmark
    func addBookMark(forCharacter character: CharacterResult) {
        // cache bookmark
        let cacheManager = CacheManager(cacheType: .bookmark, bookMark: character)
        cacheManager.cacheData()
    }
}

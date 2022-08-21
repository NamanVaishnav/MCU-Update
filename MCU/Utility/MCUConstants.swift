//
//  MCUConstants.swift
//  MCU
//
//  Created by Naman Vaishnav on 20/08/22.
//

import Foundation

/// MCU Constants  relavant to network
enum MCUConstant {
    enum ListPageLimit {
        static let limit = 10
    }
    enum APIUrl {
        static let base_url = "https://gateway.marvel.com/v1/public"
    }
    enum APIPath {
        static let characterList = "/characters"
        static let comicList = "/comics"
    }
    enum APIKey {
        static let publicKey = "4da54995239aec19eaa56ed569ba3e28"//"91f8fe474b907e3478f97fcbe8c979d5"
        static let privateKey = "079d73b69963749fe7a6819cefd0065ed113fd54"//"6828acd63a2c4fbe740f1cee084eb4760f4ac651"
    }
}

/// type of cell which will be rendered on collectionview
enum MCUCellType {
    case skeletonCell
    case normalCell
    case emptyCell
    case searchingCell
    case searchHistoryCell
}

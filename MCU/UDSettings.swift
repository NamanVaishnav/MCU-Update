//
//  UDSettings.swift
//  MCU
//
//  Created by Naman Vaishnav on 21/08/22.
//

import Foundation
class UDSettings {
    class var characters: [CharacterResult]? {
        get {
            do {
                let decoded = UserDefaults.standard[#function] ?? Data()
                let decoder = JSONDecoder()
                let loadedOrderInfo = try decoder.decode([CharacterResult].self, from: decoded)
                return loadedOrderInfo
                
            } catch(let error) {
                print("Failed to convert Characters to Data : \(error.localizedDescription)")
                return nil
            }
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: #function)
            } else {
                do {
                    let encoder = JSONEncoder()
                    let encoded = try encoder.encode(newValue)
                    UserDefaults.standard[#function] = encoded
                    
                } catch(let error) {
                    print("Failed to convert Characters : \(error.localizedDescription)")
                }
            }
        }
    }
    
    class var bookmarks: [CharacterResult]? {
        get {
            do {
                let decoded = UserDefaults.standard[#function] ?? Data()
                let decoder = JSONDecoder()
                let loadedOrderInfo = try decoder.decode([CharacterResult].self, from: decoded)
                return loadedOrderInfo
                
            } catch(let error) {
                print("Failed to convert Characters to Data : \(error.localizedDescription)")
                return nil
            }
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: #function)
            } else {
                do {
                    let encoder = JSONEncoder()
                    let encoded = try encoder.encode(newValue)
                    UserDefaults.standard[#function] = encoded
                    
                } catch(let error) {
                    print("Failed to convert Characters : \(error.localizedDescription)")
                }
            }
        }
    }
}



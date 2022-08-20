//
//  NetworkClass.swift
//  MCU
//
//  Created by Naman Vaishnav on 20/08/22.
//

import Foundation
import CryptoKit


enum Marvel {
    case characters(_ limit: Int,_ offset: Int,_ search: String)
    case comics(_ limit: Int,_ offset: Int,_ search: String,_ dateFilter: String)
}

extension Marvel: TargetType {
    var baseURL: URL {
        return URL(string: MCUConstant.APIUrl.base_url)!
    }
    
    var path: String {
        switch self {
        case .characters: return MCUConstant.APIPath.characterList
        case .comics: return MCUConstant.APIPath.comicList
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .characters, .comics: return .get
        }
    }
    
    var task: URLRequest {
        let ts = "\(Date().timeIntervalSince1970)"
        let hashString = ts+"\(MCUConstant.APIKey.privateKey)"+"\(MCUConstant.APIKey.publicKey)"
        let digest = Insecure.MD5.hash(data: hashString.data(using: .utf8) ?? Data())
        let hash = digest.map {
            String(format: "%02hhx", $0)
        }.joined()
        let authParams = ["apikey": MCUConstant.APIKey.publicKey, "ts": ts, "hash": hash]
        
        switch self {
        case .characters(let limit, let offset, let searchQuery):
            let queryParams = [
                "limit": "\(limit)", "offset": "\(offset)"] + authParams + (searchQuery.count > 0 ? ["nameStartsWith" : searchQuery] : [:])
            let query = queryParams.map { $0.0 + "=" + $0.1 }.joined(separator: "&")
            
            var req = URLRequest(url: URL(string: "\(baseURL)/\(path)?\(query)")!)
            req.httpMethod = method.rawValue
            return req
            
        case .comics(let limit, let offset, let searchQuery, let dateFilter):
            let queryParams = ["format": "comic",
                               "formatType": "comic",
                               "orderBy": "-onsaleDate",
                               "dateDescriptor": dateFilter, //"lastWeek",
                               "limit": "\(limit)",
                               "offset": "\(offset)"
            ] + authParams + (searchQuery.count > 0 ? ["titleStartsWith" : searchQuery] : [:])
            
            let query = queryParams.map { $0.0 + "=" + $0.1 }.joined(separator: "&")
            var req = URLRequest(url: URL(string: "\(baseURL)/\(path)?\(query)")!)
            req.httpMethod = method.rawValue
            return req
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

extension URLSession {
    enum CustomError: Error {
        case invalidUrl
        case invalidData
    }
    
    func request<T: Codable>(
        target: Marvel,
        expecting: T.Type,
        completion: @escaping(Result<T, Error>) -> Void
    ) {
        
        let task = self.dataTask(with: target.task) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                debugPrint(jsonResponse) // Response result
                
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

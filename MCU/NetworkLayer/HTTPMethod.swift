//
//  HTTPMethod.swift
//  MCU
//
//  Created by Naman Vaishnav on 20/08/22.
//

import Foundation

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    /// `GET` method.
    public static let get = HTTPMethod(rawValue: "GET")
    /// `POST` method.
    public static let post = HTTPMethod(rawValue: "POST")
    
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

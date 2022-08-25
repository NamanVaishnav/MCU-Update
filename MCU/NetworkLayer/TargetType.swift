//
//  TargetType.swift
//  MCU
//
//  Created by Naman Vaishnav on 20/08/22.
//

import Foundation

/// The protocol used to define the specifications necessary for a `NetworkProvider`.
public protocol TargetType {

    /// The target's base `URL`.
    var baseURL: URL { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: HTTPMethod { get }

    /// The type of HTTP task to be performed.
    var task: URLRequest { get }

    /// The headers to be used in the request.
    var headers: [String: String]? { get }
}



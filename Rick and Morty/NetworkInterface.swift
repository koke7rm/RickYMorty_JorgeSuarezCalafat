//
//  NetworkInterface.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import Foundation

extension Notification.Name {
    static let loading = Notification.Name("loadingScreen")
}

enum APIErrors: Error {
    case general(Error)
    case json(Error)
    case nonHTTP
    case status(Int)
    case invalidData
    
    var description: String {
        switch self {
        case .general(let error):
            return "General error: \(error)"
        case .json(let error):
            return "JSON Error: \(error)"
        case .nonHTTP:
            return "Non HTTP connection"
        case .status(let int):
            return "Status error: Code \(int)"
        case .invalidData:
            return "Invalid data"
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

let serverURL = URL.baseURL

extension URL {
    static let baseURL = URL(string: "https://rickandmortyapi.com/api")!
    static let getCharacters = serverURL.appending(component: "character")
}

extension URLRequest {
    static func request(url: URL, method: HTTPMethod = .get, query: [String : String] = ["":""]) -> URLRequest {
        var comps = URLComponents(url: url, resolvingAgainstBaseURL: true)
        comps?.queryItems = [URLQueryItem(name: query.keys.first ?? "", value: query.values.first)]
        var request = URLRequest(url: (comps?.url)!)
        request.httpMethod = method.rawValue
        request.addValue("appication/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
}

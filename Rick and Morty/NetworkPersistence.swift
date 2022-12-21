//
//  NetworkPersistence.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import SwiftUI

final class NetworkPersistance {
    
    static let shared = NetworkPersistance()
    
    func getCharacters(page: String) async throws -> Result {
        try await queryJSON(request: .request(url: .getCharacters, query: ["page" : page]), type: Result.self)
    }
    
    func getEpisode(url: String?) async throws -> Episode? {
        guard let url else { return nil }
        return try await queryJSON(request: URLRequest(url: URL(string: url)!), type: Episode?.self)
    }
    
    func queryJSON<T: Codable>(request: URLRequest,
                               type: T.Type,
                               decoder: JSONDecoder = JSONDecoder(),
                               statusOK: Int = 200) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { throw APIErrors.nonHTTP }
            if response.statusCode == statusOK {
                do {
                    return try decoder.decode(T.self, from: data)
                } catch {
                    throw APIErrors.json(error)
                }
            } else {
                throw APIErrors.status(response.statusCode)
            }
        } catch let error as APIErrors {
            throw error
        } catch {
            throw APIErrors.general(error)
        }
    }
}


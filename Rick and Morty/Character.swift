//
//  Character.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import Foundation

struct Result: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
}

struct Character: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let image: URL
    let status: String
    let species: String
    let origin: Origin?
    let type: String
    let gender: String
    let location: Location
    let episode: [String]?
    var isAlive: Bool {
        if status == "Alive" {
            return true
        } else {
            return false
        }
    }
}

struct Origin: Codable, Hashable {
    let name: String
}

struct Location: Codable, Hashable {
    let name: String
}

extension Character {
    static let characterTest = Character(id: 1, name: "Rick Sanchez", image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!, status: "Alive", species: "Human", origin: Origin(name: "Earth (C-137)"), type: "", gender: "Male", location: Location(name: "Citadel of Ricks"), episode: ["https://rickandmortyapi.com/api/episode/1"])
}

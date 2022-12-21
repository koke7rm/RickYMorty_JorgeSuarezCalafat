//
//  Episode.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import Foundation

struct Episode: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let air_date: String
}

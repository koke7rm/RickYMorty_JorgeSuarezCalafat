//
//  Rick_and_MortyTests.swift
//  Rick and MortyTests
//
//  Created by Jorge Suárez on 21/12/22.
//

import XCTest
@testable import Rick_and_Morty

final class Rick_and_MortyTests: XCTestCase {
let persistence = NetworkPersistance.shared
var characters: [Character] = []
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharacters() async throws {
        let characters = try await persistence.getCharacters(page: "1")
        XCTAssertEqual(characters.results.first?.name , "Rick Sanchez")
        XCTAssertEqual(characters.info.count, 826)
        
        
        let episode = try await persistence.getEpisode(url: characters.results.first?.episode?.first)
        XCTAssertEqual(episode?.name, "Pilott")
    }

    func testPerformanceExample() async throws {
        characters = try await persistence.getCharacters(page: "1").results
        measure {
            var characters: [Character] = []
            for character in self.characters {
                characters.append(character)
            }
        }
    }
}

extension URL {
    static let baseURLTest = URL(string: "https://rickandmortyapi.com/api")!
    static let getCharactersTest = serverURL.appending(component: "character")
}

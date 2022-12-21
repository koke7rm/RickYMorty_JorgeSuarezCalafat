//
//  CharactersVM.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import Foundation

final class CharactersVM: ObservableObject {
    let persistance = NetworkPersistance.shared
    
    @Published var loading = false
    @Published var errorMsg = ""
    @Published var characters: [Character] = [.characterTest]
    @Published var search = ""
    
    var currentPage = 1
    var pages = 0
    
    var filterCharacter: [Character] {
        if search.isEmpty {
            return characters
        } else {
            return characters.filter {
                $0.name.lowercased().hasPrefix(search.lowercased())
            }
        }
    }
    
    @MainActor func getCharacters(page: Int) async {
        loading = true
        do {
            let result = try await persistance.getCharacters(page: String(currentPage))
            characters = result.results.sorted() { $0.id < $1.id }
            pages = result.info.pages
            
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
        loading = false
    }
    
    func nextPage() {
        if currentPage <= pages {
            currentPage += 1
        }
        Task {
            await getCharacters(page: currentPage)
        }
    }
    
    func prevPage() {
        if currentPage > 0 {
            currentPage -= 1
        }
        Task {
            await getCharacters(page: currentPage)
        }
    }
    
    func firstPage() {
        currentPage = 1
        Task {
            await getCharacters(page: currentPage)
        }
    }
}

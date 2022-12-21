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
    
    /// Variable calculada que devolverá el array de personajes
    var filterCharacter: [Character] {
        // Si el campo search está vacío devuelve el listado tal cual se obtiene del servicio
        if search.isEmpty {
            return characters
        } else {
            // Si no devuelve las coincidencias 
            return characters.filter {
                $0.name.lowercased().hasPrefix(search.lowercased())
            }
        }
    }
    
    /// Método para obtener los personajes
    @MainActor func getCharacters(page: Int) async {
        loading = true
        do {
            let result = try await persistance.getCharacters(page: String(currentPage))
            
            // guardamos el array de la respuesta ordenado por su id
            characters = result.results.sorted() { $0.id < $1.id }
            pages = result.info.pages
        } catch let error as APIErrors {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
        loading = false
    }
    
    /// Método para obtener la siguiente página de personajes
    func nextPage() {
        if currentPage <= pages {
            currentPage += 1
        }
        Task {
            await getCharacters(page: currentPage)
        }
    }
    
    /// Método para obtener la página anterior de personajes
    func prevPage() {
        if currentPage > 0 {
            currentPage -= 1
        }
        Task {
            await getCharacters(page: currentPage)
        }
    }
    
    /// Método para pasar a la primera página de personajes
    func firstPage() {
        currentPage = 1
        Task {
            await getCharacters(page: currentPage)
        }
    }
}

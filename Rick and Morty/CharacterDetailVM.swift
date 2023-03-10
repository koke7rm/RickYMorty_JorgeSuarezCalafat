//
//  CharacterDetailVM.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import Foundation

final class CharacterDetailVM: ObservableObject {
    let persistance = NetworkPersistance.shared
    
    @Published var loading = false
    @Published var episode: Episode?
    @Published var character: Character
    @Published var errorMsg = ""
    @Published var showAlert = false
    
    init(character: Character) {
        self.character = character
        Task {
            await getEpisode()
        }
    }
    
    /// Método para obtener un episodio
    @MainActor func getEpisode() async {
        loading = true
        do {
            self.episode = try await persistance.getEpisode(url: character.episode?.first)
        } catch let error as APIErrors {
            errorMsg = error.description
            showAlert.toggle()
        } catch {
            errorMsg = error.localizedDescription
            showAlert.toggle()
        }
        loading = false
    }
}

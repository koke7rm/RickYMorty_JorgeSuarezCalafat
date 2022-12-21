//
//  Rick_and_MortyApp.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import SwiftUI

@main
struct Rick_and_MortyApp: App {
    
    @StateObject var charactersVM = CharactersVM()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(charactersVM)
                .task {
                    await charactersVM.getCharacters(page: charactersVM.currentPage)
                }
        }
    }
}


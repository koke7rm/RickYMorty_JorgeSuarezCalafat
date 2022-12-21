//
//  HomeView.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var charactersVM: CharactersVM
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(decorative: "img_logo")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                List(charactersVM.filterCharacter) { character in
                    CharacterCell(character: character)
                        .overlay {
                            NavigationLink(value: character) {
                            }
                        }
                        .listRowSeparator(.hidden)
                }
                .scrollContentBackground(.hidden)
                .background(Color.blueMain)
                .listRowBackground(Color.blueMain)
                .searchable(text: $charactersVM.search)
                .navigationDestination(for: Character.self) { character in
                    CharacterDetailView(characterDetailVM: CharacterDetailVM(character: character))
                }
                pageButtons
            }
        }
    }
    
    var pageButtons: some View {
        HStack {
            PageButton(text: "Prev") {
                charactersVM.prevPage()
            }
            .opacity(charactersVM.currentPage > 1 ? 1 : 0)
            Spacer()
            PageButton(text: "First page") {
                charactersVM.firstPage()
            }
            Spacer()
            PageButton(text: "Next") {
                charactersVM.nextPage()
            }
            .opacity(charactersVM.currentPage != charactersVM.pages ? 1 : 0)
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static let charactersVM = CharactersVM()
    static var previews: some View {
        HomeView()
            .environmentObject(charactersVM)
            .task {
                await charactersVM.getCharacters(page: charactersVM.currentPage)
            }
    }
}

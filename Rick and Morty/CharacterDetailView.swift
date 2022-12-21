//
//  CharacterDetailView.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @ObservedObject var characterDetailVM: CharacterDetailVM
    
    var body: some View {
        ZStack {
            Image(decorative: "img_backDetail")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width)
                .ignoresSafeArea(edges: .bottom)
            ScrollView {
                VStack(spacing: 8) {
                    topInfo
                    detailInfo
                }
                .background(Color.white)
                .cornerRadius(20)
            }
            .padding(.top, 60)
            .padding()
            .alert("Connection error", isPresented: $characterDetailVM.showAlert) {
                Button(action: {}) {
                    Text("OK")
                }
            } message: {
                Text(characterDetailVM.errorMsg)
            }
            .overlay {
                if characterDetailVM.loading {
                    LoaderView()
                        .transition(.opacity)
                }
            }
        }
        .navigationTitle("Character Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var topInfo: some View {
        VStack {
            AsyncImage(url: characterDetailVM.character.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
                    .clipShape(Circle())
                    .padding()
                    .shadow(color: .black, radius: 6, x: 0, y: 4)
                
            } placeholder: {
                Image(systemName: "person.cirle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
                    .padding()
                    .shadow(color: .black, radius: 6, x: 0, y: 4)
            }
            
            Text(characterDetailVM.character.name)
                .font(.title)
                .bold()
            
            HStack {
                Image(systemName: "smallcircle.filled.circle.fill")
                    .foregroundColor(characterDetailVM.character.isAlive ? .green : .red )
                Text(" \(characterDetailVM.character.status) - \(characterDetailVM.character.species)")
            }
        }
        .padding()
    }
    
    var detailInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            FieldChapterInfo(titleText: "Origin:", infoText: characterDetailVM.character.origin?.name ?? "-")
            FieldChapterInfo(titleText: "Type:", infoText: characterDetailVM.character.type)
            FieldChapterInfo(titleText: "Gender:", infoText: characterDetailVM.character.gender)
            FieldChapterInfo(titleText: "Last know location:", infoText: characterDetailVM.character.location.name)
            FieldChapterInfo(titleText: "First seen in:", infoText: characterDetailVM.episode?.name ?? "-")
        }
        .padding()
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(characterDetailVM: CharacterDetailVM(character: .characterTest))
    }
}

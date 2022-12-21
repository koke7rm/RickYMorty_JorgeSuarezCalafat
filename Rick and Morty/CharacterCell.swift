//
//  CharacterCell.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import SwiftUI

struct CharacterCell: View {
    let character: Character
    
    var body: some View {
        Rectangle()
            .cornerRadius(8)
            .frame(height: 100)
            .foregroundColor(.white)
            .shadow(color: .black, radius: 6, x: 0, y: 4)
            .overlay {
                HStack {
                    AsyncImage(url: character.image) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                            .frame(height: 100)
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.headline)
                        HStack {
                            Image(systemName: "smallcircle.filled.circle.fill")
                                .foregroundColor(character.isAlive ? .green : .red )
                            Text(character.status)
                                .font(.callout)
                        }
                    }
                    Spacer()
                }
                .frame(height: 100)
            }
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(character: .characterTest)
            .previewLayout(.fixed(width: 450, height: 100))
    }
}

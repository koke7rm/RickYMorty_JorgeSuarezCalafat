//
//  PageButton.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import SwiftUI

struct PageButton: View {
    
    let text: String
    let action:() -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(.black)
                .bold()
        }
        .buttonStyle(.bordered)
        .tint(Color.blueMain)
    }
}

struct PageButton_Previews: PreviewProvider {
    static var previews: some View {
        PageButton(text: "Next", action: {})
    }
}

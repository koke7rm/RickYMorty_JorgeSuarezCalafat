//
//  FieldChapterInfo.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import SwiftUI

struct FieldChapterInfo: View {
    
    let titleText: String
    let infoText: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(titleText)
                .bold()
                .textCase(.uppercase)
            if infoText == "" {
                Text("-")
            } else {
                Text(infoText)
            }
        }
    }
}

struct FieldChapterInfo_Previews: PreviewProvider {
    static var previews: some View {
        FieldChapterInfo(titleText: "Gender:", infoText: "Male")
    }
}


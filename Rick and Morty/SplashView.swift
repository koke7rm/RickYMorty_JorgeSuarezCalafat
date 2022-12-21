//
//  SplashView.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import SwiftUI

enum Screens {
    case splash
    case home
}

struct SplashView: View {
    
    @EnvironmentObject var charactersVM: CharactersVM
    @StateObject var monitorNetwork = NetworkStatus()
    
    @State var splashAnimation = false
    @State var screen: Screens = .splash
    
    var body: some View {
        Group {
            switch screen {
            case .splash:
                splash
                    .transition(.move(edge: .leading))
            case .home:
                HomeView()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
        .animation(.default, value: screen)
        .overlay {
            if monitorNetwork.status == .offline {
                AppOfflineView()
                    .transition(.opacity)
            }
        }
    }
    
    var splash: some View {
        ZStack {
            Color.blueMain
            Image(decorative: "img_splash")
            Image(decorative: "img_logo")
                .resizable().scaledToFit()
                .scaledToFit()
                .offset(y: splashAnimation ? 0 : 500)
            
        }
        .ignoresSafeArea()
        .onAppear {
            splashAnimation = true
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
                screen = .home
            }
        }
        .animation(.easeOut(duration: 1), value: splashAnimation)
    }
}

struct SplashView_Previews: PreviewProvider {
    static let charactersVM = CharactersVM()
    static var previews: some View {
        SplashView()
            .environmentObject(charactersVM)
            .task {
                await charactersVM.getCharacters(page: charactersVM.currentPage)
            }
    }
}

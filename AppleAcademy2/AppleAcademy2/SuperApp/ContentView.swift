//
//  ContentView.swift
//  SuperApp
//
//  Created by found on 26/07/24.
//

import SwiftUI

@Observable
class AppState {
    
    var rotas = [
        Rota(nome: "Rota 1", imagem: "praiadofuturo", tipo: .praia, lugares: []),
        Rota(nome: "Rota 2", imagem: "nautico", tipo: .praia, lugares: []),
        Rota(nome: "Rota 3", imagem: "nautico", tipo: .praia, lugares: [])
    ]
    
}

struct ContentView: View {
    
    @State private var appState = AppState()
    
    var body: some View {
        TabView(){
            ExplorarView()
                .tabItem{
                    Label("Explorar", systemImage:"map")
                }
            MinhasRotasView()
                .tabItem{
                    Label("Minhas rotas", systemImage:"list.bullet")
                }
            RotasProntasViews()
                .tabItem{
                    Label("Rotas prontas", systemImage:"location.north.circle")
                }
//            PerfilView()
//                .tabItem{
//                    Label("Perfil", systemImage:"person.crop.circle.fill")
//                }
            }
            .environment(appState)
            .accentColor(.green)
        }
        
    }

#Preview {
    ContentView()
}

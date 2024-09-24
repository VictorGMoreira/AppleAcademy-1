
//  ContentView.swift
//  TourTrack
//
//  Created by found on 02/08/24.
//

@Observable
class Rota: Identifiable {
    let id = UUID()
    var nome: String
    var lugares: [Lugar]
    var isPinned: Bool // Propriedade para fixar a rota
    
    init(nome: String) {
        self.nome = nome
        self.lugares = []
        self.isPinned = false
    }
}


@Observable
class AppState {
    var rotas: [Rota] = []
}

import SwiftUI
struct ContentView: View {
    
    @State var appState = AppState()
    
    var body: some View {
        TabView{
            ExplorarView()
                .tabItem{
                    Label("Explorar", systemImage:"map")
                }
            MinhasRotasView()
                .tabItem{
                    Label("Minhas rotas", systemImage:"square.grid.2x2.fill")
                }
            RotasProntasView()
                .tabItem{
                    Label("Rotas prontas", systemImage:"location.north.circle")
                }
//            PerfilView()
//                .tabItem{
//                    Label("Perfil", systemImage:"person.crop.circle.fill")
//                }
            }
            .accentColor(.green)
            .environment(appState)
        }
    }

#Preview {
    ContentView()
}

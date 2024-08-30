import SwiftUI

enum TiporLugar: String, CaseIterable, Identifiable {
    case todos = "Todos"
    case praia = "Praia"
    case restaurante = "Restaurante"
    case museu = "Museu"
    case parques = "Parques"
    
    var id: String { self.rawValue }
}

@Observable
class Rota: Identifiable {
    let id = UUID()
    let nome: String
    let imagem: String
    let tipo: TiporLugar
    var lugares: [Lugar]
    
    init(nome: String, imagem: String, tipo: TiporLugar, lugares: [Lugar]) {
        self.nome = nome
        self.imagem = imagem
        self.tipo = tipo
        self.lugares = lugares
    }
}


struct ExplorarView: View {
    @State private var searchText = ""
    @State private var filtroSelecionado: TiporLugar = .todos
    
    let lugares = [
        Lugar(nome: "Praia do Futuro", imagem: "praiadofuturo", tipo: .praia),
        Lugar(nome: "Praia do Nautico", imagem: "nautico", tipo: .praia),
        Lugar(nome: "Rasco Steakhouse", imagem: "RestauranteFortaleza", tipo: .restaurante),
        Lugar(nome: "Praia de Iracema", imagem: "iracema", tipo: .praia),
        Lugar(nome: "Praia do Mucuripe", imagem: "orla-de-mucuripe-por", tipo: .praia),
        Lugar(nome: "Praia de Sabiaguaba", imagem: "sabiaguaba", tipo: .praia),
        Lugar(nome: "Praia do Caça e Pesca", imagem: "cacaepesca", tipo: .praia),
        Lugar(nome: "Praia da Barra do Ceará", imagem: "barradoceara", tipo: .praia),
        Lugar(nome: "Praia Abreulândia", imagem: "abreulandia", tipo: .praia),
    ]
    
    var filteredLugares: [Lugar] {
        lugares.filter { (filtroSelecionado == .todos || $0.tipo == filtroSelecionado) &&
                         (searchText.isEmpty || $0.nome.lowercased().contains(searchText.lowercased())) }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {

            VStack {
                FilterBar(selectedFilter: $filtroSelecionado)
                
                    VStack {
                        ForEach(filteredLugares) { lugar in
                            NavigationLink(destination: DetalhesCardView(lugar: lugar)) {
                                CardView(imageName: lugar.imagem, text: lugar.nome)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .navigationTitle("Explorar")
        }
        .searchable(text: $searchText, prompt: "Pesquisar locais")
    }
}



struct ExplorarView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorarView()
            .environment(AppState())
    }
}


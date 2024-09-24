import SwiftUI

enum TipoLugar: String, CaseIterable, Identifiable {
    case todos = "Todos"
    case praia = "Praia"
    case restaurante = "Restaurante"
    case museu = "Museu"
    case parques = "Parques"
    
    var id: String { self.rawValue }
}

struct Lugar: Identifiable {
    let id = UUID()
    let nome: String
    let imagem: String
    let tipo: TipoLugar
}

struct ExplorarView: View {
    @State private var searchText = ""
    @State private var filtroSelecionado: TipoLugar = .todos
    
    let lugares = [
        Lugar(nome: "Praia do Futuro", imagem: "praiadofuturo", tipo: .praia),
        Lugar(nome: "Praia do Nautico", imagem: "nautico", tipo: .praia),
        Lugar(nome: "Praia do Meireles", imagem: "PraiadoMeireles", tipo: .praia),
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
            ZStack(alignment: .top) {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        // Espaço para compensar a barra de filtro fixa
                        Spacer().frame(height: 60)
                        
                        ForEach(filteredLugares) { lugar in
                            NavigationLink(destination: DetalhesCardView(lugar: lugar)) {
                                CardView(imageName: lugar.imagem, text: lugar.nome)
                                    .frame(width: UIScreen.main.bounds.width - 40) // Ajuste de largura do card
                                    .padding(.horizontal) // Espaçamento horizontal dos cards
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        // Espaçamento inferior para rolagem confortável
                        Spacer().frame(height: 80)
                    }
                }
                
                // Barra de filtro fixa no topo
                VStack {
                    FilterBar(selectedFilter: $filtroSelecionado)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                // Traz a barra de filtro para frente
            }
            .navigationTitle("Explorar")
        }
        .searchable(text: $searchText, prompt: "Pesquisar locais")
    }
}

struct FilterBar: View {
    @Binding var selectedFilter: TipoLugar
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(TipoLugar.allCases) { tipo in
                    Button(action: {
                        selectedFilter = tipo
                    }) {
                        Text(tipo.rawValue)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(selectedFilter == tipo ? Color(red: 0.169, green: 0.377, blue: 0.301) : Color.green.opacity(0.2))
                            .foregroundColor(selectedFilter == tipo ? .white : .black)
                            .cornerRadius(15)
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

struct CardView: View {
    var imageName: String
    var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .cornerRadius(10)
                .clipped() // Para cortar a imagem em excesso
            
            Text(text)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(8)
        }
        .background(Color(red: 0.169, green: 0.377, blue: 0.301))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ExplorarView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorarView()
    }
}

import SwiftUI

struct lugar: Identifiable {
    var id = UUID()
    var nome: String
    var imagem: String
    var tipo: Tipo
}

enum Tipo {
    case praia
}

struct CardView2: View {
    var imageName: String
    var text: String
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            ZStack(alignment: .topTrailing) {
                Image(imageName)
                    .resizable()
                    .cornerRadius(10)
            }
            Text(text)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.vertical, 8)
                .padding(.leading, 50)
        }
        .background(Color(red: 0.169, green: 0.377, blue: 0.301))
        .cornerRadius(25)
        .shadow(radius: 5)
        .contextMenu {
            Button(action: {
                // Chama a closure de exclusão
                onDelete()
            }) {
                Label("Deletar", systemImage: "trash")
            }
            
            Button(action: {
                print("Fixar")
            }) {
                Label("Fixar", systemImage: "pin")
            }
            
            Button(action: {
                print("Renomear")
            }) {
                Label("Renomear", systemImage: "pencil")
            }
        }
    }
}

struct MinhasRotasView: View {
    
//    @State private var appState = AppState()
    @Environment(AppState.self) var appState
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(appState.rotas) { rota in
                            CardView2(
                                imageName: rota.imagem,
                                text: rota.nome,
                                onDelete: {
                                    // Remove o lugar da lista
                                    if let index = appState.rotas.firstIndex(where: { $0.id == rota.id }) {
                                        appState.rotas.remove(at: index)
                                    }
                                }
                            )
                            .aspectRatio(1, contentMode: .fit)
                            .onTapGesture {
                                print("Card clicado!")
                                print("lugares na rota = \(rota.lugares.count)")
                                // Adicione ação aqui para quando o card for clicado
                            }
                        }
                    }
                    .padding(35)
                }
                Button(action: {
                    // Adicione a ação para criar uma nova rota aqui
                    print("Criar nova rota")
                }) {
                    Text("Criar Rota")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 20)
                }
            }
            .navigationTitle("Minhas rotas")
        }
    }
}

#Preview {
    MinhasRotasView()
        .environment(AppState())
}


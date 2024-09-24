import SwiftUI

struct CardView2: View {
    var imageName: String
    var rota: Rota
    var onEdit: (Rota) -> Void
    var onDelete: (Rota) -> Void
    var onPin: (Rota) -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
            ZStack(alignment: .topLeading) {
                Image(rota.lugares.first?.imagem ?? imageName)
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(10)
                    .frame(width: 150, height: 150)
                    .clipped()
                
                if rota.isPinned {
                    Image(systemName: "pin.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(45))
                        .padding(5)
                }
            }
            
            Text(rota.nome)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.vertical, 8)
                .padding(.leading, 10)
        }
        .background(Color(red: 0.169, green: 0.377, blue: 0.301))
        .cornerRadius(25)
        .shadow(radius: 5)
        .contextMenu {
            Button(action: { onEdit(rota) }) {
                Label("Editar", systemImage: "pencil")
            }
            Button(action: { onPin(rota) }) {
                Label(rota.isPinned ? "Desafixar" : "Fixar", systemImage: "pin")
            }
            Button(action: { onDelete(rota) }) {
                Label("Deletar", systemImage: "trash")
            }
        }
    }
}

struct MinhasRotasView: View {
    @Environment(AppState.self) var appState
    @State private var rotaParaEditar: Rota? = nil
    @State private var isShowingDeleteAlert = false
    @State private var rotaParaExcluir: Rota? = nil

    var body: some View {
        NavigationStack {
            VStack {
                if appState.rotas.isEmpty {
                    // Se não houver rotas, exibe o texto informativo
                    VStack {
                        Spacer()
                        Image(systemName: "plus.app")
                            .font(.system(size: 90)) // Tamanho ajustado
                            .foregroundColor(.gray)
                            .padding(10)
                            .opacity(0.4)
                        Text("Para adicionar uma rota, clique no botão '+' acima.")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 80)
                            .opacity(0.4)
                        Spacer()
                    }
                } else {
                    // Exibe as rotas caso existam
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(appState.rotas) { rota in
                                NavigationLink(destination: DetalhesRotaView(rota: rota)) {
                                    CardView2(
                                        imageName: "defaultImage",
                                        rota: rota,
                                        onEdit: { rota in
                                            rotaParaEditar = rota
                                        },
                                        onDelete: { rota in
                                            rotaParaExcluir = rota
                                            isShowingDeleteAlert = true
                                        },
                                        onPin: { rota in
                                            if let index = appState.rotas.firstIndex(where: { $0.id == rota.id }) {
                                                appState.rotas[index].isPinned.toggle() // Alterna a fixação

                                                if appState.rotas[index].isPinned {
                                                    // Move a rota para a posição logo antes da primeira rota fixada
                                                    movePinnedRotaToCorrectPosition(from: index)
                                                }
                                            }
                                        }
                                    )
                                    .aspectRatio(1, contentMode: .fit)
                                }
                            }
                        }
                        .padding(20)
                    }
                }
            }
            .navigationTitle("Minhas rotas")
            // Botão mais que navega para a tela de criação
            .navigationBarItems(trailing:
                NavigationLink(destination: CriarMinhasRotasView { nomeRota in
                    let novaRota = Rota(nome: nomeRota)
                    appState.rotas.append(novaRota)
                    print("Nova rota \(nomeRota) criada!")
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))  // Ícone de tamanho 24 e bold
                        .foregroundColor(.green)  // Cor verde para consistência
                }
            )
            .sheet(item: $rotaParaEditar) { rota in
                EditarRotaView(rota: rota) { novoNome in
                    if let index = appState.rotas.firstIndex(where: { $0.id == rota.id }) {
                        appState.rotas[index].nome = novoNome
                    }
                }
            }
            .alert(isPresented: $isShowingDeleteAlert) {
                Alert(
                    title: Text("Excluir rota"),
                    message: Text("Tem certeza que deseja excluir esta rota?"),
                    primaryButton: .destructive(Text("Excluir")) {
                        if let rota = rotaParaExcluir {
                            if let index = appState.rotas.firstIndex(where: { $0.id == rota.id }) {
                                appState.rotas.remove(at: index)
                            }
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    // Função para mover a rota fixada para a posição correta
    private func movePinnedRotaToCorrectPosition(from index: Int) {
        let pinnedRota = appState.rotas.remove(at: index)
        
        // Verifica a primeira posição onde existe uma rota fixada
        if let firstPinnedIndex = appState.rotas.firstIndex(where: { $0.isPinned }) {
            appState.rotas.insert(pinnedRota, at: firstPinnedIndex)
        } else {
            // Caso não haja nenhuma rota fixada, insere na primeira posição
            appState.rotas.insert(pinnedRota, at: 0)
        }
    }
}

struct MinhasRotasView_Previews: PreviewProvider {
    static var previews: some View {
        MinhasRotasView()
            .environment(AppState())
    }
}

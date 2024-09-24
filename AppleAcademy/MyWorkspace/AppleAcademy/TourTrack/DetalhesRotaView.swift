import SwiftUI

struct DetalhesRotaView: View {
    @Environment(AppState.self) var appState
    var rota: Rota
    @State private var showDeleteConfirmation = false
    @State private var lugarToDelete: Lugar? = nil

    var body: some View {
        VStack(spacing: 0) {
            // Parte rolável com ScrollView
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Exibir os lugares da rota
                    ForEach(rota.lugares) { lugar in
                        VStack(alignment: .leading, spacing: 0.0) {
                            Image(lugar.imagem)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 40, height: 150)
                                .cornerRadius(10)
                            
                            Text(lugar.nome)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(8)
                        }
                        .background(Color(red: 0.169, green: 0.377, blue: 0.301))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .onLongPressGesture {
                            lugarToDelete = lugar
                            showDeleteConfirmation = true
                        }
                    }
                    
                    // Espaçamento adicional para permitir rolagem completa acima do botão
                    Spacer().frame(height: 100)
                }
                .padding(.vertical)
            }
            
            // Botão fixo na parte inferior
            Button(action: {
                // Ação do botão
            }) {
                Text("Montar Rota")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom, 20) // Espaço abaixo do botão
        }
        .navigationTitle(rota.nome)
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("Excluir Lugar"),
                message: Text("Tem certeza de que deseja excluir \(lugarToDelete?.nome ?? "este lugar")?"),
                primaryButton: .destructive(Text("Excluir")) {
                    if let lugarToDelete = lugarToDelete {
                        if let index = rota.lugares.firstIndex(where: { $0.id == lugarToDelete.id }) {
                            rota.lugares.remove(at: index)
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct DetalhesRotaView_Previews: PreviewProvider {
    static var previews: some View {
        DetalhesRotaView(rota: Rota(nome: "Rota de Teste"))
            .environment(AppState())
    }
}

import SwiftUI

struct MinhasRotaView: View {
    @State private var mostrandoCriarRotaView = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Button(action: {
                    mostrandoCriarRotaView = true
                }) {
                    VStack {
                        Image(systemName: "plus")
                            .font(.system(size: 50))
                            .foregroundColor(Color(UIColor.systemGray3))
                        
                        Text("Criar novas rotas")
                            .foregroundColor(Color(UIColor.systemGray3))
                            .font(.title3)  // Ajuste o tamanho da fonte conforme necessário
                    }
                    .padding()
                }
                .background(Color.clear)
                
                Spacer()
            }
            .navigationTitle("Minhas Rotas")
            .sheet(isPresented: $mostrandoCriarRotaView) {
                CriarMinhasRotasView(onCreate: <#(String) -> Void#>)
            }
        }
    }
}

struct CriarMinhasRotasView: View {
    var body: some View {
        Text("Tela de criação de rotas")
    }
}

struct MinhasRotasView_Previews: PreviewProvider {
    static var previews: some View {
        MinhasRotasView()
    }
}


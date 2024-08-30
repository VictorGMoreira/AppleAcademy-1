import SwiftUI


struct RotasProntasViews: View {
    
    let lugar = [
        Lugar(nome: "Rota Gastronômica", imagem: "gastronomica", tipo: .praia),
        Lugar(nome: "Rota Cultural", imagem: "cultural", tipo: .praia),
        Lugar(nome: "Rota Praias", imagem: "nautico", tipo: .praia),
        Lugar(nome: "Rota Teatros", imagem: "teatros", tipo: .praia),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(lugar.indices, id: \.self) { index in
                        CardView3(imageName: lugar[index].imagem, text: lugar[index].nome)
                            .onTapGesture {
                                // Adicione ação aqui para quando o card for clicado
                                print("Card clicado!")
                            }
                        
                        // Adiciona um Divider após cada card, exceto o último
                        if index < lugar.count - 1 {
                            Divider()
                        }
                    }
                }
                .padding(15)
            }
            .navigationTitle("Rotas prontas")
        }
    }
}

#Preview {
    RotasProntasViews()
}


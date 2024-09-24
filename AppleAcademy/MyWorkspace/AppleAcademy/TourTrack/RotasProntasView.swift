import SwiftUI

struct CardView3: View {
    var imageName: String
    var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(imageName)
                    .resizable()
                    .cornerRadius(10)
                    .frame(width: 130, height: 130)
                    .padding(5)
                VStack(alignment: .leading) {
                    Text(text)
                        .font(.headline)
                        .accentColor(.green)
                    Text("Nesta rota você vai visitar os melhores restaurantes de Fortaleza e conhecer nossa culinária.")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .padding(.vertical, 1)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct RotasProntasView: View {
    
    let lugar = [
        Lugar(nome: "Rota Gastronômica", imagem: "gastronomica", tipo: .praia),
        Lugar(nome: "Rota Cultural", imagem: "cultural", tipo: .praia),
        Lugar(nome: "Rota Praias", imagem: "nautico", tipo: .praia),
        Lugar(nome: "Rota Teatros", imagem: "teatro", tipo: .praia),
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
    RotasProntasView()
}

import SwiftUI

struct EditarRotaView: View {
    var rota: Rota
    var onSave: (String) -> Void
    
    @State private var nome: String
    private let maxCharacters = 10 // Limite de caracteres

    init(rota: Rota, onSave: @escaping (String) -> Void) {
        self.rota = rota
        self.onSave = onSave
        _nome = State(initialValue: rota.nome)
    }
    
    var body: some View {
        VStack {
            Text("Editar Nome da Rota")
                .font(.headline)
                .padding()
            
            TextField("Novo nome", text: $nome)
                .padding()
                .background(Color.white.opacity(0.1))
                .onReceive(nome.publisher.collect()) {
                    let newText = String($0.prefix(maxCharacters)) // Limita o texto
                    if newText != nome {
                        nome = newText
                    }
                }
            Spacer()
            
            // Botão "Salvar" com o mesmo estilo do botão "Criar"
            Button(action: {
                onSave(nome)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Salvar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 98/255, green: 171/255, blue: 63/255))
                    .cornerRadius(30)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .presentationDetents([.fraction(0.5)]) // Ajusta o tamanho da sheet
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.169, green: 0.377, blue: 0.301), Color.white]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
    
    @Environment(\.presentationMode) private var presentationMode
}

struct EditarRotaView_Previews: PreviewProvider {
    static var previews: some View {
        EditarRotaView(rota: Rota(nome: "Rota de Teste")) { _ in }
    }
}

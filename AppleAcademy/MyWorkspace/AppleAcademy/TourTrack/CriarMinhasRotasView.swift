import SwiftUI

struct CriarMinhasRotasView: View {
    @State private var nomeRota: String = ""
    var onCreate: (String) -> Void
    @Environment(\.presentationMode) var presentationMode
    private let maxCharacters = 10 // Limite de caracteres

    var body: some View {
        VStack {
            Spacer()

            Image(systemName: "map")
                .font(.system(size: 50))
                .frame(width: 90, height: 90)
                .foregroundColor(.white)
                .background(Color(red: 0.169, green: 0.377, blue: 0.301))
                .clipShape(Circle())

            Text("Escolha um nome para a sua rota:")
                .font(.title2)
                .padding(.top, 20)

            TextField("", text: $nomeRota)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .padding(.top, 20)
                .padding(.horizontal, 40)
                .onReceive(nomeRota.publisher.collect()) {
                    let newText = String($0.prefix(maxCharacters)) // Limita o texto
                    if newText != nomeRota {
                        nomeRota = newText
                    }
                }

            Spacer()

            Button(action: {
                onCreate(nomeRota)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Criar")
                    .font(.title2)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.169, green: 0.377, blue: 0.301))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            .padding(.bottom, 40)
            .disabled(nomeRota.isEmpty)
            .opacity(nomeRota.isEmpty ? 0.5 : 1.0)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.169, green: 0.377, blue: 0.301), Color.white]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct CriarMinhasRotasView_Previews: PreviewProvider {
    static var previews: some View {
        CriarMinhasRotasView { _ in }
    }
}

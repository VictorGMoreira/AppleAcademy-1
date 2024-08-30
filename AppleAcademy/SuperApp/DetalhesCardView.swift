import SwiftUI

// Definição do modelo Lugar e TipoLugar
struct Lugar2 {
    let nome: String
    let imagem: String
    let tipo: TipoLugar2
}

enum TipoLugar2 {
    case praia
    case parque
    case museu
}

struct DetalhesCardView: View {
    
    
    
    let lugar: Lugar
    
    @State private var selectedTab: String = "Sobre"
    @State private var showingSheet: Bool = false  // Estado para controlar a apresentação do sheet
    
    var descricao: String {
        switch lugar.nome {
        case "Praia do Futuro":
            return "Uma das praias mais famosas de Fortaleza, conhecida por suas barracas e ambiente animado."
        case "Praia do Nautico":
            return "Ótima praia para relaxar com uma vista linda e águas calmas."
        case "Praia do Meireles":
            return "Praia urbana com excelente infraestrutura e vida noturna vibrante."
        case "Praia de Iracema":
            return "Famosa por suas ondas e atividades culturais ao redor."
        case "Praia do Mucuripe":
            return "Conhecida pelo porto pesqueiro e suas barracas de frutos do mar."
        case "Praia de Sabiaguaba":
            return "Um lugar tranquilo ideal para quem busca sossego e beleza natural."
        case "Praia do Caça e Pesca":
            return "Praia exclusiva e isolada, perfeita para quem gosta de privacidade."
        case "Praia da Barra do Ceará":
            return "Praia familiar com uma boa infraestrutura para todos."
        case "Praia Abreulândia":
            return "Praia com águas claras e tranquilas, ideal para famílias."
        default:
            return "Descrição não disponível."
        }
    }
    
    var endereco: String {
        switch lugar.nome {
        case "Praia do Futuro":
            return "Av. Clóvis Arraes, 999, Fortaleza - CE"
        case "Praia do Nautico":
            return "Av. Beira Mar, 5000, Fortaleza - CE"
        case "Praia do Meireles":
            return "Av. Meireles, 1000, Fortaleza - CE"
        case "Praia de Iracema":
            return "Av. Hist. Ribeiro dos Santos, 1500, Fortaleza - CE"
        case "Praia do Mucuripe":
            return "Av. Vicente de Castro, 2000, Fortaleza - CE"
        case "Praia de Sabiaguaba":
            return "Av. Sabiaguaba, 3000, Fortaleza - CE"
        case "Praia do Caça e Pesca":
            return "Rua dos Pescadores, 4000, Fortaleza - CE"
        case "Praia da Barra do Ceará":
            return "Av. Barão de Studart, 5000, Fortaleza - CE"
        case "Praia Abreulândia":
            return "Rua Abreulândia, 6000, Fortaleza - CE"
        default:
            return "Endereço não disponível."
        }
    }
    
    var acessibilidade: String {
        switch lugar.nome {
        case "Praia do Futuro":
            return "Rampas; Elevadores; Corrimãos"
        case "Praia do Nautico":
            return "Rampas; Acessos para cadeirantes; Banheiros adaptados"
        case "Praia do Meireles":
            return "Rampas; Passarelas; Banheiros adaptados"
        case "Praia de Iracema":
            return "Rampas; Acessos facilitados; Banheiros adaptados"
        case "Praia do Mucuripe":
            return "Rampas; Corrimãos; Acesso fácil ao porto"
        case "Praia de Sabiaguaba":
            return "Rampas; Acessos para cadeirantes; Banheiros adaptados"
        case "Praia do Caça e Pesca":
            return "Rampas; Acessos limitados; Sem infraestrutura completa"
        case "Praia da Barra do Ceará":
            return "Rampas; Acessos facilitados; Banheiros adaptados"
        case "Praia Abreulândia":
            return "Rampas; Acessos para cadeirantes; Banheiros adaptados"
        default:
            return "Informações de acessibilidade não disponíveis."
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(lugar.imagem)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(lugar.nome)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack {
                        HStack(spacing: 2) {
                            ForEach(0..<4) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            Image(systemName: "star.leadinghalf.filled")
                                .foregroundColor(.yellow)
                        }
                        Text("4,5")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                }
   
                HStack {
                    Button(action: {
                        selectedTab = "Sobre"
                    }) {
                        Text("Sobre")
                            .foregroundColor(selectedTab == "Sobre" ? .white : .gray)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(selectedTab == "Sobre" ? Color.green : Color.gray.opacity(0.2))
                            .cornerRadius(20)
                    }
                    
                    Button(action: {
                        selectedTab = "Avaliações"
                    }) {
                        Text("Avaliações")
                            .foregroundColor(selectedTab == "Avaliações" ? .white : .gray)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(selectedTab == "Avaliações" ? Color.green : Color.gray.opacity(0.2))
                            .cornerRadius(20)
                    }
                    
                    Button(action: {
                        selectedTab = "Fotos"
                    }) {
                        Text("Fotos")
                            .foregroundColor(selectedTab == "Fotos" ? .white : .gray)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(selectedTab == "Fotos" ? Color.green : Color.gray.opacity(0.2))
                            .cornerRadius(20)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    switch selectedTab {
                    case "Sobre":
                        Text("Descrição:")
                            .font(.headline)
                        Text(descricao)
                            .font(.body)
                        
                        Text("Endereço:")
                            .font(.headline)
                        Text(endereco)
                            .font(.body)
                        
                        Text("Acessibilidade:")
                            .font(.headline)
                        Text(acessibilidade)
                            .font(.body)
                        
                    case "Avaliações":
                        Text("Avaliações")
                            .font(.headline)
                        Text("Aqui você pode adicionar as avaliações dos usuários sobre o lugar.")
                            .font(.body)
                        
                    case "Fotos":
                        Text("Fotos")
                            .font(.headline)
                        Text("Aqui você pode adicionar uma galeria de fotos do lugar.")
                            .font(.body)
                        
                    default:
                        Text("Selecione uma opção acima.")
                            .font(.body)
                    }
                }
                
                Button(action: {
                    showingSheet.toggle()  // Mostrar o sheet
                }) {
                    Text("Adicionar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.vertical)
                .padding(.top) // Adiciona padding no topo
                .sheet(isPresented: $showingSheet) {
                    AdicionarLugarSheet(lugarAtual: lugar)  // Mostrar a sheet com o lugar atual
                }
            }
            .padding()
        }
        .navigationBarTitle("Informações", displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            // Adicionar ação
        }) {
            // Botão de ação
        })
    }
}

struct AdicionarLugarSheet: View {
    
    // Acessar as rotas
    @Environment(AppState.self) var appState
    
    let lugarAtual: Lugar
    
    @Environment(\.dismiss) var dismiss  // Para fechar o sheet
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                Button(action: {
                    dismiss()  // Fechar o sheet
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title)
                        .padding(.leading)
                        .padding(.top)
                }
                Spacer()
            }
            
            HStack {
                Image(lugarAtual.imagem) // Imagem do lugar atual
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    Text(lugarAtual.nome) // Nome do lugar atual
                        .font(.headline)
                    Text("Praias")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            Text("Adicionar à:")
                .font(.headline)
                .padding(.horizontal)
            
            HStack(spacing: 16) { // Espaçamento entre os botões
                ForEach(appState.rotas) { rota in
                    VStack {
                        Button(action: {
                            // adicionando na rota
                            rota.lugares.append(lugarAtual)
                        }) {
                            Image(rota.imagem)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        }
                        Text(rota.nome)
                            .font(.subheadline)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .presentationDetents([.fraction(0.5)])
    }
}


struct DetalhesCardView_Previews: PreviewProvider {
    static var previews: some View {
        DetalhesCardView(lugar: Lugar(nome: "Praia do Futuro", imagem: "praiadofuturo", tipo: .praia))
            .environment(AppState())
    }
}

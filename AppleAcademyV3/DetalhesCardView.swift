import SwiftUI

// Definição do modelo Lugar e TipoLugar
struct LugarDetalhesCard{
    let nome: String
    let imagem: String
    let tipo: TipoLugarDetalhes
}

enum TipoLugarDetalhes {
    case praia
    case parque
    case museu
}

// Definição das estruturas Avaliacao e Foto
struct Avaliacao: Identifiable {
    let id = UUID()
    let nome: String
    let comentario: String
    let imagem: String
    let rating: Int
}

struct Foto: Identifiable {
    let id = UUID()
    let imagem: String
    let descricao: String
}

struct DetalhesCardView: View {
    let lugar: Lugar
    
    @State private var selectedTab: String = "Sobre"
    @State private var showingSheet: Bool = false  // Estado para controlar a apresentação do sheet
    
    var avaliacoes: [Avaliacao] {
        switch lugar.nome {
        case "Praia do Futuro":
            return [
                Avaliacao(nome: "João", comentario: "Ótima praia, muito limpa e com boa estrutura.", imagem: "joao", rating: 5),
                Avaliacao(nome: "Maria", comentario: "Excelente para passar o dia com a família!", imagem: "maria", rating: 4),
                Avaliacao(nome: "João", comentario: "Ótima praia, muito limpa e com boa estrutura.", imagem: "joao", rating: 5),
                Avaliacao(nome: "João", comentario: "Ótima praia, muito limpa e com boa estrutura.", imagem: "joao", rating: 5),
                Avaliacao(nome: "João", comentario: "Ótima praia, muito limpa e com boa estrutura.", imagem: "joao", rating: 5),
                Avaliacao(nome: "João", comentario: "Ótima praia, muito limpa e com boa estrutura.", imagem: "joao", rating: 5),
                
            ]
        default:
            return []
        }
    }
    
    var fotos: [Foto] {
        switch lugar.nome {
        case "Praia do Futuro":
            return [
                Foto(imagem: "praia_do_futuro_1", descricao: "Praia ao amanhecer"),
                Foto(imagem: "praia_do_futuro_2", descricao: "Vista panorâmica das barracas")
            ]
        default:
            return []
        }
    }
    
    var descricao: String {
        switch lugar.nome {
        case "Praia do Futuro":
            return "Uma das praias mais famosas de Fortaleza, conhecida por suas barracas e ambiente animado."
        default:
            return "Descrição não disponível."
        }
    }
    
    var endereco: String {
        switch lugar.nome {
        case "Praia do Futuro":
            return "Av. Clóvis Arraes, 999, Fortaleza - CE"
        default:
            return "Endereço não disponível."
        }
    }
    
    var acessibilidade: String {
        switch lugar.nome {
        case "Praia do Futuro":
            return "Rampas; Elevadores; Corrimãos"
        default:
            return "Informações de acessibilidade não disponíveis."
        }
    }
    
    var body: some View {
        VStack {
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
                                        .imageScale(.small)
                                }
                                Image(systemName: "star.leadinghalf.filled")
                                    .foregroundColor(.yellow)
                                    .imageScale(.small)
                            }
                            Text("4,5")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                    }
                    
                    HStack {
                        Button(action: { selectedTab = "Sobre" }) {
                            Text("Sobre")
                                .foregroundColor(selectedTab == "Sobre" ? .white : .gray)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(selectedTab == "Sobre" ? Color.green : Color.gray.opacity(0.2))
                                .cornerRadius(20)
                        }
                        
                        Button(action: { selectedTab = "Avaliações" }) {
                            Text("Avaliações")
                                .foregroundColor(selectedTab == "Avaliações" ? .white : .gray)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(selectedTab == "Avaliações" ? Color.green : Color.gray.opacity(0.2))
                                .cornerRadius(20)
                        }
                        
                        Button(action: { selectedTab = "Fotos" }) {
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
                            if avaliacoes.isEmpty {
                                Text("Nenhuma avaliação disponível.")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            } else {
                                ForEach(avaliacoes) { avaliacao in
                                    AvaliacaoView(avaliacao: avaliacao)
                                        .padding(.bottom, 10)
                                }
                            }
                            
                        case "Fotos":
                            if fotos.isEmpty {
                                Text("Nenhuma foto disponível.")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            } else {
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                    ForEach(fotos) { foto in
                                        FotoCardView(foto: foto)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                        default:
                            Text("Selecione uma opção acima.")
                                .font(.body)
                        }
                    }
                }
                .padding()
            }
            
            // Botão Adicionar à rota fixo
            Button(action: {
                           showingSheet.toggle()
                       }) {
                           Text("Adicionar à rota")
                               .font(.headline)
                                      .foregroundColor(.white)
                                      .frame(maxWidth: .infinity)
                                      .padding()
                                      .background(Color.green) // Fundo do botão
                                      .cornerRadius(40)
                       }
                       .padding(.horizontal, 40) // Para espaçar do lado da tela
                       .padding(.bottom) // Para espaçar da parte inferior
                       .background(Color.clear) // Remove qualquer fundo adicional
                       .sheet(isPresented: $showingSheet) {
                           AdicionarLugarSheet(lugarAtual: lugar)
                       }
                   }
                   .navigationBarTitle("Informações", displayMode: .inline)
               }
           }

struct AvaliacaoView: View {
    let avaliacao: Avaliacao
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(avaliacao.imagem)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(avaliacao.nome)
                    .font(.headline)
                
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < avaliacao.rating ? "star.fill" : "star")
                            .foregroundColor(index < avaliacao.rating ? .yellow : .gray)
                            .imageScale(.small)
                    }
                }
                
                Text(avaliacao.comentario)
                    .font(.body)
                    .foregroundColor(Color.black.opacity(0.8))
            }
        }
        .padding(.vertical, 4)
    }
}

struct FotoCardView: View {
    let foto: Foto
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(foto.imagem)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()
                .cornerRadius(10)
            
            Text(foto.descricao)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(height: 150)
    }
}

struct AdicionarLugarSheet: View {
    @Environment(\.dismiss) var dismiss
    let lugarAtual: Lugar

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title)
                        .padding(.leading)
                        .padding(.top)
                }
                Spacer()
            }
            
            HStack {
                Image(lugarAtual.imagem)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    Text(lugarAtual.nome)
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
            
            ScrollView {
                // Simulação de rotas (substituir pela lógica real)
                let rotas = [Lugar(nome: "Rota 1", imagem: "rota1", tipo: .praia), Lugar(nome: "Rota 2", imagem: "rota2", tipo: .praia)]
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(rotas, id: \.nome) { rota in
                        VStack {
                            Button(action: {
                                print("Adicionado \(lugarAtual.nome) à \(rota.nome)")
                                dismiss()
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
}

struct DetalhesCardView_Previews: PreviewProvider {
    static var previews: some View {
        DetalhesCardView(lugar: Lugar(nome: "Praia do Futuro", imagem: "praiadofuturo", tipo: .praia))
    }
}


//
//  AdicionarLugarSheet.swift
//  SuperApp
//
//  Created by found on 30/08/24.
//

import SwiftUI

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

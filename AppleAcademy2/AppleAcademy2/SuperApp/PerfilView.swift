//
//  PerfilView.swift
//  SuperApp
//
//  Created by found on 26/07/24.
//

import SwiftUI

struct PerfilView: View {
    var body: some View {
        VStack {
            // Imagem do perfil
            Image("lurdinha")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 130)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 3)
                .padding(.top, 20)
            
            // Nome do usuário
            Text("Lurdinha")
                .font(.title)
                .fontWeight(.medium)
                .padding(.top, 2)
            
            // Informações do perfil
            VStack(alignment: .leading, spacing: 10) {
                ProfileRow(icon: "person.fill", title: "Nome Completo:", value: "Lurdes Silva")
                ProfileRow(icon: "envelope.fill", title: "E-mail:", value: "lurdessilva123@gmail.com")
                ProfileRow(icon: "phone.fill", title: "Numero de telefone:", value: "(85) X.XXXX-XXXX")
                ProfileRow(icon: "location.fill", title: "Número de Rotas Feitas:", value: "05")
                ProfileRow(icon: "bookmark.fill", title: "Locais Salvos:", value: "05")
            }
            .padding()
            .background(Color("CustomGreen"))
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color.white)
    }
}

struct ProfileRow: View {
    var icon: String
    var title: String
    var value: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Ícone de lápis no canto superior direito

            // Parte superior (fixa) - Verde
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.leading, 5)
                
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.leading)
            .background(Color(red: 0.169, green: 0.377, blue: 0.301))
            
            // Parte inferior (editável) - Cinza claro
            HStack {
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.leading)
                
                Spacer()
            }
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.2))
        }
        .cornerRadius(8)
    }
}

#Preview {
    PerfilView()
}

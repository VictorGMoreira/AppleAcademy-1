//
//  CardView2.swift
//  SuperApp
//
//  Created by found on 30/08/24.
//

import SwiftUI

struct CardView2: View {
    var imageName: String
    var text: String
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            ZStack(alignment: .topTrailing) {
                Image(imageName)
                    .resizable()
                    .cornerRadius(10)
            }
            Text(text)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.vertical, 8)
                .padding(.leading, 50)
        }
        .background(Color(red: 0.169, green: 0.377, blue: 0.301))
        .cornerRadius(25)
        .shadow(radius: 5)
        .contextMenu {
            Button(action: {
                // Chama a closure de exclusão
                onDelete()
            }) {
                Label("Deletar", systemImage: "trash")
            }
            
            Button(action: {
                print("Fixar")
            }) {
                Label("Fixar", systemImage: "pin")
            }
            
            Button(action: {
                print("Renomear")
            }) {
                Label("Renomear", systemImage: "pencil")
            }
        }
    }
}

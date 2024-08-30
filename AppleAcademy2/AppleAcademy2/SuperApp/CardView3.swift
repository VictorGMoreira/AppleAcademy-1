//
//  CardView3.swift
//  SuperApp
//
//  Created by found on 30/08/24.
//

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


//
//  CardView.swift
//  SuperApp
//
//  Created by found on 30/08/24.
//

import SwiftUI

struct CardView: View {
    var imageName: String
    var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            ZStack(alignment: .topTrailing) {
                Image(imageName)
                    .resizable()
                    .frame(width: 350, height: 150)
                    .cornerRadius(10)
            }
            Text(text)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(8)
        }
        .background(Color(red: 0.169, green: 0.377, blue: 0.301))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

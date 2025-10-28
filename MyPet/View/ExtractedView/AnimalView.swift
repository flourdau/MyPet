//
//  AnimalView.swift
//  MyPet
//
//  Created by apprenant78 on 23/10/2025.
//

import SwiftUI

struct AnimalView: View {
    var animal: Animal
    let icoStarFill = "star.fill"
    let icoStar = "star"
    
    var body: some View {
        VStack (alignment: .center){
            HStack {
                ZStack (alignment: .bottom)  {
                    Rectangle()
                        .cornerRadius(16)
                        .foregroundColor(animal.swiftUIColor)
                        .padding(.top, 72)
                    
                    Image(animal.species.rawValue)
                        .resizable()
                        .scaledToFill()

                }
            }

            HStack {
                Text(animal.name)

                Button {
                    animal.isFavorite.toggle()
                } label: {
                    Image(systemName: animal.isFavorite ? icoStarFill : icoStar)
                }
                .foregroundStyle(.myYellow)
                
            }
            .font(.headline)
            .foregroundColor(.secondary)
            .bold()
            
            Spacer()

        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    AnimalView(animal: animalFake)
}

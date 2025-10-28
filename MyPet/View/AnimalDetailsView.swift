//
//  AnimalDetailsView.swift
//  MyPet
//
//  Created by apprenant78 on 23/10/2025.
//

import SwiftUI

struct AnimalDetailsView: View {
    @Bindable var animal : Animal
    
    var body: some View {
        VStack  {
            BubbleView(note: animal.note)
                .offset(x: 81, y: 81)
                .zIndex(10)

            AnimalView(animal: animal)
                .frame(maxWidth: 250, maxHeight: .infinity )

            TrashButton(animal: animal)
            
            Spacer()

        }
        .padding(24)
        .overlay(alignment: .topTrailing) {
            NavigationLink {
                UpdateAnimalView(animal: animal)
            } label: {
                ZStack {
                    Circle().frame(width: 40)
                        .foregroundColor(.myGreen)

                    Image(systemName: "square.and.pencil")
                        .opacity(0.8)
                        .foregroundColor(.myRed)
                        .font(.system(size: 20))
                        .shadow(radius: 3)

                }
            }
        }
        .padding(.vertical, 64)
        .navigationTitle(animal.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(animal.name)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .toolbarBackground(animal.swiftUIColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    AnimalDetailsView(animal: animalFake)
}

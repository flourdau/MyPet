//
//  UpdateAnimalView.swift
//  MyPet
//
//  Created by apprenant78 on 24/10/2025.
//

import SwiftUI
import SwiftData

struct UpdateAnimalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var animal : Animal
    @State private var name: String = ""
    @State private var note: String = ""
    @State private var pickedColor: Color = .myYellow
    @State private var selectedAnimal: speciesListEnum = .cerf
    
    var body: some View {
        ZStack {
            Form {
                HStack {
                    Spacer()
                    
                    ZStack (alignment: .bottom)  {
                        Rectangle()
                            .cornerRadius(16)
                            .foregroundColor(pickedColor)
                            .padding(.top, 16)
                        
                        Image(selectedAnimal.rawValue)
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(16)
                        
                    }
                    .frame(maxWidth: 128, maxHeight: 128)
                    
                    Spacer()
                    
                }
                
                Section {
                    // Name
                    TextField(animal.name, text: $name)
                    
                    // Especes
                    Picker("Espèce", selection: $selectedAnimal) {
                        ForEach(speciesListEnum.allCases, id: \.self) { animal in
                            Text(animal.rawValue)
                        }
                    }
                    
                    // Color
                    ColorPicker("Couleur", selection: $pickedColor)
                    
                    // Note
                    VStack {
                        TextField("Message", text: $note)
                    }
                    .padding(.top, 16)
                }
                
            }
            .navigationTitle("Modifier")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Enregistrer") {
                        animal.name = name.isEmpty ? animal.name : name
                        animal.note = note.isEmpty ? animal.note : note
                        animal.species = selectedAnimal
                        animal.swiftUIColor = pickedColor
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            name = animal.name
            pickedColor = animal.swiftUIColor
            selectedAnimal = animal.species
        }
    }
    
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Animal.self, configurations: config)
        container.mainContext.insert(animalFake)

        return UpdateAnimalView(animal: animalFake)
            .modelContainer(container)
            
    } catch {
        fatalError("Échec de la création du ModelContainer pour la preview: \(error)")
    }
}

//
//  AddAnimalView.swift
//  MyPet
//
//  Created by apprenant78 on 23/10/2025.
//

import SwiftUI
import SwiftData

struct AddAnimalView: View {
    @Environment(\.modelContext) private var context
    @State private var pickedColor: Color = .myYellow
    @State private var selectedAnimal: speciesListEnum = .panda
    @Binding var selectedTab: TabSelection
    @State private var viewModel = StarWarsNameClass()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Form {
                    Section(header: Text("Informations sur l'animal")) {
                        // Name
                        TextField("Nom de l'animal", text: $viewModel.searchText)
                            .onTapGesture {
                                viewModel.isSearching = true
                            }
                        
                        // Espèces
                        Picker("Espèce", selection: $selectedAnimal) {
                            ForEach(speciesListEnum.allCases, id: \.self) { specie in
                                Text(specie.rawValue)
                            }
                        }
                        
                        // Color
                        ColorPicker("Couleur", selection: $pickedColor)

                    }
                }
                .navigationTitle("Nouvel animal 🐾")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Enregistrer") {
                            let nameToSave = viewModel.searchText.isEmpty ? "AnonymousPet" : viewModel.searchText
                            let newAnimal = Animal(
                                name: nameToSave,
                                species: selectedAnimal,
                                color: pickedColor
                            )
                            
                            context.insert(newAnimal)
                            self.selectedTab = .animalsList
                        }
                    }
                }
                
                if viewModel.isSearching && !viewModel.searchText.isEmpty && !viewModel.filteredPeople.isEmpty {
                    List {
                        ForEach(viewModel.filteredPeople) { person in
                            Button(action: {
                                viewModel.searchText = person.name
                                viewModel.isSearching = false
                            }) {
                                Text(person.name)
                            }
                        }
                    }
                    .frame(height: min(CGFloat(viewModel.filteredPeople.count) * 44, 200))
                    .listStyle(.plain)
                    .background(Color(.systemBackground)) // Recommandé
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .offset(x: 0, y: 92)
                    .shadow(radius: 5)
                }
                
                if !viewModel.isLoading && !viewModel.searchText.isEmpty && viewModel.filteredPeople.isEmpty {
                    Text("Aucun résultat pour \"\(viewModel.searchText)\"")
                        .foregroundColor(.secondary)
                        .padding()
                        .background(.background)
                        .cornerRadius(8)
                        .padding(.top, 50)
                        .shadow(radius: 2)
                        .offset(x: 0, y: 92)
                }
            }
            .onAppear {
                if viewModel.people.isEmpty {
                    viewModel.fetchName()
                }
            }
        }
    }
}

#Preview {
    let fakeAnimal = Animal(name: "Rex", species: .chien, note: "Un chien de test.", color: .blue)
    
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Animal.self, configurations: config)

        container.mainContext.insert(fakeAnimal)
        return AddAnimalView(selectedTab: .constant(.animalsList))
            .modelContainer(container)
        
    } catch {
        fatalError("Échec de la création du ModelContainer pour la preview: \(error)")
    }
}

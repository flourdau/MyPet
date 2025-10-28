//
//  AnimalsListView.swift
//  MyPet
//
//  Created by apprenant78 on 23/10/2025.
//

import SwiftUI
import SwiftData

struct AnimalsListView: View {
    @Environment(\.modelContext) private var context
    @State var showingAlert = false
    @State var showingFavorites: Bool = false
    @State var searchText: String = ""
    @Query var animalsData: [Animal]
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var finalFilteredData: [Animal] {
        let baseList = showingFavorites ? animalsData.filter({ $0.isFavorite }) : animalsData
        
        return searchText.isEmpty ? baseList : baseList.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if (animalsData.isEmpty) {
                    VStack {
                        Spacer()
                        
                        Image("Sorry")
                        
                        Text("Pas d'animaux :'(")
                            .bold()
                            .font(Font.largeTitle)
                        
                        Text("Ajoutez des animaux à votre collection")
                            .font(Font.subheadline)
                        
                        Text("Ou générer une collection")
                            .font(Font.subheadline)
                        
                        Button("Générer") {
                            GenerateAnimalsFunc(context: context)
                        }
                        .foregroundStyle(.white)
                        .padding(24)
                        .background(.pink)
                        .cornerRadius(16)

                        
                        Spacer()
                        
                    }
                }
                else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(finalFilteredData) { animal in
                                NavigationLink {
                                    AnimalDetailsView(animal: animal)
                                } label: {
                                    AnimalView(animal: animal)
                                }
                                
                            }
                        }
                    }
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Rechercher")
                    .navigationTitle("Animals")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                showingFavorites.toggle()
                            } label: {
                                Image(systemName: showingFavorites ? "star.fill" : "star")
                                    .foregroundColor(showingFavorites ? .myYellow : .gray)
                            }
                            .font(Font.title3)

                        }
                    }
                    Button("Supprimer tous les Animaux") {
                        showingAlert = true
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Supprimer !"),
                            message: Text("Etes-vous sûr de vouloir supprimer tous les animaux?"),
                            primaryButton: .destructive(Text("Supprimer")) {
                                ResetDataBaseFunc(context: context)
                            },
                            secondaryButton: .cancel(Text("Annuler"))
                        )
                    }
                    .foregroundColor(.myRed)
                    .bold()
                    .font(Font.title3)
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Animal.self, configurations: config)
        
        GenerateAnimalsFunc(context: container.mainContext)
        return AnimalsListView()
            .modelContainer(container)
        
    } catch {
       fatalError("Échec de la création du ModelContainer pour la preview : \(error)")
    }
}

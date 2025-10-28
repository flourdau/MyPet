//
//  ContentView.swift
//  MyPet
//
//  Created by apprenant78 on 23/10/2025.
//

import SwiftUI
import SwiftData

enum TabSelection {
    case animalsList
    case addAnimal
}

struct ContentView: View {
    @State private var selectedTab: TabSelection = .animalsList
    
    init() {
        let appearance = UITabBarAppearance()
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            AnimalsListView()
                .tabItem {
                    Text("Mes animaux")
                    Image(systemName: "pawprint.fill")
                }
                .tag(TabSelection.animalsList)
            
            AddAnimalView(selectedTab: $selectedTab)
                .tabItem {
                    Text("Ajoutez un animal")
                    Image(systemName: "plus")
                }
                .tag(TabSelection.addAnimal)
            
        }
        .toolbarBackground(.myYellow, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Animal.self, configurations: config)
        
        GenerateAnimalsFunc(context: container.mainContext)
        return ContentView()
            .modelContainer(container)
        
    } catch {
       fatalError("Échec de la création du ModelContainer pour la preview : \(error)")
    }
}

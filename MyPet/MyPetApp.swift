//
//  MyPetApp.swift
//  MyPet
//
//  Created by apprenant78 on 23/10/2025.
//

import SwiftUI
import SwiftData

@main
struct MyPetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Animal.self)
        }
    }
}

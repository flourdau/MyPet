//
//  AnimalDataClass.swift
//  MyPet
//
//  Created by apprenant78 on 23/10/2025.
//

import SwiftUI
import SwiftData

func ResetDataBaseFunc(context: ModelContext) {
    do {
        let fetchDescriptor = FetchDescriptor<Animal>()
        let animalsToDelete = try context.fetch(fetchDescriptor)
        
        for animal in animalsToDelete {
            context.delete(animal)
        }
        print("Base de données Animal réinitialisée avec succès.")
    }
    catch {
        print("Échec de la réinitialisation de la base de données : \(error)")
    }
}



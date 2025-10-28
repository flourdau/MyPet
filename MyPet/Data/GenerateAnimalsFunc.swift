//
//  GenerateAnimals.swift
//  MyPet
//
//  Created by apprenant78 on 28/10/2025.
//

import SwiftUI
import SwiftData

func GenerateAnimalsFunc(context: ModelContext) {
    let sampleAnimals = [
        Animal(name: "Stacy", species: .grenouille, note:"Hello!", color: .pink),
        Animal(name: "Séverine", species:.chat, note:"Chalut",  color: .myRed),
        Animal(name: "Edilene", species: .lapin, color: .myRed),
        Animal(name: "Andrei", species: .chien, color: .myRed),
        Animal(name: "Flood", species: .panda, note:"Yeah!", color: .myRed),
        Animal(isFavorite: true, name: "Billy", species: .cerf, color: .purple),
        Animal(isFavorite: true, name: "Romain", species: .lion, color: .purple),
        Animal(isFavorite: true, name: "Adrien", species: .chat, color: .purple),
        Animal(isFavorite: true, name: "Momo", species: .lion, color: .purple),
        Animal(isFavorite: true, name: "Nabs", species: .lapin, color: .purple),
        Animal(name: "Cindie", species: .vache, note:"Youpi!!",  color: .green),
        Animal(name: "François", species: .singe, color: .green),
        Animal(name: "Laurent", species: .vache, color: .green),
        Animal(name: "Ayoub", species: .singe, color: .green),
        Animal(name: "Laure", species: .grenouille, color: .gray),
        Animal(name: "Abdellah", species: .chat, color: .gray),
        Animal(name: "Zo", species: .chat, color: .gray),
        Animal(name: "Dimitri", species: .lapin, color: .gray)
    ]
    
    for animal in sampleAnimals {
        context.insert(animal)
    }
}

var animalFake: Animal = Animal(name: "Flood", species: .panda, color:  .purple)

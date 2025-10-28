//
//  AnimalClass.swift
//  MyPet
//
//  Created by apprenant78 on 23/10/2025.
//

import SwiftUI
import SwiftData

enum speciesListEnum : String, CaseIterable, Codable {
    case cerf = "Cerf"
    case chat = "Chat"
    case chien = "Chien"
    case grenouille = "Grenouille"
    case lapin = "Lapin"
    case lion = "Lion"
    case panda = "Panda"
    case singe = "Singe"
    case vache = "Vache"
}

@Model
class Animal: Identifiable {
    var id = UUID()
    var name: String
    @Attribute private var speciesRawValue: String
    var note: String
    var isFavorite: Bool = false
    // Color to PrimaryColor + Opacity
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double
    
    var species: speciesListEnum {
        get {
            return speciesListEnum(rawValue: speciesRawValue) ?? .panda
        }
        
        set {
            speciesRawValue = newValue.rawValue
        }
        
    }

    init(
        isFavorite: Bool = false,
        name: String,
        species: speciesListEnum,
        note: String = "...",
        color: Color
    ) {
        self.name = name
        self.speciesRawValue = species.rawValue
        self.isFavorite = isFavorite
        self.note = note
        let uiColor = UIColor(color)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        if uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) {
            self.red = Double(r)
            self.green = Double(g)
            self.blue = Double(b)
            self.alpha = Double(a)
        }
        else {
            self.red = 0.5
            self.green = 0.5
            self.blue = 0.5
            self.alpha = 1.0
        }
    }
    
    var swiftUIColor: Color {
        get {
            return Color(red: red, green: green, blue: blue, opacity: alpha)
        }

        set {
            let uiColor = UIColor(newValue)
            var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
            
            if uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) {
                self.red = Double(r)
                self.green = Double(g)
                self.blue = Double(b)
                self.alpha = Double(a)
            }
        }

    }

}

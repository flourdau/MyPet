//
//  TrashButton.swift
//  Candide
//
//  Created by apprenant84 on 16/09/2025.
//

import SwiftUI
import SwiftData

struct TrashButton: View {
    @State var animal: Animal
    @State var showingAlert = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Button {
            showingAlert = true
        } label: {
            HStack {
                Text("Supprimer?")
                
                Image(systemName: "trash")
                    .opacity(0.8)
                    .font(.system(size: 20))
                    .bold()
                    .shadow(radius: 3)

            }
            .foregroundStyle(.myRed)
        }.alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Supprimer !"),
                message: Text("Etes-vous sûr de vouloir supprimer " + animal.name + " ?"),
                primaryButton: .destructive(Text("Supprimer")) {
                    context.delete(animal)
                    dismiss()
                },
                secondaryButton: .cancel(Text("Annuler"))
            )
        }
    }
}

#Preview {
    TrashButton(animal: animalFake)
}

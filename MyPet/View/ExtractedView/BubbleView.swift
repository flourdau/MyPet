//
//  BubbleView.swift
//  MyPet
//
//  Created by apprenant78 on 25/10/2025.
//

import SwiftUI

struct BubbleView: View {
    var note: String
    @State private var offset: CGSize = .zero
    
    var body: some View {
        Text(note)
            .bold()
            .font(Font.largeTitle.monospaced())
            .foregroundStyle(.black)
            .padding(.top, 16)
            .padding(.bottom, 24)
            .padding(.leading, 8)
            .padding(.trailing, 24)
            .background(
                UnevenRoundedRectangle(
                    cornerRadii: RectangleCornerRadii(
                        topLeading: 16,
                        bottomLeading: 1,
                        bottomTrailing: 24,
                        topTrailing: 24
                    )
                )
                .foregroundStyle(.white)
                .opacity(0.80)
            )
            .overlay(
                UnevenRoundedRectangle(
                    cornerRadii: RectangleCornerRadii(
                        topLeading: 16,
                        bottomLeading: 1,
                        bottomTrailing: 24,
                        topTrailing: 24
                    )
                )
                .stroke(Color.gray.opacity(0.72), lineWidth: 0.32)
            )
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { _ in
                        withAnimation {
                            offset = .zero
                        }
                    }
            )
    }
}

#Preview {
    BubbleView(note: "Hourra!")
}

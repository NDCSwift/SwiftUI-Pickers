//
    // Project: SwiftUI Pickers
    //  File: ColorPickerDemo.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    


import SwiftUI

struct ColorPickerDemo: View {
    @State private var themeColor: Color = .accentColor

    var body: some View {
        VStack(spacing: 30) {
            Text("Preview Text")
                .font(.title)
                .foregroundColor(themeColor)

            ColorPicker(
                "App Theme Color",
                selection: $themeColor,
                supportsOpacity: false
            )
            .padding()
        }
        .padding()
    }
}

#Preview {
    ColorPickerDemo()
}
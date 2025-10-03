//
    // Project: SwiftUI Pickers
    //  File: ViewMode.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    


import SwiftUI

enum ViewMode: String, CaseIterable, Identifiable {
    case list = "List"
    case grid = "Grid"
    case map = "Map"

    var id: String { rawValue }
}

struct OptionsPickerDemo: View {
    @State private var selectedMode: ViewMode = .list

    var body: some View {
        VStack(spacing: 30) {
            // Menu style
            Picker("View Mode", selection: $selectedMode) {
                ForEach(ViewMode.allCases) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.menu)

            // Segmented style
            Picker("View Mode", selection: $selectedMode) {
                ForEach(ViewMode.allCases) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)

            // Inline (best in Form)
            Form {
                Picker("Inline Mode", selection: $selectedMode) {
                    ForEach(ViewMode.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.inline)
            }

            // Demo preview
            Text("Current: \(selectedMode.rawValue)")
                .font(.title2)
        }
        .padding()
    }
}

#Preview {
    OptionsPickerDemo()
}
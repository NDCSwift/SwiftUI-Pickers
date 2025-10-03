//
    // Project: SwiftUI Pickers
    //  File: ThemeSettings.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    


import SwiftUI
import SwiftData

// MARK: - SwiftData Model
@Model
final class ThemeSettings {
    var themeColorHex: String

    init(themeColorHex: String = "#FF0000") {
        self.themeColorHex = themeColorHex
    }
}

// MARK: - Color Helpers
extension Color {
    func toHex() -> String? {
        let uiColor = UIColor(self)
        guard let components = uiColor.cgColor.components else { return nil }
        let r = Int((components[0] * 255).rounded())
        let g = Int((components[1] * 255).rounded())
        let b = Int((components[2] * 255).rounded())
        return String(format: "#%02X%02X%02X", r, g, b)
    }

    static func fromHex(_ hex: String) -> Color {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hex.hasPrefix("#") { hex.removeFirst() }

        guard hex.count == 6, let rgb = Int(hex, radix: 16) else { return .gray }

        return Color(
            red: Double((rgb >> 16) & 0xFF) / 255.0,
            green: Double((rgb >> 8) & 0xFF) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0
        )
    }
}

// MARK: - Demo View
struct SwiftDataPersistenceDemo: View {
    @Environment(\.modelContext) private var context
    @Query private var settings: [ThemeSettings]

    @State private var selectedColor: Color = .accentColor

    var body: some View {
        VStack(spacing: 20) {
            
            
            ColorPicker("Choose Theme", selection: $selectedColor)
            
            

            Button("Save Theme") {
                if let hex = selectedColor.toHex() {
                    let setting = ThemeSettings(themeColorHex: hex)
                    context.insert(setting)
                    try? context.save()
                    print("Saved color: \(hex)")
                }
            }
            .buttonStyle(.borderedProminent)

            if let saved = settings.last {
                Text("Last saved color: \(saved.themeColorHex)")
                    .foregroundColor(Color.fromHex(saved.themeColorHex))
            }
        }
        .padding()
    }
}

#Preview {
    SwiftDataPersistenceDemo()
        .modelContainer(for: ThemeSettings.self) // required for previews
}


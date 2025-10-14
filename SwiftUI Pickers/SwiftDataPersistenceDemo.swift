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

// SwiftData model used to persist the user's selected theme color as a hex string.
@Model
final class ThemeSettings {
    // Stored hex representation of the theme color (e.g., "#RRGGBB").
    var themeColorHex: String

    init(themeColorHex: String = "#FF0000") { // Default to red if no color is provided.
        self.themeColorHex = themeColorHex // Store the provided hex string in the persisted property.
    }
}

// MARK: - Color Helpers
extension Color {
    // Convert a SwiftUI Color to a 6-digit hex string ("#RRGGBB"); returns nil if conversion fails.
    func toHex() -> String? {
        let uiColor = UIColor(self)
        guard let components = uiColor.cgColor.components else { return nil }
        let r = Int((components[0] * 255).rounded())
        let g = Int((components[1] * 255).rounded())
        let b = Int((components[2] * 255).rounded())
        return String(format: "#%02X%02X%02X", r, g, b)
    }

    // Create a SwiftUI Color from a 6-digit hex string; falls back to gray if parsing fails.
    static func fromHex(_ hex: String) -> Color {
        // Normalize input: trim whitespace/newlines and uppercase so parsing is consistent.
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        // Accept inputs like "#FF0000" by removing the leading '#'.
        if hex.hasPrefix("#") { hex.removeFirst() }

        // Validate that we have exactly 6 hex digits and parse them as a base-16 integer;
        // if parsing fails, return a neutral fallback (.gray).
        guard hex.count == 6, let rgb = Int(hex, radix: 16) else { return .gray }

        /*
        // Extract RGB components from the 24-bit integer using bit shifts:
        // - Red   is bits 16...23: (rgb >> 16) & 0xFF
        // - Green is bits  8...15: (rgb >>  8) & 0xFF
        // - Blue  is bits  0...7 :  rgb        & 0xFF
        // Then convert each component from 0...255 to 0...1 for SwiftUI Color.
        */
        return Color(
            red: Double((rgb >> 16) & 0xFF) / 255.0,
            green: Double((rgb >> 8) & 0xFF) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0
        )
    }
}

// MARK: - Demo View
struct SwiftDataPersistenceDemo: View {
    // SwiftData context for inserting and saving ThemeSettings.
    @Environment(\.modelContext) private var context
    // Live query of saved ThemeSettings; the last item reflects the most recently saved color.
    @Query private var settings: [ThemeSettings]

    // Currently selected color in the UI before it is saved.
    @State private var selectedColor: Color = .accentColor

    var body: some View {
        VStack(spacing: 20) {
            // Lets the user pick a theme color; updates selectedColor as the user changes it.
            ColorPicker("Choose Theme", selection: $selectedColor)
            

            // Persist the currently selected color to SwiftData as a hex string.
            Button("Save Theme") {
                // Convert the chosen Color to hex before saving.
                if let hex = selectedColor.toHex() {
                    // Create a new ThemeSettings record with the chosen hex string.
                    let setting = ThemeSettings(themeColorHex: hex)
                    // Add the new record to the model context.
                    context.insert(setting)
                    // Persist changes to disk (errors ignored here for demo simplicity).
                    try? context.save()
                    print("Saved color: \(hex)")
                }
            }
            .buttonStyle(.borderedProminent)

            // Display the most recently saved color and tint the text accordingly.
            if let saved = settings.last {
                Text("Last saved color: \(saved.themeColorHex)")
                    .foregroundColor(Color.fromHex(saved.themeColorHex))
            }
        }
        .padding()
    }
}

#Preview {
    // Provide an in-memory model container so the preview can run without the app environment.
    SwiftDataPersistenceDemo()
        .modelContainer(for: ThemeSettings.self) // required for previews
}


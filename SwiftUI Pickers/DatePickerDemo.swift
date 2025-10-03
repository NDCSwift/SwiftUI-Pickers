//
    // Project: SwiftUI Pickers
    //  File: DatePickerDemo.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    


import SwiftUI

struct DatePickerDemo: View {
    @State private var selectedDate = Date()

    var body: some View {
        VStack(spacing: 20) {
            // Compact (default)
            DatePicker("Compact", selection: $selectedDate)

            // Graphical calendar style
            DatePicker(
                "Graphical",
                selection: $selectedDate,
                in: Date()..., // disables past dates
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)

            // Wheel style, time only
            DatePicker(
                "Wheel Time",
                selection: $selectedDate,
                displayedComponents: [.hourAndMinute]
            )
            .datePickerStyle(.wheel)

            Text("Selected: \(selectedDate.formatted())")
                .padding(.top, 20)
        }
        .padding()
    }
}

#Preview {
    DatePickerDemo()
}
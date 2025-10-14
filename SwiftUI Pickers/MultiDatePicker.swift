//
    // Project: SwiftUI Pickers
    //  File: MultiDatePicker.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    

import SwiftUI

struct MultiDatePickerExample: View {
    // A set of dates chosen by the user
    @State private var selectedDates: Set<DateComponents> = []
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Choose multiple dates")
                .font(.headline)
            
            // The MultiDatePicker itself
            MultiDatePicker("Select Dates", selection: $selectedDates)
                .frame(maxHeight: 400) // control calendar height
            
            Divider()
            
            // Show chosen dates in a list
            if selectedDates.isEmpty {
                Text("No dates selected")
                    .foregroundStyle(.secondary)
            } else {
                List {
                    ForEach(Array(selectedDates), id: \.self) { dateComponents in
                        if let date = Calendar.current.date(from: dateComponents) {
                            Text(date.formatted(date: .long, time: .omitted))
                        }
                    }
                }
                .frame(height: 200)
            }
        }
        .padding()
    }
}

#Preview {
    MultiDatePickerExample()
}

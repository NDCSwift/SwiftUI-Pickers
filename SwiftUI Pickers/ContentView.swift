//
// Project: SwiftUI Pickers
//  File: ContentView.swift
//  Created by Noah Carpenter
//  🐱 Follow me on YouTube! 🎥
//  https://www.youtube.com/@NoahDoesCoding97
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
//  Dream Big, Code Bigger


import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("SwiftUI Pickers Demo")
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
                .foregroundColor(.white)
            TabView {
                DatePickerDemo()
                    .tabItem {
                        Label("Date", systemImage: "calendar")
                    }
                OptionsPickerDemo()
                    .tabItem {
                        Label("Options", systemImage: "list.bullet")
                    }
                ColorPickerDemo()
                    .tabItem {
                        Label("Color", systemImage: "paintpalette")
                    }
                SwiftDataPersistenceDemo()
                    .tabItem {
                        Label("Persistence", systemImage: "externaldrive.fill")
                    }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    ContentView()
}

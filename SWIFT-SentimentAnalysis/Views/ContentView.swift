//
//  ContentView.swift
//  SWIFT-SentimentAnalysis
//
//  Created by Gabriel Tanod on 17/04/25.
//

import SwiftUI
import NaturalLanguage

struct ContentView: View {
    var body: some View {
        TabView {
            DetectView()
                .tabItem { Label("Detect", systemImage: "eye") }

            AnalyzeView()
                .tabItem { Label("Analyze", systemImage: "magnifyingglass") }

            BreakdownView()
                .tabItem { Label("Breakdown", systemImage: "scissors") }
        }
    }
}

#Preview {
    ContentView()
}

//
//  AnalyzeView.swift
//  SWIFT-SentimentAnalysis
//
//  Created by Gabriel Tanod on 17/04/25.
//

import SwiftUI
import NaturalLanguage

struct AnalyzeView: View {
    @State private var input = ""
    @State private var posResults: [(String, String)] = []
    @State private var entityResults: [(String, String)] = []

    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $input)
                    .frame(height: 150)
                    .padding()
                    .border(Color.gray)

                Button("Analyze") {
                    posResults = NLPManager.posTagging(input)
                    entityResults = NLPManager.namedEntities(input)
                }
                .padding()

                ScrollView {
                    VStack(alignment: .leading) {
                        Text("POS Tags:")
                            .font(.headline)
                        ForEach(posResults, id: \.0) { word, tag in
                            Text("\(word): \(tag)")
                        }

                        Divider().padding(.vertical)

                        Text("Named Entities:")
                            .font(.headline)
                        ForEach(entityResults, id: \.0) { word, type in
                            Text("\(word): \(type)")
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Analyze")
        }
    }
}

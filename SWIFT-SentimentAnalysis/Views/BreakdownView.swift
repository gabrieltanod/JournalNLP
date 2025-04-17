//
//  BreakdownView.swift
//  SWIFT-SentimentAnalysis
//
//  Created by Gabriel Tanod on 17/04/25.
//

import SwiftUI
import NaturalLanguage

struct BreakdownView: View {
    @State private var input = ""
    @State private var tokens: [String] = []
    @State private var lemmas: [String] = []

    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $input)
                    .frame(height: 150)
                    .padding()
                    .border(Color.gray)

                Button("Break it Down") {
                    tokens = NLPManager.tokenize(input)
                    lemmas = NLPManager.lemmatize(input)
                }
                .padding()

                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Tokens:")
                            .font(.headline)
                        ForEach(tokens, id: \.self) { token in
                            Text(token)
                        }

                        Divider().padding(.vertical)

                        Text("Lemmas:")
                            .font(.headline)
                        ForEach(lemmas, id: \.self) { lemma in
                            Text(lemma)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Breakdown")
        }
    }
}

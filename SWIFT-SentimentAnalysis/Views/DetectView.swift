//
//  DetectView.swift
//  SWIFT-SentimentAnalysis
//
//  Created by Gabriel Tanod on 17/04/25.
//

import SwiftUI

struct DetectView: View {
    @State private var input = ""
    @State private var sentiment = ""
    @State private var language = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $input)
                    .frame(height: 150)
                    .padding()
                    .border(Color.gray)

                Button("Analyze") {
                    sentiment = NLPManager.analyzeSentiment(input)
                    language = NLPManager.detectLanguage(input)
                }
                .padding()
                
                VStack(alignment:.leading){
                    Text("Sentiment: \(sentiment)")
                        .font(.headline)
                    
                    
                    Divider().padding(.vertical)
                    
                    Text("Language: \(language)")
                        .font(.headline)
                }
                
            }
            .padding()
            Spacer()
                .navigationTitle("Detect")
        }
    }
}

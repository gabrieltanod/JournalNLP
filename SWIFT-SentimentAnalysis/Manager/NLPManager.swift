//
//  Seni.swift
//  SWIFT-SentimentAnalysis
//
//  Created by Gabriel Tanod on 17/04/25.
//

import NaturalLanguage

class NLPManager {
    static func analyzeSentiment(_ text: String) -> String {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        let (scoreTag, _) = tagger.tag(
            at: text.startIndex,
            unit: .paragraph,
            scheme: .sentimentScore
        )

        if let score = Double(scoreTag?.rawValue ?? "0.0") {
            switch score {
            case let x where x > 0.2:
                return "Positive (\(String(format: "%.2f", x)))"
            case let x where x < -0.2:
                return "Negative (\(String(format: "%.2f", x)))"
            default: return "Neutral (\(String(format: "%.2f", score)))"
            }
        }
        return "Unknown"
    }

    static func detectLanguage(_ text: String) -> String {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(text)
        return recognizer.dominantLanguage?.rawValue ?? "Unknown"
    }

    static func tokenize(_ text: String) -> [String] {
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.string = text
        var tokens: [String] = []
        tokenizer.enumerateTokens(in: text.startIndex..<text.endIndex) {
            tokenRange,
            _ in
            tokens.append(String(text[tokenRange]))
            return true
        }
        return tokens
    }

    static func lemmatize(_ text: String) -> [String] {
        let tagger = NLTagger(tagSchemes: [.lemma])
        tagger.string = text
        var lemmas: [String] = []
        let range = text.startIndex..<text.endIndex

        tagger.enumerateTags(
            in: range,
            unit: .word,
            scheme: .lemma,
            options: [.omitWhitespace, .omitPunctuation]
        ) { tag, tokenRange in
            if let lemma = tag?.rawValue {
                lemmas.append(lemma)
            } else {
                lemmas.append(String(text[tokenRange]))
            }
            return true
        }
        return lemmas
    }

    static func posTagging(_ text: String) -> [(String, String)] {
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = text
        var results: [(String, String)] = []
        tagger.enumerateTags(
            in: text.startIndex..<text.endIndex,
            unit: .word,
            scheme: .lexicalClass,
            options: [.omitWhitespace, .omitPunctuation]
        ) { tag, tokenRange in
            if let tag = tag {
                results.append((String(text[tokenRange]), tag.rawValue))
            }
            return true
        }
        return results
    }

    static func namedEntities(_ text: String) -> [(String, String)] {
        let tagger = NLTagger(tagSchemes: [.nameType])
        tagger.string = text
        var entities: [(String, String)] = []
        tagger.enumerateTags(
            in: text.startIndex..<text.endIndex,
            unit: .word,
            scheme: .nameType,
            options: [.omitWhitespace, .omitPunctuation, .joinNames]
        ) { tag, tokenRange in
            if let tag = tag {
                entities.append((String(text[tokenRange]), tag.rawValue))
            }
            return true
        }
        return entities
    }
}

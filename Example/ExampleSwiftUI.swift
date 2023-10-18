//
//  ContentView.swift
//
//  Created by Stef Kors on 17/10/2023.
//

import SwiftUI
import CoreServices

/// Wraps CoreServices SKSummary
struct Summary: Codable, Equatable {
    let input: String
    let sentenceCount: Int
    let paragraphCount: Int

    let output: String
    let numSentencesInSummary: Int

    /// Create summary from input
    /// - Parameters:
    ///   - input: Full lengh text
    ///   - numberOfSentences: Size of summary by number of sentences
    init(_ input: String, numberOfSentences: Int) {
        self.input = input
        self.numSentencesInSummary = numberOfSentences
        let summary = SKSummaryCreateWithString(input as CFString).takeRetainedValue()
        self.sentenceCount = SKSummaryGetSentenceCount(summary)
        self.paragraphCount = SKSummaryGetParagraphCount(summary)

        // Check number of sentences in output to avoid crashing...
        if sentenceCount > 0 {
            self.output = SKSummaryCopySentenceSummaryString(summary, numSentencesInSummary).takeRetainedValue() as String
        } else {
            self.output = input
        }
    }

    /// Create summary from input
    /// - Parameters:
    ///   - input: Full length text
    ///   - percent: Size of the summary in percent of input text
    init(_ input: String, percent: CGFloat) {
        self.input = input
        let summary = SKSummaryCreateWithString(input as CFString).takeRetainedValue()
        self.sentenceCount = SKSummaryGetSentenceCount(summary)
        print(percent.description)
        self.numSentencesInSummary = Int(max(1, ((CGFloat(sentenceCount)/100)*percent)))
        self.paragraphCount = SKSummaryGetParagraphCount(summary)
        print(numSentencesInSummary.description)

        // Check number of sentences in output to avoid crashing...
        if sentenceCount > 0 {
            self.output = SKSummaryCopySentenceSummaryString(summary, numSentencesInSummary).takeRetainedValue() as String
        } else {
            self.output = input
        }
    }
}

extension String {
    /// Uses Summary type to generate summary from string
    /// - Parameter numberOfSentences: Size of summary by number of sentences
    /// - Returns: Summarized output string
    func summarize(numberOfSentences: Int) -> String {
        Summary(self, numberOfSentences: numberOfSentences).output
    }

    /// Uses Summary type to generate summary from string
    /// - Parameter percent: Size of the summary in percent of input text
    /// - Returns: Summarized output string
    func summarize(percent: CGFloat) -> String {
        Summary(self, percent: percent).output
    }
}

struct AfterView: View {
    let text: String

    @State private var result: String?
    @State private var percent: CGFloat = 1

    var summary: Summary {
        Summary(text, percent: percent)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(text.summarize(percent: percent))
                .textSelection(.enabled)
            Spacer()

            Text("\(summary.numSentencesInSummary.description) Sentences")
                .foregroundStyle(.secondary)
                .font(.caption)

            Slider(
                value: $percent,
                in: 1...100,
                step: 5,
                label: {},
                minimumValueLabel: {
                    Text("1%")
                }, maximumValueLabel: {
                    Text("100%")
                })
        }
        .padding()
    }

}

struct BeforeView: View {
    @Binding var text: String
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .textEditorStyle(.plain)
                .font(.body)
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var text: String = """
Here's to the crazy ones. The misfits. The rebels. The troublemakers. The round pegs in the square holes. The ones who see things differently. They're not fond of rules. And they have no respect for the status quo. You can quote them, disagree with them, glorify or vilify them. About the only thing you can't do is ignore them. Because they change things. They push the human race forward. And while some may see them as the crazy ones, we see genius. Because the people who are crazy enough to think they can change the world, are the ones who do.
"""
    var body: some View {
        VStack {
            HStack(content: {
                BeforeView(text: $text)
                Divider()
                AfterView(text: text)
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

//
//  TweetText.swift
//  brain-marks
//
//  Created by Igor Chernyshov on 17.10.2021.
//

import SwiftUI

/// A view that displays one or more lines of read-only text and highlights hashtags.
struct TweetText: View {

	private let text: String

	/// Creates a text view that displays a string literal without localization and highlights hashtags.
	/// - Parameter text: A string to display without localization.
	init(_ text: String) {
		self.text = text
	}

	var body: some View {
		formattedTweetText()
	}

	private func formattedTweetText() -> Text {
		var finalText = Text("")
		var currentWord = [Character]()

		/// Create a Text from currentWord, set color, add to texts, clear currentWord.
		func appendCurrentWordToTexts() {
			let textColor: Color = currentWord.first == "#" ? .blue : .black
			let text = String(currentWord)
			finalText += Text(text).foregroundColor(textColor)
			currentWord.removeAll()
		}

		text.forEach { character in
			if !character.isLetter && !currentWord.isEmpty {
				appendCurrentWordToTexts()
			}
			currentWord.append(character)
		}
		// Append the last current word
		appendCurrentWordToTexts()

		return finalText
	}
}

struct TweetText_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			TweetText("🎃 Have you created a pull request yet? #hacktoberfest 🍂")
			TweetText("So excited!\nMultiline #tweet... Highlighting test")
		}
    }
}

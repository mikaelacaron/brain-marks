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
		text.components(separatedBy: " ")
			.reduce(into: Text("")) { tweetText, word in
				let textColor: Color = word.hasPrefix("#") ? .blue : .black
				tweetText += Text("\(word) ").foregroundColor(textColor)
			}
	}
}

struct TweetText_Previews: PreviewProvider {
    static var previews: some View {
        TweetText("🎃 Have you created a pull request yet? #hacktoberfest 🍂")
    }
}

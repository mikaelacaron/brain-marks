//
//  SettingsViewModel.swift
//  brain-marks
//
//  Created by AC Richter on 22.10.21.
//

import Foundation
import os.log

// swiftlint:disable line_length

class SettingsViewModel: ObservableObject {
    
    @Published var contributors: [Contributor]?
    
    let urls: [String:URL] = [
        "mikaelacaronProfile": URL(string: "https://github.com/mikaelacaron")!,
        "brain-marksRepo": URL(string: "https://github.com/mikaelacaron/brain-marks")!,
        "bugReport": URL(string: "https://github.com/mikaelacaron/brain-marks/issues")!
        
    ]
    
    let staticContributors: [String] = [
        "mikaelacaron",
        "shloak17107",
        "prabal4546",
        "NiklasOemler",
        "vcapilladeveloper"
    ]
    
    func getContributors() {
        
        guard let url = URL(string: "https://api.github.com/repos/mikaelacaron/brain-marks/contributors") else { return }
        
        URLSession.shared.dataTask(with: url) { urlData, _, urlError in
            
            guard urlError == nil else {
                Logger.network.error("\(urlError?.localizedDescription ?? "No localized description in urlError")")
                return
            }
            
            guard urlData != nil else { return }
            
            do {
                
                let data = try JSONDecoder().decode([Contributor].self, from: urlData!)
                
                self.contributors = data
                
            } catch {
                Logger.network.error("\(error)")
            }
        }
        .resume()
    }

  func getStringFromBundle() -> String {
    if let filepath = Bundle.main.path(forResource: "whatsnew", ofType: "md") {
        do {
            let string = try String(contentsOfFile: filepath)
            return string
        } catch {
            print("string could not be loaded")
        }
    } else {
        print("whatsnew.md not found in app bundle")
    }
    return ""
  }

  func createAttributedString(plainString: String) -> AttributedString {
    do {
      let newString = try AttributedString(markdown: plainString, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace))
        return newString
    } catch {
        print("Error creating AttributedString: \(error)")
    }
    return ""
  }
}

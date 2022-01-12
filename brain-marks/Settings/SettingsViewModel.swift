//
//  SettingsViewModel.swift
//  brain-marks
//
//  Created by AC Richter on 22.10.21.
//

import Foundation

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
    
    init() {
        
    }
    func getContributors() {
        
        guard let url = URL(string: "https://api.github.com/repos/mikaelacaron/brain-marks/contributors") else { return }
        
        URLSession.shared.dataTask(with: url) { urlData, _, urlError in
            
            guard urlError == nil else {
                print(urlError?.localizedDescription ?? "No localized description in urlError")
                return
            }
            
            guard urlData != nil else { return }
            
            do {
                
                let data = try JSONDecoder().decode([Contributor].self, from: urlData!)
                
                self.contributors = data
                
            } catch {
                print(error)
            }
        }
        .resume()
    }
}

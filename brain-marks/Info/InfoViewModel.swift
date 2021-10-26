//
//  InfoViewModel.swift
//  InfoViewModel
//
//  Created by Niklas Oemler on 05.10.21.
//

import SwiftUI

// swiftlint:disable line_length

protocol InfoViewModel {
    var title: String { get }
    var message: String { get }
    var imageName: String { get }
    var appVersion: String? { get }
    var infoText: String { get }
    var openSourceRemark: String { get }
}

class DefaultInfoViewModel: InfoViewModel {
    var title: String {
        return appName
    }
    var message: String {
        return "❤️ Thank you for using ❤️"
    }
    let imageName: String = "logo"
    
    private var appName: String {
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Brain Marks"
    }
    
    var appVersion: String? {
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return "Version \(version)"
        } else {
            return nil
        }
    }
    
    var infoText: String {
        return "Brain-marks has always been open source! It began with the Big Brain Hackathon and during Hacktoberfest 2021, work has continued."
    }
    
    var openSourceRemark: String {
        return "If you are interested in contributing yourself, visit the GitHub Repo for more information. Below a list of all contributors can be found. \nYour name could be there!"
    }
}

struct SettingsView_Previews_2: PreviewProvider {
    static var previews: some View {
        SettingsView(infoViewModel: DefaultInfoViewModel())
    }
}

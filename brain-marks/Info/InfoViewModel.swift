//
//  InfoViewModel.swift
//  InfoViewModel
//
//  Created by Niklas Oemler on 05.10.21.
//

import Foundation

protocol InfoViewModel {
    var title: String { get }
    var message: String { get }
    var imageName: String { get }
    var appVersion: String { get }
}

class DefaultInfoViewModel: InfoViewModel {
    var title: String {
        return appName
    }
    var message: String {
        return "Thank you for using \(appName)! ❤️"
    }
    let imageName: String = "logo"
    
    private var appName: String {
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String
    }
    
    var appVersion: String {
        return "Version \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)"
    }
}

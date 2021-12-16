//
//  InfoViewModel.swift
//  InfoViewModel
//
//  Created by Niklas Oemler on 05.10.21.
//

import SwiftUI

protocol InfoViewModel {
    var title: String { get }
    var message: LocalizedStringKey { get }
    var imageName: String { get }
    var appVersion: String? { get }
    var infoText: LocalizedStringKey { get }
    var openSourceRemark: LocalizedStringKey { get }
}

class DefaultInfoViewModel: InfoViewModel {
    var title: String {
        return appName
    }
    var message: LocalizedStringKey {
        return "ThanksForUsing"
    }
    let imageName: String = "logo"
    
    private var appName: String {
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Brain Marks"
    }
    
    var appVersion: String? {
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return "\(version)"
        } else {
            return nil
        }
    }
    
    var infoText: LocalizedStringKey {
        return "BrainMarksIsOpenSource..."
    }
    
    var openSourceRemark: LocalizedStringKey {
        return "IfYouWantToContribute"
    }
}

struct SettingsView_Previews_2: PreviewProvider {
    static var previews: some View {
        SettingsView(infoViewModel: DefaultInfoViewModel())
    }
}

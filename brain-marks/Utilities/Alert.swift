//
//  Alert.swift
//  brain-marks
//
//  Created by Mikaela Caron on 7/22/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    let dismissButon: Alert.Button
}

struct AlertContext {
    static let badURL = AlertItem(title: "❌",
                                  message: "EnteredLinkIsNotValid",
                                  dismissButon: .default(Text("OK")))
    static let noCategory = AlertItem(title: "UhOh",
                                      message: "YouMustSelectCategory",
                                      dismissButon: .default(Text("OK")))
}

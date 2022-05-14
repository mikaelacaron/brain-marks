//
//  Alert.swift
//  brain-marks
//
//  Created by Mikaela Caron on 7/22/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButon: Alert.Button
}

struct AlertContext {
    static let badURL = AlertItem(title: "❌",
                                  message: "The link you entered isn't valid.",
                                  dismissButon: .default(Text("OK")))
    static let somethingWentWrong = AlertItem(title: "❌",
                                  message: "Oops! Something went wrong.",
                                  dismissButon: .default(Text("OK")))
    static let noCategory = AlertItem(title: "Uh oh!",
                                      message: "You must select a category",
                                      dismissButon: .default(Text("OK")))
}

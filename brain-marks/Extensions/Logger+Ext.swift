//
//  Logger+Ext.swift
//  brain-marks
//
//  Created by Franklin Byaruhanga on 04/10/2022.
//

import Foundation
import os.log

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs the view cycles like viewDidLoad.
    static let dataStore = Logger(subsystem: subsystem, category: "DataStore")
    static let amplify = Logger(subsystem: subsystem, category: "Amplify")
    static let network = Logger(subsystem: subsystem, category: "Networking")
    static let appIcon = Logger(subsystem: subsystem, category: "appIcon")
}

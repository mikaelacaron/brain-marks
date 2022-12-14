//
//  TelemetrySignals.swift
//  brain-marks
//
//  Created by Mikaela Caron on 10/14/22.
//

import Foundation

/// Signals to track via Telemetry Deck.
enum TelemetrySignals {
    
    /// The app is launching, normal operation.
    static let appLaunchedRegularly = "appLaunchedRegularly"
    
    /// The user created a new category.
    static let addCategory = "addCategory"
    
    /// The user added a new tweet.
    static let addTweet = "addTweet"

    /// Core Data failed to load
    static let errorCoreDataLoad = "errorCoreDataLoad"
}

//
//  brain_marksApp.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/10/21.
//

import Amplify
import AWSDataStorePlugin
import SwiftUI
import TelemetryClient

@main
struct brain_marksApp: App {
    @AppStorage("migrationToCoreDataRan")
    private var migrationToCoreDataRan: Bool = false

    init() {
        configureAmplify()
        
        let configuration = TelemetryManagerConfiguration(appID: Secrets.telemetryAppID)
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send(TelemetrySignals.appLaunchedRegularly)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func configureAmplify() {
        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        
        do {
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.configure()
            print("✅ Initialized Amplify!")
        } catch {
            // simplified error handling for tutorial
            print("❌ Could not initalize Amplify: \(error)")
        }
    }
}

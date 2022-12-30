//
//  ContentView.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/10/21.
//

import SwiftUI

struct ContentView: View {
    let migrationService: MigrationService = MigrationService()

    @State private var showAddSheet = false

    var body: some View {
        CategoryList()
            .onAppear {
                if migrationService.checkIfMigrationShouldRun() {
                    migrationService.performMigration()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/10/21.
//

import SwiftUI

struct ContentView: View {
    let migrationService: MigrationService

    @State private var showAddSheet = false

    init(storageProvider: StorageProvider) {
        self.migrationService = MigrationService(managedObjectContext: storageProvider.context)
    }

    var body: some View {
        CategoryList()
            .onAppear {
                migrationService.performMigration()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(storageProvider: StorageProvider())
    }
}

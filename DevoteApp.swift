//
//  DevoteApp.swift
//  Devote
//
//  Created by Yogesh Raut on 27/12/24.
//

import SwiftUI

@main
struct DevoteApp: App {
    @AppStorage("isDarkMode") private var isDarkMode : Bool = false
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

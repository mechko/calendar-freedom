//
//  CalendarFreedomApp.swift
//  Calendar Freedom
//
//  Created by Mirko Swillus on 28.01.26.
//

import SwiftUI

@main
struct CalendarFreedomApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        Settings {
            PreferencesView()
        }
        #endif
    }
}

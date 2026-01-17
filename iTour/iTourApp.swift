//
//  iTourApp.swift
//  iTour
//
//  Created by dkc on 2026/01/17.
//

import SwiftData
import SwiftUI

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}

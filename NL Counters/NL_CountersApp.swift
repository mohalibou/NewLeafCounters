//
//  NL_CountersApp.swift
//  NL Counters
//
//  Created by Mohamed Ali Boutaleb on 5/24/22.
//

import SwiftUI

@main
struct NL_CountersApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

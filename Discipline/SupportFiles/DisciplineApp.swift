//
//  DisciplineApp.swift
//  Discipline
//
//  Created by J. DeWeese on 10/30/23.
//

import SwiftUI

@main
struct DisciplineApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        ///container
        .modelContainer(for: [Expense.self, Category.self])
    }
}

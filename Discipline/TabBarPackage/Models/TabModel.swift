//
//  TabModel.swift
//  Discipline
//
//  Created by J. DeWeese on 10/30/23.
//

import SwiftUI

/// App Tab's
enum Tab: String, CaseIterable {
    case money = "Money"
    case workout = "Workouts"
    case diet = "Diet"
    case tasks = "Tasks"
    case journal = "Journal"
    
    var systemImage: String {
        switch self {
        case .workout:
            return "figure.run.circle.fill"
        case .diet:
            return "fork.knife.circle.fill"
        case .tasks:
            return "checkmark.circle.fill"
        case .journal:
            return "square.and.pencil.circle.fill"
        case .money:
            return "dollarsign.circle.fill"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}


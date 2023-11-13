//
//  Category.swift
//  Discipline
//
//  Created by J. DeWeese on 10/30/23.
//

import SwiftUI
import SwiftData

@Model
class Budget {
    var budgetName: String
    var budgetAmount: Double
    ///category expenses
    @Relationship(deleteRule:.cascade, inverse: \Expense.budget)
    var expenses: [Expense]?
    
    init(budgetName: String, budgetAmount: Double, expenses: [Expense]? = nil) {
        self.budgetName = budgetName
        self.budgetAmount = budgetAmount
        self.expenses = expenses
    }
    
    }
    


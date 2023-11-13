//
//  Expense.swift
//  Discipline
//
//  Created by J. DeWeese on 10/30/23.
//

import SwiftUI
import SwiftData

@Model
class Expense {
    ///Properties
    var expenseTitle: String
    var expenseSubTitle: String
    var expenseAmount: Double
    var date: Date
    ///expense categories
    var budget: Budget?
    
    init(expenseTitle: String, expenseSubTitle: String, expenseAmount: Double, date: Date, budget: Budget? = nil) {
        self.expenseTitle = expenseTitle
        self.expenseSubTitle = expenseSubTitle
        self.expenseAmount = expenseAmount
        self.date = date
        self.budget = budget
    }
    /// Currency String
    @Transient
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(for: expenseAmount) ?? ""
    }
}

    


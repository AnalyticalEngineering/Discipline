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
    var amount: Double
    var date: Date
    ///expense categories
    var category: Category?
    
    init(expenseTitle: String, expenseSubTitle: String, amount: Double, date: Date, category: Category? = nil) {
        self.expenseTitle = expenseTitle
        self.expenseSubTitle = expenseSubTitle
        self.amount = amount
        self.date = date
        self.category = category
    }
    /// Currency String
    @Transient
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(for: amount) ?? ""
    }
}

    


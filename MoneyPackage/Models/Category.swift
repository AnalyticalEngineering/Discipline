//
//  Category.swift
//  Discipline
//
//  Created by J. DeWeese on 10/30/23.
//

import SwiftUI
import SwiftData

@Model
class Category {
    var categoryName: String
    ///category expenses
    @Relationship(deleteRule:.cascade, inverse: \Expense.category)
    var expenses: [Expense]?
    
    init(categoryName: String) {
        self.categoryName = categoryName
    
    }
    
}

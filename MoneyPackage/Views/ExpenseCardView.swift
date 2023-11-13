//
//  ExpenseCardView.swift
//  Discipline
//
//  Created by J. DeWeese on 10/30/23.
//

import SwiftUI

struct ExpenseCardView: View {
    @Bindable var expense: Expense
    var displayTag: Bool = true
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.expenseTitle)
                
                Text(expense.expenseSubTitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                if let budgetName = expense.budget?.budgetName, displayTag {
                    Text(budgetName)
                        .font(.caption2)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.red.gradient, in: .capsule)
                }
            }
            .lineLimit(1)
            
            Spacer(minLength: 5)
            
            /// Currency String
            Text(expense.currencyString)
                .font(.title3.bold())
        }
    }
}

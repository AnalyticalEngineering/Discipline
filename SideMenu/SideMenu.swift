//
//  SideMenu.swift
//  Discipline
//
//  Created by J. DeWeese on 10/30/23.
//

import SwiftUI

struct SideMenu: View {
    //MARK: PROPERTIES
    @Binding var currentTab: String
    
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Image("NullProfile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                Text("Rangerboy574")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ///tab buttons
            VStack(alignment: .leading, spacing: 25) {
                
                CustomeTabButton(icon: "creditcard.fill", title: "Expenses")
            }.padding()
                .padding(.top, 60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.colorGrey)
    }
    //MARK:  CUSTOM BUTTONS
    @ViewBuilder
    func CustomeTabButton(icon: String, title: String) -> some View {
        
        Button {
            
        }label: {
            HStack(spacing: 12){
                
                Image(systemName: icon)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding(.trailing)
            .background(
                Color(.colorBlue)
                    .clipShape(Capsule())
                )
        }
    }
}

#Preview {
    ContentView()
}

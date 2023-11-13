//
//  RoundedTextField.swift
//  Discipline
//
//  Created by J. DeWeese on 11/12/23.
//

import SwiftUI

struct RoundTextField: View {
    @State var title: String = "Title"
    @Binding var text: String
    @State var keyboardType: UIKeyboardType = .default
    var isPassword: Bool = false
    var textAlign:TextAlignment = .center
    
    
    var body: some View {
        VStack {
            Text(title)
                .multilineTextAlignment(textAlign)
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                .foregroundStyle(.primary)
                .padding(.bottom, 4)
                .padding(.horizontal)
            if(isPassword) {
                SecureField("", text: $text)
                    .padding(15)
                
                    .frame(height: 48)
                    .overlay{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.colorGrey, lineWidth: 4)
                    }
                    .background(Color.colorGrey.opacity(0.05))
                    .cornerRadius(15)
            } else {
                TextField("", text: $text)
                    .padding(15)
                    .keyboardType(keyboardType)
                    .frame(height: 48)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.colorGrey, lineWidth: 4)
                            .cornerRadius(15)
                    }
            }
        }
    }
}
    struct RoundedTextField_Previews: PreviewProvider{
        @State static var txt: String = ""
        static var previews: some View {
            RoundTextField(text: $txt)
                .foregroundStyle(.primary)
                .background(Color.colorGrey.opacity(0.05))
                .cornerRadius(15)
        }
        
    }



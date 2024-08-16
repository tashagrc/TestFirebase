//
//  AppTextField.swift
//  TestFirebase
//
//  Created by Natasha Radika on 16/08/24.
//

import SwiftUI

struct AppTextField: View {
    var placeholder: String
    @Binding var text: String
    var body: some View {
        
        TextField(placeholder, text: $text)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(uiColor: .secondaryLabel), lineWidth: 1)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
    }
}

#Preview {
    AppTextField(placeholder: "Email address", text: .constant(""))
}

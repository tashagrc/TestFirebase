//
//  AppSecureField.swift
//  TestFirebase
//
//  Created by Natasha Radika on 16/08/24.
//

import SwiftUI

struct AppSecureField: View {
    var placeholder: String
    @Binding var text: String
    var body: some View {
        
        SecureField(placeholder, text: $text)
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
    AppSecureField(placeholder: "email", text: .constant("test"))
}

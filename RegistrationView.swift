//
//  RegistrationView.swift
//  TestFirebase
//
//  Created by Natasha Radika on 16/08/24.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: SignInViewModel
    @Binding var appUser: AppUser?
    @State private var email = ""
    @State private var password = ""
    
    
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                AppTextField(placeholder: "Email address", text: $email)
                AppSecureField(placeholder: "Password", text: $password)
            }
            .padding(.horizontal, 24)
            Button {
                Task {
                    do {
                        let appUser = try await viewModel.registerNewUserWithEmail(email: email, password: password)
                        self.appUser = appUser
                        dismiss.callAsFunction()
                    } catch let error as NSError {
                        print("register email failed with error: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("register")
                    .padding()
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundColor(Color(uiColor: .label))
                    }
            }
            .padding(.horizontal, 24)
        }
        
    }
}

//#Preview {
//    RegistrationView()
//}

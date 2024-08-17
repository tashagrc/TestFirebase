//
//  SignInViewModel.swift
//  TestFirebase
//
//  Created by Natasha Radika on 16/08/24.
//

import SwiftUI

@MainActor
class SignInViewModel: ObservableObject {
    let signInApple = SignInApple()
    
    func signInWithApple() async throws -> AppUser {
        let appleResult = try await signInApple.startSignInWithAppleFlow()
        print("apple result")
        print(appleResult)
        return try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce)
        
    }
    
    func isFormValid(email: String, password: String) -> Bool {
        guard email.isValidEmail(), password.count > 7 else {
            return false
        }
        return true
    }
    
    func registerNewUserWithEmail(email: String, password: String) async throws -> AppUser {
        if isFormValid(email: email, password: password) {
            return try await AuthManager.shared.registerNewUserWithEmail(email: email, password: password)
        } else {
            print("form is invalid")
            throw NSError()
        }
    }
    
    func signInWithEmail(email: String, password: String) async throws -> AppUser {
        if isFormValid(email: email, password: password) {
            return try await AuthManager.shared.signInWithEmail(email: email, password: password)
        } else {
            print("form is invalid")
            throw NSError()
        }
    }
}

extension String {
    func isValidEmail() -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)

    }
}


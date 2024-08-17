//
//  AuthManager.swift
//  TestFirebase
//
//  Created by Natasha Radika on 14/08/24.
//

import SwiftUI
import Supabase
import Foundation

struct AppUser {
    let uid: String
    let email: String?
}


class AuthManager {
    static let shared = AuthManager()
    
    private init() {
        
    }
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://vxftpgrjbnmcdjysmkko.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ4ZnRwZ3JqYm5tY2RqeXNta2tvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM2MjkxNDksImV4cCI6MjAzOTIwNTE0OX0.9BLucVrnJNfAd0ZIYP5hvYxdj8XnjBIhY89jT46aE04")
    
    func getCurrentSession() async throws -> AppUser {
        print("get current session client")
        print(client)
        let session = try await client.auth.session
        print("current session")
        print(session)
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    func registerNewUserWithEmail(email: String, password: String) async throws -> AppUser {
        let regAuthResponse = try await client.auth.signUp(email: email, password: password)
        guard let session = regAuthResponse.session else {
            print("no session when registering user")
            throw NSError()
        }
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
   
    // MARK: Sign in
    func signInWithApple(idToken: String, nonce: String) async throws -> AppUser {
        print("sign in with apple")
        print(client.auth)
        print("idToken: \(idToken)")
        let session = try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken, nonce: nonce))
        print("enter sign in with apple")
        print(session)
        print(session.user)
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    func signInWithEmail(email: String, password: String) async throws -> AppUser {
        let session = try await client.auth.signIn(email: email, password: password)
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    // MARK: Sign Out
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
}



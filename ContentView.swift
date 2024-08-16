//
//  ContentView.swift
//  TestFirebase
//
//  Created by Natasha Radika on 14/08/24.
//

import SwiftUI

struct ContentView: View {
    @State var appUser: AppUser? = nil
    
    
    var body: some View {
        ZStack {
            if let appUser = appUser {
                HomeView(appUser: appUser)
            } else {
                SignInView(appUser: $appUser)
            }
        }
        .onAppear {
            Task {
                self.appUser = try await AuthManager.shared.getCurrentSession()
            }
        }

            
    }
}

#Preview {
    ContentView(appUser: nil)
}

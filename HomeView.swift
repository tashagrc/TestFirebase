//
//  HomeView.swift
//  TestFirebase
//
//  Created by Natasha Radika on 15/08/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var appUser: AppUser?
    var body: some View {
        Text("Home")
        if let appUser = appUser {
            VStack {
                Text(appUser.uid)
                Text(appUser.email ?? "No email")
            }
        }
        
        
    }
}

//#Preview {
//    HomeView(appUser: .constant("jason"))
//}

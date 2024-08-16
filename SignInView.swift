import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    @Binding var appUser: AppUser?
    
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistrationPresented = false
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 10) {
                AppTextField(placeholder: "Email address", text: $email)
                AppSecureField(placeholder: "Password", text: $password)
            }
            .padding(.horizontal, 24)
            
            Button("New user? Register here") {
                isRegistrationPresented.toggle()
            }.sheet(isPresented: $isRegistrationPresented, content: {
                RegistrationView(appUser: $appUser).environmentObject(viewModel)
            })
            
            Button {
                Task {
                    do {
                        let appUser = try await viewModel.signInWithEmail(email: email, password: password)
                        self.appUser = appUser
                    } catch {
                        print("issue with sign in ")
                    }
                }
            } label: {
                Text("sign in")
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
            
            Button {
                Task {
                    do {
                        print("click button")
                        let appUser = try await viewModel.signInWithApple()
                        self.appUser = appUser
                    } catch let error as NSError {
                            print("Sign in failed with error: \(error.localizedDescription)")
                    } catch {
                        print("An unexpected error occurred: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("sign in with apple").foregroundColor(.black)
            }
        }
        
    }
}

#Preview {
    SignInView( appUser: .constant(AppUser(uid: "123", email: "lalala")))
}


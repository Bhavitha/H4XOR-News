//
//  LoginView.swift
//  News
//
//  Created by Bhavitha on 21/03/22.
//

import SwiftUI

enum AuthError: String,Error {
    case invalidInput = "Please fill both email and password"
    case invalidEmail = "Email address is incorrect"
    case invalidPassword = "Password is incorrect"
    case incorrectPasswordLength = "Password length should be greater than 8 characters"
    case invalidData = "Incorrect email/password"
    case mismatch = "Password and confirm password should be same"
    case signupError = "Signup failed. Please try again"
    case emptyFields = "Fields cannot be empty"
    case internalError = "Internal Error"
}

struct PopAlert: Identifiable {
    var id: String { message }
    var title = LocalizedStringKey("error")
    let message: String
}

struct LoginView: View {
    // MARK: - Propertiers
    @State private var email = ""
    @State private var password = ""
    @State private var isSignup = false
    @State private var alert: PopAlert?
    @State var fieldFocus = [false, false]
    @State var isSecureTextEntry = true
    @State private var isActive = false
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    let appGradientColor = Gradient(colors: [Color.themePrimaryColor, Color.themeSecondaryColor, Color.themePrimaryColor])
    
    var body: some View {
        VStack() {
            Text(LocalizedStringKey("hacker_news"))
                .font(.largeTitle).foregroundColor(.white)
                .padding([.top, .bottom], 40)

            
            Image("\(LocalizedStringKey("logo"))")
                .foregroundColor(.red)
                .frame(width: 250, height: 250)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding(.bottom, 50)
            
            VStack(alignment: .leading, spacing: 15) {
                
                CustomTextField(
                    label: "email",
                    text: self.$email,
                    focusable: $fieldFocus,
                    tag: 0
                ).padding()
                 .background(Color.themeTextField)
                 .cornerRadius(20)
                 .foregroundColor(.black)
                 .frame(height: 60)
                
                CustomTextField(
                    label: "password",
                    text: self.$password,
                    focusable: $fieldFocus,
                    isSecureTextEntry: $isSecureTextEntry,
                    tag: 1
                ).padding()
                 .background(Color.themeTextField)
                 .cornerRadius(20)
                 .foregroundColor(.black)
                 .frame(height: 60)
                
                VStack(alignment: .trailing, spacing: 40) {
                    Text(LocalizedStringKey("forgot_password"))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }.padding([.leading, .trailing], 27.5)
            
         /*   Button(action: signInTapped) {
                Text(LocalizedStringKey("signin"))
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.themePrimaryColor)
                    .cornerRadius(15.0)
            }*/
            
            NavigationLink(destination: ArticleListView(), isActive: $isActive) {
                Button(action: signInTapped) {
                      Text(LocalizedStringKey("signin"))
                          .font(.title2)
                          .foregroundColor(.white)
                          .padding()
                          .frame(width: 300, height: 50)
                          .background(Color.themePrimaryColor)
                          .cornerRadius(15.0)
                            }
            }
            Spacer()
            
           
            HStack(spacing: 5) {
             
                Text(LocalizedStringKey("donot_have_account"))
                Button(LocalizedStringKey("signup")) {
                    isSignup = true
                }.foregroundColor(.white)
            }
            
            .alert(item: $alert) { value in
                Alert(title: Text(value.title), message: Text(value.message), dismissButton: .cancel())
            }
        }
        .background(
            LinearGradient(gradient: appGradientColor, startPoint: .center, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        
    }
    func signInTapped() {
        
        do {
            try login()
            
            AuthManager.shared.signIn(email: self.email, password: self.password) { result in
                
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                     //   UserDefaults.standard.set(self.email, forKey: LocalizedStringKey("email"))
                        loginViewModel.isLoggedin = false
                        isActive = true
                        UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        alert = PopAlert(title: LocalizedStringKey("invalid_data"), message: error.rawValue)
                    }
                }
            }
        } catch AuthError.invalidInput {
            alert = PopAlert(title: LocalizedStringKey("invalid_input"), message: AuthError.invalidInput.rawValue)
        } catch AuthError.invalidEmail {
            alert = PopAlert(title: LocalizedStringKey("invalid_email"), message: AuthError.invalidEmail.rawValue)
           
        } catch AuthError.incorrectPasswordLength {
            alert = PopAlert(title: LocalizedStringKey("invalid_password"), message: AuthError.incorrectPasswordLength.rawValue)
        } catch {
            alert = PopAlert(title: LocalizedStringKey("invalid_data"), message: AuthError.invalidData.rawValue)
        }
    }
    
    func login() throws {
        
        email = "bhavitha@gmail.com"
        password = "bhavu46t7rrev"
        
        if email.isEmpty || password.isEmpty {
            throw AuthError.invalidInput
        }
        
        if !email.isValidEmail {
            throw AuthError.invalidEmail
        }
        
        if password.count < 8 {
            throw AuthError.incorrectPasswordLength
        }
        
    }
    
        
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

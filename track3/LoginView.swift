//
//  LoginView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 9/6/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var email = ""
    @State private var password = ""
    @State private var isShowingSignUp = false
    @State private var loginError: Error? = nil
    let colors: [Color] = [.green, .yellow]
    @State private var ColorscurrentIndex = 0
    @State private var ImagesscurrentIndex = 0
    let images: [String] = ["Colegio", "Interamericana de San German"]
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect().throttle(for: .seconds(2), scheduler: RunLoop.main, latest: true)
    
    var body: some View {
        NavigationView {
            ZStack {
                colors[ColorscurrentIndex]
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                
                
                VStack {
                    
                    Image(images[ImagesscurrentIndex])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    
                    Text(loginError?.localizedDescription ?? "")
                        .foregroundColor(.red)
                        .padding(.top, 15)
                    
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    Button("Login") {
                        signInUser(email: email, password: password)
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(colors[ColorscurrentIndex])
                    .cornerRadius(10)
                    //
                    Button("Create Account?") {
                        isShowingSignUp = true
                        
                        
                    }
//                    .foregroundColor(colors[ColorscurrentIndex])
                    
                    
                }
                .padding(.bottom, 70)
            }
            
            NavigationLink(destination: SignUpView().environmentObject(dataManager), isActive: $isShowingSignUp) {
                EmptyView()
            }
            .navigationBarBackButtonHidden(false)
            
            .onReceive(timer) { _ in
                withAnimation {
                    ColorscurrentIndex = (ColorscurrentIndex + 1) % colors.count
                    ImagesscurrentIndex = (ImagesscurrentIndex + 1) % images.count
                    
                }
            }
        }
        .statusBar(hidden: true) 
        
        
    }
    
    @ViewBuilder
    func CustomTF(hint:String, value:Binding<String>, isPassword: Bool = false) -> some View{
        Group {
            if isPassword {
                SecureField(hint, text: value)
                
                
            }
            else {
                TextField(hint, text: value)
                
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(.white.opacity(0.12))
        .cornerRadius(8)
        .foregroundColor(.white)
        
    }
    
    
    
    func signInUser(email:String, password:String) {
        
        dataManager.signInWithEmailPassword(Email: email, Pass: password) { result in
            switch result {
            case .success(let user):
                
                if let user = user {
                    print("User successfully created: \(user.uid)")
                    
                }
                else {
                    print("User is nil.")
                    
                    
                    
                    
                    
                    
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                loginError = error
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

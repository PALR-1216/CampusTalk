//
//  SignUpView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 9/6/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct SignUpView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var ErrorIsShowing = false
    @State private var UserName = ""
    @State private var Email = ""
    @State private var Password = ""
    @State private var signUpError = ""
    @State private var ColorscurrentIndex = 0
    @State private var ImagesscurrentIndex = 0
    let colors: [Color] = [.green, .yellow, .red]
    let images: [String] = ["Colegio", "Inter", "UprRioPiedras"]
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    
    var body: some View {
        NavigationView {
            ZStack {
//                Color.green
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
                    
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Text(signUpError)
                        .foregroundColor(.red)
                        .padding(.top, 15)
                        .padding(.all, 5)
                    
                    TextField("Username", text: $UserName)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    TextField("Email", text: $Email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $Password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    Button("Sign Up") {
                        dataManager.createUserWithEmailPassword(Email: Email, Pass: Password, UserName: UserName) { result in
                            switch result {
                            case .success(let user):
                                // Handle success
                                if let user = user {
                                    print("User created successfully: \(user)")
                                    // Do something with the user
                                } else {
                                    print("User creation was successful, but user data is nil")
                                }
                                
                            case .failure(let error):
                                // Handle failure
                                print("User creation failed with error: \(error.localizedDescription)")
                                ErrorIsShowing = true
                                signUpError = error.localizedDescription
                                
                                
                                // You can perform error-specific handling or display an error message to the user.
                                
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(colors[ColorscurrentIndex])
                    .cornerRadius(10)
                    //
                    //                    Button("back to Login") {
                    //                        isShowingLogin = true
                    //
                    //
                    //                    }
                }
                .padding(.bottom, 70)
                
//                .alert(isPresented: $ErrorIsShowing) {
//                    Alert(title: Text("Error"), message: Text(signUpError), dismissButton: .default(Text("OK")))
//
//
//                }
            }
            
            
//            .toolbar(.hidden, for: .automatic)
            .onReceive(timer) { _ in
                withAnimation {
                    ColorscurrentIndex = (ColorscurrentIndex + 1) % colors.count
                    ImagesscurrentIndex = (ImagesscurrentIndex + 1) % images.count
                    
                }
            }
        }
        
    }
}
            
            
            
struct SignUpView_Previews: PreviewProvider {
    
    static var previews: some View {
        SignUpView()
           
        
    }
}


//
//  ContentView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 8/25/23.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
import _AuthenticationServices_SwiftUI
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift



struct ContentView: View {
//    @State private var userIsLoggedIn = false
    @EnvironmentObject var dataManager:DataManager
    @State private var email = ""
    @State private var userError = false
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            
            
            //            if (Auth.auth().currentUser != nil) {
            if dataManager.isLoggedIn {
                
                MainView()
                
            }
            
            
            else {
                
                LoginView()
            }
        }
        .onAppear{
//            dataManager.checkIfUserIsLoggedIn()
            
        }
    }
}
        
        
        
        
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
    


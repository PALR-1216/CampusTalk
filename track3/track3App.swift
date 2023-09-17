//
//  track3App.swift
//  track3
//
//  Created by Pedro Alejandro LR on 8/25/23.
//

import SwiftUI
import Firebase
@main
struct track3App: App {
    
    @StateObject var dataManager = DataManager()
    
    init() {
           FirebaseApp.configure()
       }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if (Auth.auth().currentUser != nil) {
                    MainView().environmentObject(dataManager)
                    
                    
                }
                

                else {
                    ContentView().environmentObject(dataManager)
                    
                }
            }
           
//            ContentView().environmentObject(dataManager)
//            ListView().environmentObject(dataManager)
//            MainView().environmentObject(dataManager)
            
        }
    }
}

//
//  DataManager.swift
//  track3
//
//  Created by Pedro Alejandro LR on 8/25/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift




class DataManager: ObservableObject {
    @Published var posts: [Posts] = []
    @Published var users: [Users] = []
    @Published var unis: [Unis] = []
    @Published var isLoggedIn: Bool = false
    @State var isNewUser : Bool = false
    
    init() {
        
//        checkIfUserIsLoggedIn()
        Auth.auth().addStateDidChangeListener { [self] _, user in
            self.isLoggedIn = user != nil
            self.fethUserProfile(userID: user?.uid ?? "")
            
            
        }
        
        
    }
    
    //make a function to fetch users Profile Info
    //make a function to change the user name of the user but thast in the future rign now i dont need that
    
   
    
    
    func fetchPost() {
        posts.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Posts")
        ref.getDocuments { snapshot, err in
            guard err == nil else {
                print(err!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let ID = data["ID"] as? String ?? ""
                    let content = data["postContent"] as? String ?? ""
                    let university = data["university"] as? String ?? ""
                    let post = Posts(id: ID, postContent: content, university: university)
                    self.posts.append(post)
                    print(post)
                }
            }
        }
    }
    
    func GetUnis() {
        let db = Firestore.firestore()
        let ref = db.collection("Unis")
        ref.getDocuments { Snapshot, err in
            guard err == nil else {
                print(err!.localizedDescription)
                return
            }

            if let Snapshot = Snapshot {
                for document in Snapshot.documents {
                    let data = document.data()
                    let ID = data["UniID"] as? Int ?? 0
                    let uniName = data["UniName"] as? String ?? ""
                    let uni = Unis(id: ID, UniName: uniName)
                    self.unis.append(uni)
                    print(uni)
                    
                }
            }
        }

    }
    
    func AddPost(Message:String) {
        
        let db = Firestore.firestore()
        let ref = db.collection("Posts").document(Message)
        ref.setData(["ID": UUID().uuidString, "postContent": Message, "university": "Interamericana de San German"])
        
    }
    
//    func createUser(userID: String, Username: String) {
//
//        let db = Firestore.firestore()
//        let ref = db.collection("Users").document(userID)
//
//        ref.getDocument { document, error in
//            if let document = document, document.exists {
//                print("User with userID \(userID) already exists")
//
//            }
//
//            else if let error = error {
//                print("Error checking for user: \(error.localizedDescription)")
//
//            }
//
//            else  {
//
//                let userData: [String: Any] = [
//                    "UserName": Username
//                ]
//
//                ref.setData(userData) { error in
//                    if let error = error {
//                        print("Error adding user: \(error.localizedDescription)")
//                    }
//
//                    else {
//                        print("User added successfully user ID: \(userID)")
//                    }
//                }
//
//            }
//        }
//    }
    
    func fethUserProfile(userID:String) {
        let db = Firestore.firestore()
        let ref = db.collection("Users")
    }
    
    
    
    func checkUsernameAvailability(UserName: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        ref.whereField("userName", isEqualTo: UserName).getDocuments { querysnapShot, error in
            if let error = error {
                print("Error checking username availability: \(error.localizedDescription)")
                completion(false)

            }
            
            else {
                let usernameAvailable = querysnapShot?.isEmpty ?? true
                completion(usernameAvailable)
                
            }
        }
    }
  
    
    
    func signInWithEmailPassword(Email: String, Pass:String, completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: Email, password: Pass){(authResult, error) in
            if let error = error {
                completion(.failure(error))
                print("error in login")
                self.isNewUser = true
                
                
            }
            
            else {
                completion(.success(authResult?.user))
                print("Logged in")
            }
        }
    }
    
    func createUserWithEmailPassword(Email:String, Pass:String, UserName:String, uniName:String, completion:@escaping (Result<User?, Error>) -> Void) {
        
        checkUsernameAvailability(UserName: UserName) { usernameAvailable in
            if usernameAvailable {
                
                //create user if not exist
                Auth.auth().createUser(withEmail: Email, password: Pass){ (result, error) in
                    if let error = error {
                        // Handle user creation error
                        print("Error creating user: \(error.localizedDescription)")
                        completion(.failure(error))
                        if usernameAvailable == false {
                            completion(.failure(error))
                            print("Error creating user: \(error.localizedDescription)")
                            
                        }
                    }
                    
                    else if let user = result?.user {
                        self.createUser(userID: user.uid, username: UserName, UniName: uniName)
                        completion(.success(user))
                        
                        
                        //                AdduserToFirebaseDB
                        //save the id and the username of the users
                        
                        
                    }
                }
            }
            else {
                
                let errorMessage = "Username '\(UserName)' is already taken. Please choose a different username."
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                completion(.failure(error))
                
            }
        }
    }
    
//    func createUser(userID: String, Username: String) {
////        users.removeAll()
//        let db = Firestore.firestore()
//        let ref = db.collection("Users")
//
//        ref.getDocuments { snapshot, err in
//            guard err == nil else {
//                print(err!.localizedDescription)
//                return
//            }
//
//            if let snapshot = snapshot {
//                for document in snapshot.documents {
//                    let data = document.data()
//                    let ID = data["UserID"] as? String ?? ""
//                    let userName = data["userName"] as? String ?? ""
//                    let user = Users(id: UUID(), userName: Username, userID: ID)
//                    self.users.append(user)
////                    print(user.userName)
//
//                }
//            }
//
//
//        }
//    }
    
    func createUser(userID: String, username: String, UniName:String) {
        let db = Firestore.firestore()
        let usersRef = db.collection("Users")

        // Create a new user document
        let newUserDocument = usersRef.document()
        let userData: [String: Any] = [
            "UserID": userID,
            "userName": username,
            "UniName": UniName
            // Add other user data as needed
        ]
        

        // Set the data for the new user document
        newUserDocument.setData(userData) { error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
            } else {
                print("User created successfully")
            }
        }
    }

    
    func checkIfUserIsLoggedIn() -> Bool {
        if let user = Auth.auth().currentUser {
            print(user.email!)
            return true
        }
        
        else {
            return false
        }
    }
    
    func checkIfUserExists(Email:String, completion: @escaping(Bool, Error?) ->Void) {
        Auth.auth().fetchSignInMethods(forEmail: Email) {(methods, error) in
            if let error = error {
                //hadle error
                print("Error checking user existence: \(error.localizedDescription)")
                completion(false, error)

            }
            else if let _ = methods {
                //user with this email exist
                completion(true, nil)
                
            }
            
            else {
                //user with email does not exist
                completion(false, nil)
                self.isNewUser = true
            }
        }
    }
    

    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }catch{
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

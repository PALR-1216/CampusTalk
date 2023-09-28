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
    @Published var UsersUni = String()
//    @Published var userID: String = ""
    @Published var isLoggedIn: Bool = false
    @State var isNewUser : Bool = false
//    @State var userID: String = ""
    @Published var userName = String()
    @Published var isLoading = false
    
    
    
    init() {
//        fetchUserProfile(userID: Auth.auth().currentUser!.uid)
//        fetchUserProfile(userID: Auth.auth().currentUser?.uid ?? "")
//        print(UsersUni)
        
        
        
//        checkIfUserIsLoggedIn()
        Auth.auth().addStateDidChangeListener { [self] _, user in
            self.isLoggedIn = user != nil
            self.fetchUserProfile(userID: user?.uid ?? "")
            
            
            //make a iff that checks if user is logged in and if user is loggedx in then use the userid to check for users uni and fetch post with tue uni id
        }
        
        
        
//        self.fethUserProfile(userID:Auth.auth().currentUser!.uid)
    }
    
  //TODO: Add a function that runs in the app instead of refpreshing the app it will update automatically

    
   
    
    //make a function to fetch users Profile Info
    //make a function to change the user name of the user but thast in the future rign now i dont need that
    
   
    
    
//    func fetchPost() {
//          posts.removeAll()
//          let db = Firestore.firestore()
//          let ref = db.collection("Posts")
//        let userRef = db.collection("Users")
//
//          ref.getDocuments { snapshot, err in
//              guard err == nil else {
//                  print(err!.localizedDescription)
//                  return
//              }
//              if let snapshot = snapshot {
//                  for document in snapshot.documents {
//                      let data = document.data()
//                      let ID = data["ID"] as? String ?? ""
//                      let content = data["postContent"] as? String ?? ""
//                      let university = data["university"] as? String ?? ""
//                      let post = Posts(id: ID, postContent: content, university: university)
//                      self.posts.append(post)
//                      print(post)
//                  }
//              }
//          }
//      }
    
    
    

    func fetchPost(UsersUni: String) {
        self.isLoading = true
        posts.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Posts")
        
        // Add a query to filter posts by university
        ref.whereField("university", isEqualTo: UsersUni).getDocuments { snapshot, err in
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
                    let Time = data["timeStamp"] as? Timestamp ?? Timestamp()
                    let user = data["User"] as? String ?? ""
                    let LikesCount = data["LikesCount"] as? Int ?? 0
                    
                 
                        // Create the Posts object with the converted timestamp
                    let post = Posts(id: ID, postContent: content, university: university, timeStamp: Time, User: user, UserID: Auth.auth().currentUser?.uid ?? "", LikesCount:LikesCount)
                        self.posts.append(post)
                  
//                    print(post)
                    
                }
                self.posts.sort(by: { $0.timeStamp.dateValue() > $1.timeStamp.dateValue() })
                self.isLoading = false
            }
        }
    }


    
    func GetUnis() {
        unis.removeAll()
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
    
    func AddPost(Message:String, UsersUni:String) {
        
        let db = Firestore.firestore()
        let postID = UUID().uuidString
        let ref = db.collection("Posts").document(postID)
//        let timeStamp = Timestamp(date: Date.now)
        
        ref.setData(["ID": postID, "postContent": Message, "timeStamp": FieldValue.serverTimestamp(), "User": "\(userName)", "LikesCount": 0,  "university": "\(UsersUni)", "UserID": Auth.auth().currentUser?.uid ?? ""])
        
    }
    
    


    func checkIfPostIsLiked(postId: String, completion: @escaping (Bool) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        let postRef = db.collection("posts").document(postId)
        let userLikesRef = db.collection("users").document(userId).collection("likes")

        // Fetch the post
        postRef.getDocument { (postSnapshot, error) in
            if let error = error {
                print("Error getting post: \(error)")
                completion(false)
            } else if let postSnapshot = postSnapshot {
                // Fetch the user's likes
                userLikesRef.whereField("postId", isEqualTo: postId).getDocuments { (likeSnapshot, error) in
                    if let error = error {
                        print("Error getting likes: \(error)")
                        completion(false)
                    } else if let likeSnapshot = likeSnapshot {
                        // Check if the post is in the user's likes
                        let isLiked = !likeSnapshot.isEmpty
                        completion(isLiked)
                    }
                }
            }
        }
    }

    // Usage:
//    checkIfPostIsLiked(postId: "somePostId") { (isLiked) in
//        if isLiked {
//            // Update heart icon to red
//        } else {
//            // Update heart icon to default
//        }
//    }

    
    //TODO: Need to check how to add this function to the main view and see all the hearts in the post list
    
  
    func LikePost(postId: String, userID: String) {
        let db = Firestore.firestore()
        
        // Create a reference to the "posts" collection and the specific post document
        let postRef = db.collection("Posts").document(postId)
        
        // Check if the user has already liked the post
        db.collection("Likes").whereField("PostID", isEqualTo: postId).whereField("UserID", isEqualTo: userID).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error in checking if user has already liked the post: \(error.localizedDescription)")
                return
            }
            
            // If the user has not liked the post, proceed to like it
            if querySnapshot?.isEmpty ?? true {
                // Create a new like document in the "Likes" collection
                let likeData: [String: Any] = [
                    "PostID": postId,
                    "UserID": userID
                ]
                
                db.collection("Likes").addDocument(data: likeData) { err in
                    if let err = err {
                        print("Error in adding like: \(err.localizedDescription)")
                    } else {
                        // Successfully added like, now increment the likesCount for the post
                        let incrementValue = 1
                        postRef.updateData(["LikesCount": FieldValue.increment(Int64(incrementValue))]) { (error) in
                            if let error = error {
                                print("Error incrementing likes count: \(error.localizedDescription)")
                            } else {
                                print("Successfully liked post and incremented likes count")
                            }
                        }
                    }
                }
            } else {
                print("User has already liked this post.")
            }
        }
    }

    
    
    
    
    func fetchUserProfile(userID: String) {
        let db = Firestore.firestore()
        let usersCollection = db.collection("Users")
        
        usersCollection.whereField("UserID", isEqualTo: userID).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching documents: \(error.localizedDescription)")
                    return
                }
                
                if let documents = querySnapshot?.documents, !documents.isEmpty {
                    // Since UserID should be unique, there should be at most one document in the result
                    let document = documents[0]
                    let userData = document.data()
                    if let userName = userData["userName"] as? String {
                        print("Username: \(userName)")
                        self.userName = userName
                        print("userName: \(userName)")
                        
                    }
                    
                    if let uni = userData["UniName"] as? String {
                        print("User's University: \(uni)")
                        self.UsersUni = uni
                        self.fetchPost(UsersUni: uni)
                        
                        
                    } else {
                        print("University data not found.")
                    }
                } else {
                    print("Document with UserID '\(userID)' not found.")
                }
            }
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

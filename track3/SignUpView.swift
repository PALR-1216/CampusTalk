
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
    @State private var Selected = "Interamericana de San German"
    @State private var indexSelected = 1
    let colors: [Color] = [.green, .yellow]
    // in the future i need to store that array in the database
    let images: [String] = ["Colegio", "Interamericana de San German"]
//    let unis: [String] = ["Colegio", "Inter De San German"]
    let timer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect().throttle(for: .seconds(2), scheduler: RunLoop.main, latest: true)

    
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
//                        .padding()
                    
                    Text(signUpError)
                        .foregroundColor(.red)
                        .padding(.top, 15)
                        .padding(.all, 5)
                    
                    TextField("Username", text: $UserName)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
//                    Text("select Your College")
                    
                    Menu {

                        
                        ForEach(dataManager.unis, id:\.self) {i in
                            
                            Button {
                                Selected = i.UniName
                                indexSelected = i.id
                                
                            } label: {
                                HStack {
                                    Image("\(i.UniName)")
                                    
                                        .frame(width: 150, height: 150)
                                        .imageScale(.small)
                                    Text("\(i.UniName)")
                                }
                            }
                        }
                            
                    } label: {
                        HStack {
                            Image(Selected)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
//
                                .padding()
                          
                            Text("\(Selected)")
                                .foregroundColor(.black)
                                .padding(.leading, 40)
                                .fontWeight(.bold)
                            Spacer()
                            
                        }
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                       
                        
                       
                        
                    }
                    

                    
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
                        dataManager.createUserWithEmailPassword(Email: Email, Pass: Password, UserName: UserName, uniName: Selected) { result in
                            switch result {
                            case .success(let user):
                                // Handle success
                                if let user = user {
                                    print("User created successfully: \(user.uid)")
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
//                print("hello world")
            }
            
            .onAppear {
                dataManager.GetUnis()
            }
        }
        
    }
}
            
            
            
struct SignUpView_Previews: PreviewProvider {
    
    static var previews: some View {
        SignUpView()
           
        
    }
}

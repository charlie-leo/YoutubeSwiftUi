//
//  ProfileView.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 18/07/24.
//

import SwiftUI

struct ProfileView: View {
   
    
    @State private var firstName : String = ""
    @State private var lastName : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    @State private var age : String = ""
    @State private var showAlert : Bool = false
    
//    var configuration = PHPicker
    
    @State private var showImagePicker = false
    @State private var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    
    let ageRange = Array(18...100)
    
    var body: some View {
        
        NavigationView{
            VStack {
                      if let uiImage = image {
                          Image(uiImage: uiImage)
                              .resizable()
                              .scaledToFit()
                              .frame(width: 300, height: 300)
                      } else {
                          Text("Select an image")
                              .font(.title)
                              .foregroundColor(.gray)
                      }

                      HStack {
                          Button("Choose from Library") {
                              sourceType = .photoLibrary
                              showImagePicker.toggle()
                          }
                          .padding()

                          Button("Take Photo") {
                              sourceType = .camera
                              showImagePicker.toggle()
                          }
                          .padding()
                          .disabled(!UIImagePickerController.isSourceTypeAvailable(.camera))
                      }
                  }
            Form{
                
              
                
                
                Section(header: Text("User Details")) {
                    
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    
                }
                
                Section(header : Text("Account Information")){
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmPassword)
                }
                
                Section (header: Text("Personal Details")){
                    Picker("Select Age", selection: $age){
                        ForEach(ageRange, id: \.self){
                            Text("\($0)").tag($0)
                        }
                    }
                }
                
                Section {
                    Button(action: submitForm){
                        Text("Submit")
                            .frame(maxWidth: .infinity,alignment: .center)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10.0)
                    }
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Invalid Input"), message: Text(validationMessage), dismissButton: .default(Text("OK")))
                    })
                }
                
                
            }
            
        }.navigationTitle("Home")
            .navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image, sourceType: sourceType)
            }

    }
    
    
    private var validationMessage : String {
        if firstName.isEmpty {return "First name is required."}
        if lastName.isEmpty {return "Last name is required."}
        if email.isEmpty {return "Email name is required."}
        if password.isEmpty {return "Password name is required."}
        if password != confirmPassword {return "Password do not match."}
        return ""
    }
    
    private func submitForm(){
        if validationMessage.isEmpty {
            
        } else  {
            showAlert = true
        }
    }
}

#Preview {
    ProfileView()
}

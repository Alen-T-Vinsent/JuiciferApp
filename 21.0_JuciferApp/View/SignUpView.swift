//
//  SignUpView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    @ObservedObject var signUpVm:SignUpViewModel

    var body: some View {
        ZStack{
            
            //for Linear background
            LinearGradient(gradient: appCredentialsVm.gradient, startPoint: .bottom, endPoint: .topLeading)
                .ignoresSafeArea(.all)
            
            
            //for full vstack to make vtack into 2 vstack 1st half for heading and 2nd half for login details
            VStack{
                
                //1st half
                VStack{
                    
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .padding(.top,50)
                .padding(30)
                
                .overlay(alignment:.leading){
                    Rectangle()
                        .fill(Color("bg-circle-dark"))
                        .frame(width: appCredentialsVm.screenWidth/2)
                        .ignoresSafeArea()
                        .offset(x: appCredentialsVm.screenWidth/2, y:appCredentialsVm.screenWidth/2)
                    
                }
                .overlay(alignment:.trailing){
                    Rectangle()
                        .fill(Color("bg-circle-dark"))
                        .frame(width: appCredentialsVm.screenWidth/2)
                        .ignoresSafeArea()
                        .offset(x: appCredentialsVm.screenWidth/5, y:appCredentialsVm.screenWidth/5)
                    
                    
                }
                
                .overlay(alignment:.leading){
                    VStack{
                        HStack{
                            Text("Welcome \n back \n to Jucifer")
                                .font(.largeTitle.bold())
                                .foregroundColor(Color("bg-main-darkBrown"))
                                .padding()
                                .padding(.bottom,50)
                            Spacer()
                        }
                        
                        
                    }
                    .frame(maxWidth:.infinity,maxHeight: .infinity)
                }
                .modifier(CustomModifierOfLoginMainVstack(screenHeight: appCredentialsVm.screenHeight/2, bgColor: Color.clear))
                
                
                //2nd half
                VStack(alignment:.leading){
                    
                    //heading
                    Text("Please Sign Up")
                        .font(.title)
                    
                    
                   
                    //email textField
                    TextField("create a unique username ", text: $signUpVm.userNameTxtField)
                        .onChange(of: signUpVm.userNameTxtField) { new in
                            signUpVm.checkUsertExists(documentId: signUpVm.userNameTxtField)
                        }
                        .overlay(alignment:.trailing){
                            //for username exist status
                            if !signUpVm.userNameExist && signUpVm.userNameTxtField != "" {
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color.green)
                            } else {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color.red)
                            }
                                
                        }//:confirm password overlay for eye
                        .textFieldStyle(UnderlinedTextFieldStyle())
                    
                        
                    //password textField
                    TextField("create a password ", text: $signUpVm.passwordTxtField)
                        .textFieldStyle(UnderlinedTextFieldStyle())
                        .overlay(alignment:.trailing){
                            Image(systemName: signUpVm.showPassword ? "eye" : "eye.slash")
                                .onTapGesture {
                                    signUpVm.showPassword.toggle()
                                }
                                .foregroundColor(Color("bg-main-darkBrown"))
                        }//:password overlay for eye
                    
                    //confirm password textField
                    TextField("confirm your password ", text: $signUpVm.confirmPasswordTxtField)
                        .textFieldStyle(UnderlinedTextFieldStyle())
                        .overlay(alignment:.trailing){
                            Image(systemName: signUpVm.showConfirmPassword ? "eye" : "eye.slash")
                                .onTapGesture {
                                    signUpVm.showConfirmPassword.toggle()
                                }
                                .foregroundColor(Color("bg-main-darkBrown"))
                        }//:confirm password overlay for eye
                    
                    
                    
                    
                    Spacer()
                    
                    
                    //for tappable signup text
                    Text("Sign In")
                        .frame(maxWidth:.infinity,alignment: .center)
                        .font(.title)
                        .foregroundColor(Color("bg-main-darkBrown"))
                        .onTapGesture {
                            print("signIn button in signUp view clicked ")
                            signUpVm.displaySignUpView = false
                        }
                    
                    
                }//:2ndHalf Vstack
                .padding(50)
                .modifier(CustomModifierOfLoginMainVstack(screenHeight: appCredentialsVm.screenHeight/2, bgColor: Color("bg-highlighter")))
                .cornerRadius(20, corners: [.topLeft, .topRight])
                
            }//:VStack
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .overlay(alignment:.trailing){
                Circle()
                    .fill(Color("bg-main-lightBrown"))
                    .shadow(color: .black, radius: 3, x: 0, y: 2)
                    .frame(width:60,height: 60)
                    .padding(.trailing,30)
                    .shadow(radius: 1)
                
                    .overlay(alignment:.center){
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color.white)
                            .padding(.trailing,30)
                            .shadow(color: .black, radius: 2, x: 0, y: 0)
                    }
                    .onTapGesture {
                        print("tapped arrow right button in signup view")
                        let passwordIsSame = signUpVm.checkBothPasswordAreSame()
                        if passwordIsSame == true && signUpVm.userNameExist == false{
                            signUpVm.showAlert = true
                            print("successfully creating username.....")
                            print("so creating username in firebase as document in Users collection...")
                            
                            
                        }else{
                            print("err creating userName")
                        }
                    }
                    .alert("Would you like to create an account", isPresented: $signUpVm.showAlert) {
                               Button("Are you sure", role: .cancel) {
                                   signUpVm.createNewUser(withID: signUpVm.userNameTxtField, password: signUpVm.confirmPasswordTxtField)
                                   signUpVm.userNameTxtField = ""
                                   signUpVm.passwordTxtField = ""
                                   signUpVm.confirmPasswordTxtField = ""
                                   
                                   signUpVm.displaySignUpView = false
                               }
                        Button("cancel", role: .destructive) { }
                           }
                
            }
                    
            
            
            
        }
        
        
    }
}



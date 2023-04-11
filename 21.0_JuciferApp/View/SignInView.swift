//
//  LoginView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    @StateObject var signInVm = SignInViewModel()
    @StateObject var signUpVm = SignUpViewModel()
    
    
    
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
                    Text("Please Sign In")
                        .font(.title)
                    //email textField
                    TextField("Enter your email ", text: $signInVm.emailTxtField)
                        .textFieldStyle(UnderlinedTextFieldStyle())
                    //password textField
                    TextField("Enter your password ", text: $signInVm.passwordTxtField)
                        .textFieldStyle(UnderlinedTextFieldStyle())
                        .overlay(alignment:.trailing){
                            Image(systemName: signInVm.showPassword ? "eye" : "eye.slash")
                                .onTapGesture {
                                    signInVm.showPassword.toggle()
                                }
                                .foregroundColor(Color("bg-main-darkBrown"))
                        }//:password overlay for eye
                    
                    //forgot password
                    Text("forgot password?")
                        .underline()
                        .frame(maxWidth:.infinity,alignment: .trailing)
                        .font(.caption)
                        .foregroundColor(Color("bg-main-darkBrown"))
                        .padding(.top,5)
                    
                    
                    Spacer()
                    
                    
                    //for tappable signup text
                    Text("Sign Up")
                        .frame(maxWidth:.infinity,alignment: .center)
                        .font(.title)
                        .foregroundColor(Color("bg-main-darkBrown"))
                        .onTapGesture{
                            print("signUp button clicked from sign in view ")
                            signUpVm.displaySignUpView = true
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
                    
                
                    .shadow(color: .black, radius: 4, x: 0, y: 2)
                  
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
                        print("tapped arrow right button in signin view")
                        appCredentialsVm.loggInStatus = true
                        
                    }
            }
            
        
        }
        
        .fullScreenCover(isPresented: $signUpVm.displaySignUpView) {
            SignUpView(signUpVm: signUpVm)
        }
    }
}


//MARK: struct for designing vstack
struct CustomModifierOfLoginMainVstack:ViewModifier{
    var screenHeight:CGFloat
    var bgColor:Color
    func body(content: Content) -> some View {
        return content
            .frame(height: screenHeight)
            .frame(maxWidth: .infinity)
            .background(bgColor)
    }
}

//MARK: struct for UnderlinedTextFieldStyle
struct UnderlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .accentColor(.black)
            .padding(.vertical, 8)
        
            .background(
                VStack {
                    Spacer()
                    Color(UIColor.white)
                        .frame(height: 0.1)
                }
            )
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(AppCredentialsViewModel())
            .environmentObject(SignInViewModel())
            .environmentObject(SignUpViewModel())
    }
}

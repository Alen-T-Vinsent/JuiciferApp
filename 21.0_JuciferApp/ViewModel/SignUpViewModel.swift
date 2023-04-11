//
//  SignUpViewModel.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.
//

import Foundation

class SignUpViewModel:ObservableObject{
    @Published var  emailTxtField = ""
    @Published var  passwordTxtField = ""
    @Published var confirmPasswordTxtField = ""
    @Published var  showPassword = true
    @Published var showConfirmPassword:Bool = true
    
    
    //to display signup view from sign in view
    @Published var displaySignUpView = false
    
}

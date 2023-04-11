//
//  LoginViewModel.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.
//

import Foundation

class SignInViewModel:ObservableObject{
    @Published var emailTxtField = ""
    @Published var passwordTxtField = ""
    @Published var showPassword = true
}

//
//  LoginViewModel.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.
//

import Foundation
import Firebase

class SignInViewModel:ObservableObject{
    @Published var userNameTxtField = ""
    @Published var passwordTxtField = ""
    @Published var showPassword = true
    
    
    private let db = Firestore.firestore()
    
    func checkUsernameWithPasswordExist(username:String,password:String){
        db.collection("Users")
            .whereField("username", isEqualTo: username)
            .whereField("password", isEqualTo: password)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                } else {
                   print("found a similar id.......")
                }
            }
    }
}

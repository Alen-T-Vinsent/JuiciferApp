//
//  SignUpViewModel.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.
//

import Foundation
import Firebase

class SignUpViewModel:ObservableObject{
    
    private let db = Firestore.firestore()
    
    @Published var  userNameTxtField = ""
    @Published var  passwordTxtField = ""
    @Published var confirmPasswordTxtField = ""
    @Published var  showPassword = true
    @Published var showConfirmPassword:Bool = true
    @Published var showAlert:Bool = false
    
    
    //to display signup view from sign in view
    @Published var displaySignUpView = false
    
    @Published var userNameExist:Bool = true
    
    func checkUsertExists(documentId:String) {
        if documentId != ""{
            let docRef = db.collection("Users").document(documentId)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    self.userNameExist = true
                } else {
                    self.userNameExist = false
                }
            }
        }
        }
    
    
    func checkBothPasswordAreSame()->Bool{
        if passwordTxtField == confirmPasswordTxtField{
            return true
        }else{
            return false
        }
    }
    
    func createNewUser(withID documentID: String,password:String) {
           let docRef = db.collection("Users").document(documentID)
           docRef.setData(["userName": documentID, "password": password]) { error in
               if let error = error {
                   print("Error adding document: \(error.localizedDescription)")
               } else {
                   print("Document added with ID: \(documentID)")
               }
           }
       }
    
}

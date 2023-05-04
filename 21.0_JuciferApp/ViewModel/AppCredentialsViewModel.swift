//
//  AppCredentialsViewModel.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

class AppCredentialsViewModel:ObservableObject{
    let gradient = Gradient(colors: [Color("bg-main-darkBrown"), Color("bg-main-lightBrown")])
    
    @Published var loggInStatus:Bool = false
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    
    
    @Published var showHomeView = false
    
    @Published var showSingleJuiceView = false
    @Published var showCartView = false
    @Published var showSelectDeliveryAddressView = false
    @Published var showChooseDeliveryView = false
    @Published var  showSelectPaymentMethod = false
    @Published var  showConfirmPaymentMethod = false
    @Published var showPaymentView = false
    @Published var showOrderPlacedView = false
    
    
//    //MARK: For google signin and signup
    
    
    enum SignInState {
      case signedIn
      case signedOut
    }



    @Published var state: SignInState = .signedOut

      func signIn() {
          
          guard let clientID = FirebaseApp.app()?.options.clientID else { return }

          // Create Google Sign In configuration object.
          let config = GIDConfiguration(clientID: clientID)
          GIDSignIn.sharedInstance.configuration = config

          
         
          // Start the sign in flow!
          GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootView()){ result , err in
              guard let user = result?.user,
                let idToken = user.idToken?.tokenString
              else {
               return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: user.accessToken.tokenString)
              
              //authenticating
              Auth.auth().signIn(with: credential) { result, error in

                // At this point, our user is signed in
                  //do login
                  self.state = .signedIn
              }
                  
              
          }
          
          
      }

//      private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
//
//        if let error = error {
//          print(error.localizedDescription)
//          return
//        }
//
//
//        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
//
//        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
//
//
//        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
//          if let error = error {
//            print(error.localizedDescription)
//          } else {
//            self.state = .signedIn
//          }
//        }
//      }


      func signOut() {

        GIDSignIn.sharedInstance.signOut()

        do {

          try Auth.auth().signOut()

          state = .signedOut
        } catch {
          print(error.localizedDescription)
        }
      }
}

extension UIApplication{
    func rootView()->UIViewController{
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let viewController = window.windows.last?.rootViewController else{
            return  .init()
            
        }
        
        return viewController
    }
}


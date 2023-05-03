//
//  _1_0_JuciferAppApp.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct _1_0_JuciferAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @AppStorage("USER_NAME") var USER_NAME = ""
    @StateObject var appCredentialsVm = AppCredentialsViewModel()
    @StateObject var juiceVm = JuiceViewModel()
    @StateObject var navigationPathVm = NavigationPathVm()
    @StateObject var cartVm = CartViewModel()
    @StateObject var addressViewModel = AddressViewModel()
    
    
    //For OrderDetailsViewModel
    @StateObject var orderDetailsViewModel = OrderDetailsViewModel()
    
    @StateObject var buyViewModel = BuyViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appCredentialsVm)
                .environmentObject(juiceVm)
                .environmentObject(navigationPathVm)
                .environmentObject(orderDetailsViewModel)
                .environmentObject(cartVm)
                .environmentObject(buyViewModel)
                .environmentObject(addressViewModel)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("FIREBASE CONFIGURED")
    return true
  }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
}

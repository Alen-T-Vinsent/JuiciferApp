//
//  ContentView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    var body: some View {
        //sign in and sign up views
        if appCredentialsVm.loggInStatus{
            HomeView()
        }else{
          SignInView()

        }   
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

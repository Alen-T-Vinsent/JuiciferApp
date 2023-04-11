//
//  _1_0_JuciferAppApp.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.
//

import SwiftUI

@main
struct _1_0_JuciferAppApp: App {
    @StateObject var appCredentialsVm = AppCredentialsViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appCredentialsVm)
        }
    }
}

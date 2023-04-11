//
//  AppCredentialsViewModel.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.
//

import Foundation
import SwiftUI

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
    
    
    
}

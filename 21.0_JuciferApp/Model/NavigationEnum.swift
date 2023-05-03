//
//  NavigationEnum.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 24/04/23.
//

import Foundation

enum ViewsNavigatorEnum:String, CaseIterable,Hashable{
    case singleJuiceView = "singleJuiceView"
    case cartView = "cartView"
    case selectAddressView = "selectAddressView"
    case choosePaymentView = "choosePaymentView"
    case paymentView = "paymentView"
    case orderPlacedView = "orderPlacedView"
}

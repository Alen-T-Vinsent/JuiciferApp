//
//  CheckOutView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 03/05/23.
//

import SwiftUI
import Stripe

struct CheckoutView: View {
    
//    @EnvironmentObject private var cart: Cart
    @Binding var items:[String]
    @State private var message: String = ""
    @State private var isSuccess: Bool = false
    @State private var paymentMethodParams: STPPaymentMethodParams?
    let paymentGatewayController = PaymentGatewayController()
        
    private func pay() {
        
        guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret else {
            return
        }
        
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        
        paymentGatewayController.submitPayment(intent: paymentIntentParams) { status, intent, error in
            
            switch status {
                case .failed:
                    message = "Failed"
                case .canceled:
                    message = "Cancelled"
                case .succeeded:
                    message = "Your payment has been successfully completed!"
            }
            
            print(status)
            
        }
        
    }

    var body: some View {
        VStack {
            List {
                
                ForEach(items,id:\.self) { item in
                    HStack {
                        Text(item)
//                        Spacer()
//                        Text(formatPrice(item.price) ?? "")
                    }
                }
                
                HStack {
                    Spacer()
                    Text("Total 199222")
                    Spacer()
                }
                
                Section {
                    // Stripe Credit Card TextField Here
                    STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams)
                } header: {
                    Text("Payment Information")
                }
                
                HStack {
                    Spacer()
                    Button("Pay") {
                        print("pay button clicked")
                        pay()
                    }.buttonStyle(.plain)
                    Spacer()
                }
                
                HStack{
                    Text("message: ")
                    Text(message)
                        .font(.headline)
                }
                
                
            }
            
            NavigationLink(isActive: $isSuccess, destination: {
               // Confirmation()
            }, label: {
                EmptyView()
            })
            
            
            .navigationTitle("Checkout")
            
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    @State static  var array = ["one","two","three","four"]
    static var previews: some View {
        NavigationView {
            CheckoutView(items: $array)
        }
    }
}



//UIKIT PaymentGatewayController
import UIKit

class PaymentGatewayController:UIViewController{
    func submitPayment(intent: STPPaymentIntentParams, completion: @escaping (STPPaymentHandlerActionStatus, STPPaymentIntent?, NSError?) -> Void) {
           
           let paymentHandler = STPPaymentHandler.shared()
           
           paymentHandler.confirmPayment(intent, with: self) { (status, intent, error) in
               completion(status, intent, error)
           }
           
       }
}

extension PaymentGatewayController:STPAuthenticationContext{
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}

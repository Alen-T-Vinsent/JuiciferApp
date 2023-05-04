//
//  StripeView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 03/05/23.
//

import SwiftUI
import Stripe

struct StripeView: View {
    @State var isActive = false
    @State var cartItems = ["Strawberry","Mango","Papaya"]
    var body: some View {
        
        NavigationView {
            VStack{
                List(cartItems,id: \.self){ each in
                    Text(each)
                }

                NavigationLink(isActive: $isActive){
                    CheckoutView(items: $cartItems)
                }label: {
                    Button {
                        startCheckout { clientSecret in
                            PaymentConfig.shared.paymentIntentClientSecret = clientSecret
                            DispatchQueue.main.async {
                                isActive = true
                            }
                        }
                    } label: {
                        Text("Checkout")
                    }
                }
            }
            
        }//Navigation View
      
    }
    
    private func startCheckout(completion:@escaping (String?) -> Void){
        //let url = URL(string: "https://respected-near-airboat.glitch.me/create-payment-intent")!
        let url = URL(string: "http://localhost:8080/create-payment-intent")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(cartItems)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data , error == nil , (response as? HTTPURLResponse)?.statusCode == 200
                
            else{
                completion(nil)
                return
            }
            
           let checkOutIntentResponse = try? JSONDecoder().decode(CheckoutIntentResponse.self, from: data)
            completion(checkOutIntentResponse?.clientSecret)
        }
        .resume()
    }
}

struct StripeView_Previews: PreviewProvider {
    static var previews: some View {
        StripeView()
    }
}


struct CheckoutIntentResponse:Decodable{
    let clientSecret:String
}


import Foundation

class PaymentConfig {
    
    var paymentIntentClientSecret: String?
    static var shared: PaymentConfig = PaymentConfig()
    
    private init() { }
}

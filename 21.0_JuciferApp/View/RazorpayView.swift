//
//  RazorpayView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 03/05/23.
//

//import SwiftUI
//
//struct RazorpayView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

import UIKit
import Razorpay
import Alamofire
import SwiftyJSON


class razorPayViewController: UIViewController,RazorpayPaymentCompletionProtocolWithData,RazorpayPaymentCompletionProtocol{
  
    var razorpay: RazorpayCheckout!
  
    private var productOrderResponseJSON : JSON = []
    var productAmount : Double = 0.0
 

    
    
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
     
      orderApiCall()
      
    }
     
    
    func orderApiCall(){
        
     
        
        let url = URL(string: "Url + order")
                                                           
        let header : HTTPHeaders = ["token": UserDefaults.standard.string(forKey: "Key")!]
        
        let parameter: [String: [String]] = [
                                          "id" : [Id],
                                      ]
                                 
        AF.request(url!, method: .post, parameters: parameter ,encoding: URLEncoding.default, headers: header ).responseJSON {
                                               
         response in
                                               
        switch response.result {
                                                      
          case .success:
                     
          self.productOrderResponseJSON = JSON(response.value!)
                        
               if self.productOrderResponseJSON["success"] == true{
                                 
                          self.productAmount  =  Double(self.productOrderResponseJSON["razorpayOrder"]["amount"].stringValue)  ?? 0.0
                                
                           self.showPaymentForm()
                        
                              }
                              else{
                              
                        }
                       
                              
                 case .failure(let error):
                       print(error)
                                                  
                   }
                                                                                          
                                                                  
           }
        
    }
    
    
  
    
    public func showPaymentForm(){
        razorpay = RazorpayCheckout.initWithKey("razorpayLiveKey", andDelegateWithData: self)
      
          let options: [String:Any] = [
             
                  
                     "amount" : String(self.productAmount * 100), //mandatory in paise like:- 1000 paise ==  10 rs
                     "description": "Payment for product purchase",
                     "order_id": self.BookOrderResponseJSON["razorpayOrder"]["razorpay_order_id"].stringValue,
                       "image": UIImage(named: "Logo")!,
                     "name": "Movies",
                     "prefill": [
                     "contact": UserDefaults.standard.string(forKey: "usermobile")!,
                     "email":  UserDefaults.standard.string(forKey: "useremail")!,
                     ],
                     "theme": [
                         "color": "#F8991F"
                     ]
                 ]
                if let rzp = self.razorpay {
                           rzp.open(options)
                       } else {
                           print("Unable to initialize")
                       }
      }
      

  
  //RazorpayPaymentCompletionProtocolWithData
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
            print("error: ", code)
             let storyboard = UIStoryboard(name: "payment", bundle: nil)
            let razorpayVC = storyboard.instantiateViewController(withIdentifier: "paymentFailedViewController") as! paymentFailedViewController
             self.present(razorpayVC, animated: false, completion: nil)
        }
        
      
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
            print("success: ", response)
 
                             
                             let paymentId = response?["razorpay_payment_id"] as! String
                             let rezorSignature = response?["razorpay_signature"] as! String
                             
                             verifyPayment(paymentId:paymentId,rezorSignature:rezorSignature)
                   
               
                }
            
 }

extension razorPayViewController {
    
    
   
    
    func verifyPayment(paymentId:String,rezorSignature:String){
        
        let url = URL(string: url+ "/api/verify")
                                                             
                    let header : HTTPHeaders = ["token": UserDefaults.standard.string(forKey: "Key")!]
          
          let parameter: [String: String] = [
                    "razorpay_order_id": self.productOrderResponseJSON["razorpayOrder"]["razorpay_order_id"].stringValue,
                    "razorpay_payment_id":paymentId,
                   
                    "razorpay_signature":rezorSignature
                                        ]
                                   
                 
                    
                    AF.request(url!, method: .post, parameters: parameter ,encoding: URLEncoding.default, headers: header ).responseJSON {
                                                 
                                                    response in
                                                 
                        switch response.result {
                                                        
                            case .success:
                                
                                print(response.value!)
                                self.productOrderResponseJSON = JSON(response.value!)
                          
                                if self.productOrderResponseJSON["success"] == true{
                                
                                 
                                    let storyboard = UIStoryboard(name: "payment", bundle: nil)
                                        let razorpayVC = storyboard.instantiateViewController(withIdentifier: "paymentSuccessViewController") as! paymentSuccessViewController
                                           
                                    self.present(razorpayVC, animated: false, completion: nil)
                           
                                  
                             }
                                
                              else{
                               
                          }
                         
                                
                                
                                case .failure(let error):
                                     print(error)
                                                    
                     }
                                                                                            
                                                                    
             }
        
    }
}

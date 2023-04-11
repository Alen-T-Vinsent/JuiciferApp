//
//  PaymentView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 09/04/23.
//

import SwiftUI

struct PaymentView: View {
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
        var body: some View {
            ZStack{
                //for Linear background
                LinearGradient(gradient: appCredentialsVm.gradient, startPoint: .bottom, endPoint: .topLeading)
                    .ignoresSafeArea(.all)
                
                
                //main vstack
                VStack{
                    
                    
                    
                    //2nd half
                    VStack{
                       
                
                    }
                    
                    
                    
                    
                }
                .frame(width: appCredentialsVm.screenWidth,height: appCredentialsVm.screenHeight)
                //            .background(Color.red)
                
                
                
                
            }//:Zstack
            .overlay(alignment:.top){
                VStack{
                    // header
                    HStack{
                        
                        //back button
                        VStack{
                            Image(systemName: "chevron.left")
                                .bold()
                                .padding()
                            
                        }
                        .frame(width: 50,height: 50)
                        .background(Color("bg-component-highlighter"))
                        .cornerRadius(10)
                        .onTapGesture {
//
//                            print("back button of PaymentView")
//                            print("before appCredentialVm.PaymentView ==> \( appCredentialsVm.showPaymentView)")
//                            appCredentialsVm.showPaymentView = false
//                            print("after appCredentialVm.showPaymentView ==> \(appCredentialsVm.showPaymentView)")
//
                            
                            print("\nback button of  PaymentView")
                            
                            print(appCredentialsVm.showPaymentView)
                            appCredentialsVm.showPaymentView = false
                            print(appCredentialsVm.showPaymentView)
                            
//
                        }
                        Spacer()
                        
                        
                        
                    }//:header
                    .foregroundColor(Color.white)
                    .padding()
                    
                    Spacer()
                    
                }
                .padding()
                .shadow(radius: 19)
            }
            .overlay(alignment:.bottom){
                HStack{
                    Text("pay $17")
                        .font(.subheadline.bold())
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color("bg-main-lightBrown"))
                .cornerRadius(20)
                .foregroundColor(Color.white)
                .padding(30)
                .shadow(color: .black,radius: 3)
                .onTapGesture {
//                    print("before appCredentialVm.showOrderPlacedView ==> \(appCredentialsVm.showOrderPlacedView)")
//                    appCredentialsVm.showOrderPlacedView = true
//                    print("after appCredentialVm.showOrderPlacedView ==> \(appCredentialsVm.showOrderPlacedView)")
                    
                  
                    print("\n pay17 ")
                    print(appCredentialsVm.showOrderPlacedView)
                    appCredentialsVm.showOrderPlacedView = true
                    print(appCredentialsVm.showOrderPlacedView)
                    
                }
            }
            .fullScreenCover(isPresented: $appCredentialsVm.showOrderPlacedView) {
                OrderPlacedView()
            }
        }
    }



struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}

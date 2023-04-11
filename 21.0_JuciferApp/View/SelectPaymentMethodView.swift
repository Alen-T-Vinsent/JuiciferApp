//
//  SelectPaymentMethodView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 09/04/23.
//

import SwiftUI

struct SelectPaymentMethodView: View {
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
                    
                    ScrollView(.vertical){
                        HStack{
                            
                        }
                        .frame(height:120)
                        
                        
                        ForEach(1...15,id:\.self){each in
                            
                            HStack{
                              
                                Image(systemName: "person.fill")
                                VStack(alignment:.leading){
                                    Text("**** **** **** 2345")
                                    Text("Expires 3/21")
                                        .font(.footnote)
                               
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("bg-highlighter"))
                            .cornerRadius(10)
                            
                        }
                        HStack{
                            
                        }
                        .frame(height:200)
                    }
                    .ignoresSafeArea(.all)
                    .padding(7)
            
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
//                        print("back button of SelectPaymentMethodView")
//                        print("before appCredentialVm.showConfirmPaymentMethod ==> \( appCredentialsVm.showConfirmPaymentMethod)")
//                        appCredentialsVm.showConfirmPaymentMethod = false
//                        print("after appCredentialVm.showConfirmPaymentMethod ==> \( appCredentialsVm.showConfirmPaymentMethod)")
                        
                        print("back button of SelectPaymentMethodView")
                        
                        print(appCredentialsVm.showSelectPaymentMethod)
                        appCredentialsVm.showSelectPaymentMethod = false
                        print(appCredentialsVm.showSelectPaymentMethod)
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
                Text("confirm payment method")
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
//                print("SelectPaymentMethodView confirm payment method tapped")
//                print("before appCredentialVm.showPaymentView ==> \( appCredentialsVm.showPaymentView)")
//
//                appCredentialsVm.showPaymentView = true
//
//                print("after appCredentialVm.showPaymentView ==> \( appCredentialsVm.showPaymentView)")
                
                print("confirm payment method")
                
                print(appCredentialsVm.showPaymentView)
                appCredentialsVm.showPaymentView = true
                print(appCredentialsVm.showPaymentView)
                
            }
        }
        
        .fullScreenCover(isPresented: $appCredentialsVm.showPaymentView) {
            PaymentView()
        }
        
    }
}

struct SelectPaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPaymentMethodView()
    }
}

//
//  PaymentView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 09/04/23.
//

import SwiftUI

struct PaymentView: View {
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    @AppStorage("USER_NAME") var USER_NAME = ""
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var isHomeActive:Bool
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
                            
                            presentationMode.wrappedValue.dismiss()
                            
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
            .navigationBarBackButtonHidden(true)
            .overlay(alignment:.bottom){
                NavigationLink {
                    OrderPlacedView( isHomeActive: $isHomeActive)
                } label: {
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
                }


            }
        }
    }




//
//  SelectPaymentMethodView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 09/04/23.
//

import SwiftUI

struct SelectPaymentMethodView: View {
    @EnvironmentObject var navigationPathVm:NavigationPathVm
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    
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
            //.background(Color.red)
            
            
            
            
        }//:Zstack
        .navigationBarBackButtonHidden(true)
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
                        presentationMode.wrappedValue.dismiss()
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
           
                NavigationLink {
                    PaymentView(isHomeActive: $isHomeActive)
                } label: {
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
                }

            
        }
        

        
    }
}


//
//  OrderPlacedView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 09/04/23.
//

import SwiftUI

struct OrderPlacedView: View {
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var isHomeActive:Bool
    
    
    @State var showLoading = false
            var body: some View {
                ZStack{
                    //for Linear background
                    LinearGradient(gradient: appCredentialsVm.gradient, startPoint: .bottom, endPoint: .topLeading)
                        .ignoresSafeArea(.all)
                    
                    
                    //main vstack
                    VStack{
                        
                        
                        
                        //2nd half
                        VStack{
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width:appCredentialsVm.screenWidth/4,height: appCredentialsVm.screenWidth/4)
                            Text("Your Order has")
                            Text("been placed")
                           Text("view details")
                                .font(.footnote)
                                .frame(width: appCredentialsVm.screenWidth/2)
                                .padding(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.black, lineWidth: 1)
                                )
                    
                        }
                        .font(.largeTitle.bold())
                        .foregroundColor(Color.white)
                        
                        
                        
                        
                    }
                    .frame(width: appCredentialsVm.screenWidth,height: appCredentialsVm.screenHeight)
                    //            .background(Color.red)
                    
                   
                    
                    
                }//:Zstack
                
                .navigationBarBackButtonHidden(true)
                .overlay(alignment:.bottom){
                   
                        HStack{
                            Text("continue shopping")
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
                            isHomeActive = false
                        }
                    }

                   
            
              
                
            }
        }





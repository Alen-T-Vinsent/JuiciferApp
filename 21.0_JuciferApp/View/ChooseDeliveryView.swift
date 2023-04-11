//
//  ChooseDeliveryView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 09/04/23.
//

import SwiftUI

struct ChooseDeliveryView: View {
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
                            
                            //for normal delivery
                            HStack{
                                VStack{
                                   Image(systemName: "circle.fill")
                                        .foregroundColor(Color("bg-main-darkBrown"))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.black, lineWidth: 1)
                                        )
                                        .padding()
                                        
                                    Spacer()
                                }
                                
                                VStack(alignment:.leading){
                                    Text("Normal delivery")
                                }
                                .padding(.vertical,10)
                                
                                VStack{
                                    Text("$10")
                                        .frame(maxWidth: .infinity,alignment: .trailing)
                                        .font(.title2.bold())
                                }

                                Spacer()
                                
                                
                            }
                            .font(.headline.bold())
                            .frame(maxWidth: .infinity)
                            .background(Color("bg-highlighter"))
                            .cornerRadius(10)
                            .padding(10)
                            .shadow(color:.black,radius: 3,x: 3,y:10)
                            
                            
                            //for fast delivery
                            HStack{
                                VStack{
                                   Image(systemName: "circle")
                                        .foregroundColor(Color("bg-main-darkBrown"))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.black, lineWidth: 1)
                                        )
                                        .padding()
                                        
                                    Spacer()
                                }
                                
                                VStack(alignment:.leading){
                                    Text("Fast delivery")
                                }
                                .padding(.vertical,10)
                                
                                VStack{
                                    Text("$20")
                                        .frame(maxWidth: .infinity,alignment: .trailing)
                                        .font(.title2.bold())
                                }

                                Spacer()
                                
                                
                            }
                            .font(.headline.bold())
                            .frame(maxWidth: .infinity)
                            .background(Color("bg-highlighter"))
                            .cornerRadius(10)
                            .padding(10)
                            .shadow(color:.black,radius: 2)
                           
                           
                            

                            HStack{
                                
                            }
                            .frame(height:200)
                        }
                        .ignoresSafeArea(.all)
                
                    }
    //             .background(Color.green)
                 .frame(height: appCredentialsVm.screenHeight)
                 

                    
                    
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
//                            print("chooseDeliveryView back button")
//
//                            print("before appCredentialVm.showSelectDeliveryAddressView ==> \( appCredentialsVm.showSelectDeliveryAddressView)")
//                            appCredentialsVm.showSelectDeliveryAddressView = false
//
//                            print("after appCredentialVm.showSelectDeliveryAddressView ==> \( appCredentialsVm.showSelectDeliveryAddressView)")
                            
                            print("back button of ChooseDeliveryView")
                            print(appCredentialsVm.showChooseDeliveryView)
                            appCredentialsVm.showChooseDeliveryView = false
                            print(appCredentialsVm.showChooseDeliveryView)
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
                    Text("continue")
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
//                    print("chooseDeliveryView continue button ")
//                    print("before appCredentialVm.showSelectPaymentMethod ==> \( appCredentialsVm.showSelectPaymentMethod)")
//                    appCredentialsVm.showSelectPaymentMethod = true
//
//                    print("after appCredentialVm.showSelectPaymentMethod ==> \( appCredentialsVm.showSelectPaymentMethod)")
                    
                    print("continue button")
                    print(appCredentialsVm.showSelectPaymentMethod)
                    appCredentialsVm.showSelectPaymentMethod = true
                    print(appCredentialsVm.showSelectPaymentMethod)
                }
            }
            .fullScreenCover(isPresented: $appCredentialsVm.showSelectPaymentMethod) {
                SelectPaymentMethodView()
            }
        }
    }


struct ChooseDeliveryView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseDeliveryView()
    }
}

//
//  CartView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 08/04/23.
//

import SwiftUI

struct CartView: View {
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
                                
                                //1.for image
                                HStack{
                                    Image("image2")
                                        .resizable()
                                        .frame(width: 80,height: 80)
                                        .background(Color("bg-main-darkBrown"))
                                        .cornerRadius(26)
                                    
                                    
                                }
                                
                                Spacer()
                                
                                //2.for name and count
                                HStack{
                                    VStack(alignment:.leading){
                                        Text("Mango Juice")
                                            .font(.headline.bold())
                                        
                                        //for + - count
                                        HStack{
                                            Text("+  1  -")
                                                .bold()
                                                .padding(4)
                                                .padding(.leading,5)
                                                .padding(.trailing,5)
                                                .background(Color("bg-main-darkBrown"))
                                                .cornerRadius(10)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                   
                                }
                                
                                Spacer()
                                
                                //3.for individual price
                                HStack{
                                    Text("$10")
                                        .font(.title2.bold())
                                        .foregroundColor(Color.black)
                                }
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .background(Color("bg-highlighter"))
                            .cornerRadius(30)
                            .padding(5)
                            
                           
                            
                        }
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
                        print("\nback button of CartView")
//                        print("before appCredentialVm.showCartView ==> \( appCredentialsVm.showCartView)")
//                        appCredentialsVm.showCartView = false
//
//                        print("after appCredentialVm.showCartView ==> \( appCredentialsVm.showCartView)")
                        
                        print(appCredentialsVm.showCartView)
                        appCredentialsVm.showCartView = false
                        print(appCredentialsVm.showCartView)
                        
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
            VStack{
                VStack{
                    
                    //1.sub total
                    HStack{
                        Text("sub total")
                        Spacer()
                        Text("$10")
                    }
                    
                    //2.total
                    HStack{
                        Text("Total")
                        Spacer()
                        Text("$10")
                    }
                    .font(.title.bold())
                    
                    //3.Button
                    HStack{
                        Text("Proceed to pay")
                            .font(.subheadline.bold())
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("bg-main-darkBrown"))
                    .cornerRadius(20)
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        print("CartView proceed to pay")
                        
//                        print("before appCredentialVm.showSelectDeliveryAddressView ==> \( appCredentialsVm.showSelectDeliveryAddressView)")
//                        appCredentialsVm.showSelectDeliveryAddressView = true
//
//                        print("after appCredentialVm.showSelectDeliveryAddressView ==> \( appCredentialsVm.showSelectDeliveryAddressView)")
                        print(appCredentialsVm.showSelectDeliveryAddressView)
                        appCredentialsVm.showSelectDeliveryAddressView = true
                        print(appCredentialsVm.showSelectDeliveryAddressView)
                    }
                    
                        
                }
                .padding()
                .frame(maxWidth: .infinity)
//                .frame(width:appCredentialsVm.screenWidth - 20,height:200)
                .frame(height:200)
                .background()
                .cornerRadius(40)
                .shadow(radius: 10)
                
//                VStack{
//
//                }
//                .frame(width:appCredentialsVm.screenWidth - 20,height:20)
            }
            
             
        }
        
        .fullScreenCover(isPresented: $appCredentialsVm.showSelectDeliveryAddressView) {
            SelectDeliveryAddressView()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

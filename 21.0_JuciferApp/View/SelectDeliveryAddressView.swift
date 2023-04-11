//
//  SelectDeliveryAddressView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 09/04/23.
//

import SwiftUI

struct SelectDeliveryAddressView: View {
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
                        
                        //for recently used or last added
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
                                Text("Recently Used")
                                    .font(.callout.bold())
                                
                                Text("Alen T Vinsent")
                                    .font(.title2.bold())
                                Text("JK building")
                                Text("Vidya Nagar Conlony")
                                Text("Kalamassery")
                                Text("Kerala, 680596")
                                Text("India")
                                Text("Phone Number : 9074555960")
                                
                                

                            }
                            .padding(.vertical,10)
                            
                            
                            Spacer()
                            
                            
                        }
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity)
                        .background(Color("bg-highlighter"))
                        .cornerRadius(10)
                        .padding(10)
                        .shadow(color:.black,radius: 3,x: 3,y:10)
                        .overlay(alignment:.topTrailing){
                            Image(systemName: "square.and.pencil")
                                .font(.caption)
                                .padding(7)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.black, lineWidth: 1)
                                )
                                .foregroundColor(Color.black)
                                .padding(20)
                        }
                        
                       
                       
                        
                        ForEach(1...15,id:\.self){each in
                            
                            VStack{
                                HStack{
                                    VStack{
                                       Image(systemName: "circle.dotted")
                                            
                                            .padding()
                                        Spacer()
                                    }
                                    
                                    VStack(alignment:.leading){
                                        Text("address 1...15")
                                            .font(.callout.bold())
                                        
                                        Text("Alen T Vinsent")
                                            .font(.title2.bold())
                                        Text("JK building")
                                        Text("Vidya Nagar Conlony")
                                        Text("Kalamassery")
                                        Text("Kerala, 680596")
                                        Text("India")
                                        Text("Phone Number : 9074555960")
                                    }
                                    .padding(.vertical,10)
                                    
                                    Spacer()
                                    
                                }
//                                HStack{
//                                    Button {
//                                        print("edit address button clicked")
//                                    } label: {
//                                        Text("Edit Address")
//                                            .shadow(radius: 4)
//                                            .font(.footnote)
//                                    }
//                                    .frame(maxWidth: .infinity)
//                                    .foregroundColor(Color.white)
//                                    .padding(7)
//                                    .overlay(
//                                            RoundedRectangle(cornerRadius: 16)
//                                                .stroke(.black, lineWidth: 1)
//                                        )
//                                }
//                                .padding()
//                                .frame(maxWidth: appCredentialsVm.screenWidth/2)
                                
                            }
                            .font(.headline.bold())
                            .frame(maxWidth: .infinity)
                            .background(Color("bg-highlighter"))
                            .cornerRadius(10)
                            .padding(10)
                            .overlay(alignment:.topTrailing){
                                Image(systemName: "square.and.pencil")
                                    .font(.caption)
                                    .padding(7)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.black, lineWidth: 1)
                                    )
                                    .foregroundColor(Color.black)
                                    .padding(20)
                            }
                            
                            
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
//                        print(" appCredentialsVm.showSelectDeliveryAddressView = false")
//                        appCredentialsVm.showSelectDeliveryAddressView = false
//                        print(appCredentialsVm.showSelectDeliveryAddressView)
                        
                        print("back button of SelectDeliveryAddressView")
                        print(appCredentialsVm.showSelectDeliveryAddressView)
                        appCredentialsVm.showSelectDeliveryAddressView = false
                        print(appCredentialsVm.showSelectDeliveryAddressView)
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
        
        .overlay(alignment:.topTrailing){
            VStack{
                // header
                HStack{
                    
                    //back button
                    VStack{
                        Image(systemName: "plus")
                            .bold()
                            .padding()
                        
                    }
                    .frame(width: 50,height: 50)
                    .background(Color("bg-component-highlighter"))
                    .cornerRadius(10)
                   
                    

                    
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
                Text("Deliver to this address")
                    .font(.subheadline.bold())
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color("bg-main-lightBrown"))
            .cornerRadius(20)
            .foregroundColor(Color.white)
            .padding(30)
            .shadow(color:.black,radius: 3)
            .onTapGesture {
//                print("Select Delivery Addressview s Deliver to this address button")
//                print("before appCredentialVm.showChooseDeliveryView ==> \( appCredentialsVm.showChooseDeliveryView)")
//                appCredentialsVm.showChooseDeliveryView = true
//
//                print("after appCredentialVm.showChooseDeliveryView ==> \( appCredentialsVm.showChooseDeliveryView)")
                
                print("Deliver to this address button")
                print(appCredentialsVm.showChooseDeliveryView)
                appCredentialsVm.showChooseDeliveryView = true
                print(appCredentialsVm.showChooseDeliveryView)
                
            }
        }
        
        .fullScreenCover(isPresented: $appCredentialsVm.showChooseDeliveryView) {
            ChooseDeliveryView()
        }
        
    }
}

struct SelectDeliveryAddressView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDeliveryAddressView()
    }
}

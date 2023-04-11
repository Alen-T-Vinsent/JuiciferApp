//
//  SingleJuiceView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 08/04/23.
//

import SwiftUI

struct SingleJuiceView: View {
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        ZStack{
            //for Linear background
            LinearGradient(gradient: appCredentialsVm.gradient, startPoint: .bottom, endPoint: .topLeading)
                .ignoresSafeArea(.all)
            
            
            //main vstack
            VStack{
                
                //1st half
                VStack{
                   
                    Spacer()
                    
                }

//                .background(Color.green)
                
                Spacer(minLength: 0)
                
                
                //2nd half
                VStack(alignment:.leading){
                    
                    //for juice Image
                    HStack{
                        
                    }
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
//                    .background(Color.black)
                    
                    //For Name of juice and Love button
                    HStack{
                        Text("Mango Smoothie")
                            .font(.title.bold())
                        Spacer()
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .padding()
                            .background(.green)
                            .clipShape(Circle())
                    }//:Hstack
                    
                    HStack{
                        ForEach(1...5,id:\.self){each in
                            Image(systemName: "star")
                        }
                        Text("5/5")
                            .padding(5)
                            .padding(.leading,5)
                            .padding(.trailing,5)
                            .background(Color("bg-main-lightBrown"))
                            .cornerRadius(10)
                            .foregroundColor(Color.white)
                        
                    }
                    
                    
                    //for price
                    Text("Price $15")
                        .font(.title2.bold())
                        .padding(.top)
                        .padding(.bottom)
                    
                    
                    //for + - and count of juices
                    HStack{
                        Text("-")
                            .font(.title.bold())
                            .frame(width: 50,height: 50)
                            .background(Color("bg-main-lightBrown"))
                            .cornerRadius(10)
                        Text("1")
                            .font(.title.bold())
                            .frame(width: 50,height: 50)
                            .cornerRadius(10)
                            .foregroundColor(Color.black)
                        Text("+")
                            .font(.title2.bold())
                            .frame(width: 50,height: 50)
                            .background(Color("bg-main-lightBrown"))
                            .cornerRadius(10)
                    }//:Hstack
                    .foregroundColor(Color.white)
                    
                    Text("Cold ,creamy ,thick mango smoothie filled with thick mango juce")
                        .font(.title3.bold())
                    
                    //spacer to split up and buttons at botttom
                    Spacer()
                    
                    //for Add to cart and Buy now Button
                    HStack{
                        HStack{
                            Text("Add to cart")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("bg-main-lightBrown"))
                        .cornerRadius(10)
                        
                        HStack{
                            Text("Buy Now")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("bg-main-lightBrown"))
                        .cornerRadius(10)
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    
                    
 
                }//: 2nd vstack ending
                .padding()
                .frame(width:appCredentialsVm.screenWidth,height:appCredentialsVm.screenHeight/1.5)
//                .background(Color.blue)
                .background(Color("bg-highlighter"))
                .cornerRadius(20)
            }
            .overlay(alignment:.top){
                VStack{
                    Image("image5")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(height: appCredentialsVm.screenHeight/2.1)
                .frame(maxWidth: .infinity)
//
            }
            
            .frame(width: appCredentialsVm.screenWidth,height: appCredentialsVm.screenHeight)
//            .background(Color.red)
                
                

        }
        .overlay(alignment:.top){
            // header
            HStack{
                
                //hamburger
                VStack{
                    Image(systemName: "chevron.left")
                        .bold()
                        .padding()
                }
                .frame(width: 50,height: 50)
                .background(Color("bg-component-highlighter"))
                .cornerRadius(10)
                .onTapGesture {
                    print("back button of SingleJuiceView")
//                    print("before appCredentialVm.showSingleJuiceView ==> \( appCredentialsVm.showSingleJuiceView)")
//                    print(appCredentialsVm.showSingleJuiceView)
//                    appCredentialsVm.showSingleJuiceView = false
//
//                    print("after appCredentialVm.showSingleJuiceView ==> \( appCredentialsVm.showSingleJuiceView)")
                    
                    print("show SingleJuiceView")
                    print("\(appCredentialsVm.showSingleJuiceView)")
//                    appCredentialsVm.showSingleJuiceView = false
                    print("\(appCredentialsVm.showSingleJuiceView)")
                }
             
                
                Spacer()
                
                //cart icon
                VStack{
                    Image(systemName: "cart")
                        .resizable()
                        .padding()
                    
                        .cornerRadius(10)
                }
                .frame(width: 50,height: 50)
                .background(Color("bg-component-highlighter"))
                .cornerRadius(10)
                .onTapGesture {
                    print("ShowCartView")
//                    print("before appCredentialVm.showCartView ==> \( appCredentialsVm.showCartView)")
//                    appCredentialsVm.showCartView = true
//
//                    print("before appCredentialVm.showCartView ==> \( appCredentialsVm.showCartView)")
                    
                    print("\(appCredentialsVm.showCartView)")
                    appCredentialsVm.showCartView = true
                    print("\(appCredentialsVm.showCartView)")
                }
                
            }//:header
            .foregroundColor(Color.white)
            .padding()
            .padding(.top)
            
        }
        .fullScreenCover(isPresented: $appCredentialsVm.showCartView) {
            CartView()
        }
    }
}

struct SingleJuiceView_Previews: PreviewProvider {
    static var previews: some View {
        SingleJuiceView()
    }
}

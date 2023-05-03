//
//  SingleJuiceView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 08/04/23.
//

import SwiftUI

struct SingleJuiceView: View {
    
    @AppStorage("USER_NAME") var USER_NAME = ""
    
    
    @State var juiceData:JuiceModel
    @EnvironmentObject var navigationPathVm:NavigationPathVm
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    @EnvironmentObject var cartVm:CartViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var isHomeActive:Bool
    @State var popUpCart = false
    
    //to show pop over "Added to cart"
    @State var showPopOverItemAddedToCart:Bool = false
    
    @State var quantityTxt:Int = 1
    
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
                    
                    //For Name of juice and Love button
                    HStack{
                        Text("\(juiceData.name)")
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
                    Text("Price \(juiceData.currentPrice) rs")
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
                            .onTapGesture {
                                decreaseQuantity()
                            }
                        Text("\(quantityTxt)")
                            .font(.title.bold())
                            .frame(width: 50,height: 50)
                            .cornerRadius(10)
                            .foregroundColor(Color.black)
                        Text("+")
                            .font(.title2.bold())
                            .frame(width: 50,height: 50)
                            .background(Color("bg-main-lightBrown"))
                            .cornerRadius(10)
                            .onTapGesture{
                              addQuantity()
                            }
                    }//:Hstack
                    .foregroundColor(Color.white)
                    
                    Text("\(juiceData.description)")
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
                        .onTapGesture {
                            print("juice adding to cart...")
                            let newCartModel = CartItemModel(juiceId: juiceData.id, juiceQuantity: quantityTxt, juiceName: juiceData.name, juicePrice: juiceData.currentPrice)
                            cartVm.updateProductInCart(itemModel: newCartModel)
                            
                            
                            //to show popover "Item added to cart"
                            showPopOverItemAddedToCart.toggle()

                        }
                       
                        .alert("successfully added to cart", isPresented: $showPopOverItemAddedToCart) {
                                    Button("Got it", role: .cancel) { }
                                }
                        
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
        .fullScreenCover(isPresented: $isHomeActive, content: {
                CartView(isHomeActive: $isHomeActive)
        })
        .navigationBarBackButtonHidden(true)
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
                    presentationMode.wrappedValue.dismiss()

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
                        popUpCart = true
                    }
                    

                
                


                
                
                
                
//                .onTapGesture {
//                    print("ShowCartView")
////                    print("before appCredentialVm.showCartView ==> \( appCredentialsVm.showCartView)")
////                    appCredentialsVm.showCartView = true
////
////                    print("before appCredentialVm.showCartView ==> \( appCredentialsVm.showCartView)")
//
//                    print("\(appCredentialsVm.showCartView)")
//                    appCredentialsVm.showCartView = true
//                    print("\(appCredentialsVm.showCartView)")
//                }
                
            }//:header
            .foregroundColor(Color.white)
            .padding()
            .padding(.top)
            
        }
//        .fullScreenCover(isPresented: $appCredentialsVm.showCartView) {
//            CartView()
//        }
    }
    
    
    //MARK: Functions
    
//    func addToCart(cartModel:CartModel){
//
//        var indexToReplace = -1
//
//        for index in 0..<cartVm.cartArray.count {
//            if cartVm.cartArray[index].juiceId  == juiceData.id {
//                // Update the quantity of the item
//                cartVm.cartArray[index] = cartModel
//                indexToReplace = index
//                break
//            }
//        }
//
//        if indexToReplace != -1{
//            cartVm.cartArray[indexToReplace] = cartModel
//        }else{
//            cartVm.cartArray.append(cartModel)
//        }
//
//
//    }
    
    func addQuantity(){
        quantityTxt+=1
    }
    
    func decreaseQuantity(){
        if quantityTxt > 1{
            quantityTxt-=1
        }
    }
}

//struct SingleJuiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleJuiceView()
//    }
//}

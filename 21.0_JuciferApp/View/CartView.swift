//
//  CartView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 08/04/23.
//

import SwiftUI

struct CartView: View {

    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    
    @EnvironmentObject var cartVm:CartViewModel
    @EnvironmentObject var navigationPathVm:NavigationPathVm
    @Environment(\.presentationMode) var presentationMode
    @Binding var isHomeActive:Bool
    @AppStorage("USER_NAME") var USER_NAME = ""

    var totalTxt:  Int {
        cartVm.juicesArray.reduce(0) { $0 + ($1.juicePrice * $1.juiceQuantity) }
    }

    //For orderDetailVM
    @EnvironmentObject var orderDetailsVm:OrderDetailsViewModel
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

                        
                        ForEach(cartVm.juicesArray,id:\.juiceId){each in
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
                                        Text("\(each.juiceName)")
                                            .font(.headline.bold())
                                        
                                        //for + - count
//                                        HStack{
//                                            Text("+  1  -")
//                                                .bold()
//                                                .padding(4)
//                                                .padding(.leading,5)
//                                                .padding(.trailing,5)
//                                                .background(Color("bg-main-darkBrown"))
//                                                .cornerRadius(10)
//                                                .foregroundColor(Color.white)
//                                        }
                                        
                                        //for + - and count of juices
                                        HStack{
                                            Text("-")
                                                .font(.title.bold())
                                                .frame(width: 50,height: 50)
                                                .background(Color("bg-main-lightBrown"))
                                                .cornerRadius(10)
                                                .onTapGesture {
                                                   print("- button clicked")
                                                    decreaseQuantityFromDb(each: each)
                                                   
                                                }
                                            Text("\(each.juiceQuantity)")
                                                .font(.title.bold())
                                                .frame(width: 50,height: 50)
                                                .cornerRadius(10)
                                                .foregroundColor(Color.black)
                                            Text("+")
                                                .font(.title2.bold())
                                                .frame(width: 50,height: 50)
                                                .background(Color("bg-main-lightBrown"))
                                                .cornerRadius(10)
                                                .onTapGesture {
                                                   print("+ button clicked")
                                                    increaseQuantityFromDb(each: each)
                                                    
                                                }
                                        }//:Hstack
                                        .foregroundColor(Color.white)
                                    }
                                   
                                }
                                
                                Spacer()
                                
                                //3.for individual price
                                HStack{
                                    Text("\(each.juicePrice)")
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
        .navigationBarBackButtonHidden(true)
//        .onAppear{
//            cartVm.fetchProducts()
//        }
//        .onDisappear{
//            cartVm.stopListening()
//        }
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
            VStack{
                VStack{
                    
                    //1.sub total
                    HStack{
                        Text("sub total")
                            .onTapGesture {
                                orderDetailsVm.deleteOrderFromOrders()
                            }
                        Spacer()
                        Text("$10")
                    }
                    
                    //2.total
                    HStack{
                        Text("Total")
                        Spacer()
                        Text("\(totalTxt)")
                    }
                    .font(.title.bold())
                    
                    
                    
                    NavigationLink{
                        //hiding it because i need to make payment gate way now straight redirecting to OrderPlaced view
                       // SelectDeliveryAddressView(isHomeActive:$isHomeActive)
                        SelectDeliveryAddressView(isHomeActive: $isHomeActive)
                            .onAppear{
                                let fetchedProducts = cartVm.juicesArray.map{ $0.juiceName}
                                print(fetchedProducts)
                                let orderDetailsModel = OrderDetailsModel(id: UUID().uuidString, status: OrderStatusEnum.ordered, customerName: USER_NAME, products: fetchedProducts, price: totalTxt)
                                orderDetailsVm.addOrderToOrders(item: orderDetailsModel)
                            }
                    } label: {
                       
                            HStack{
    //                            Text("Proceed to pay")
                                Text("Place order")
                                    .font(.subheadline.bold())
                                    .padding()
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color("bg-main-darkBrown"))
                            .cornerRadius(20)
                            .foregroundColor(Color.white)
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
    }
    
    //MARK: Functions
    func increaseQuantityFromDb(each:CartItemModel){
        let newJuiceQuantity = each.juiceQuantity + 1
        let newCartModel = CartItemModel(juiceId: each.juiceId, juiceQuantity: newJuiceQuantity, juiceName: each.juiceName, juicePrice: each.juicePrice)
        cartVm.updateProductInCart(itemModel: newCartModel)
    }
    
    func decreaseQuantityFromDb(each:CartItemModel){
        let newJuiceQuantity = each.juiceQuantity - 1

        if newJuiceQuantity < 1{
            //this means newJuiceQuantity = 0 , so deleting it from cart
            cartVm.deleteProductFromCart(juiceId: each.juiceId)
        }else{
            //decreases and updates realtime
            let newCartModel = CartItemModel(juiceId: each.juiceId, juiceQuantity: newJuiceQuantity, juiceName: each.juiceName, juicePrice: each.juicePrice)
            cartVm.updateProductInCart(itemModel: newCartModel)
        }

    }
}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//    }
//}

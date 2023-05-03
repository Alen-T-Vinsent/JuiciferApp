//
//  SelectDeliveryAddressView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 09/04/23.
//

import SwiftUI

struct SelectDeliveryAddressView: View {
    @AppStorage("USER_NAME") var USER_NAME = ""
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    @EnvironmentObject var navigationPathVm:NavigationPathVm
  
    @EnvironmentObject var orderDetailsVm:OrderDetailsViewModel
    
    @EnvironmentObject var addressViewModel:AddressViewModel
    
    @State var showAddAddressView = false
    @State var enableEditAddress = false
    @State var tappedAddress = AddressModel()
    
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
                        
                        ForEach(Array(addressViewModel.addressArray.enumerated()),id: \.offset){ index,each in
                            VStack{
                                HStack{
                                    
                                    
                                    if each.id == addressViewModel.addressArray[0].id{
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
                                    }else{
                                        VStack{
                                            Image(systemName: "circle.dotted")
                                            
                                                .padding()
                                            Spacer()
                                        }
                                        .onTapGesture{
                                            var temp = addressViewModel.addressArray[0]
                                            addressViewModel.addressArray[0] = each
                                            addressViewModel.addressArray[index] = temp
                                        }
                                    }
                                    
                                    
                                    VStack(alignment:.leading){
                                        Text("address 1...15")
                                            .font(.callout.bold())
                                        
                                        Text("\(each.name)")
                                            .font(.title2.bold())
                                        Text("\(each.buildingName ?? "")")
                                        Text("\(each.street)")
                                        Text("\(each.city)")
                                        Text("\(each.state), \(each.zipCode)")
                                        Text("\(each.country)")
                                        Text("Phone Number : \(each.phoneNumber1),\(each.phoneNumber2)")
                                    }
                                    .padding(.vertical,10)
                                    
                                    Spacer()
                                    
                                }
                                
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
                                    .onTapGesture {
                                        enableEditAddress = true
                                        tappedAddress = each
                                        showAddAddressView = true
                                    }
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
        .navigationBarBackButtonHidden(true)
        .onAppear{

            addressViewModel.fetchProducts()
            
            
        }
        .onDisappear{
            addressViewModel.stopListening()
        }
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
                    .onTapGesture {
                        showAddAddressView = true
                        
                    }
                    
                    
                    
                    
                }//:header
                .foregroundColor(Color.white)
                .padding()
                
                Spacer()
                
            }
            .padding()
            .shadow(radius: 19)
        }
        
        .overlay(alignment:.bottom){
            
            
            NavigationLink{
                OrderPlacedView(isHomeActive: $isHomeActive)
//                    .onAppear{
//
//                        let orderDetailsModel = OrderDetailsModel(id: UUID().uuidString, status: OrderStatusEnum.ordered, customerName: USER_NAME, products: ["Carrot juice","Apple juice"], price: 10000)
//                        orderDetailsVm.addOrderToOrders(item: orderDetailsModel)
//                    }
            } label: {
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
            }
            
            
            
            
        }
        
        .sheet(isPresented: $showAddAddressView) {
            AddNewAddressView(addressViewModel: addressViewModel,enableEditAddress: $enableEditAddress,tappedAddress:$tappedAddress,showAddAddressView:$showAddAddressView)
                .presentationDetents([.height(500)])
        }
        
    }
}

//struct SelectDeliveryAddressView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectDeliveryAddressView()
//    }
//}

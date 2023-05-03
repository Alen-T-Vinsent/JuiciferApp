//
//  AddNewAddressView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 17/04/23.
//

import SwiftUI

struct AddNewAddressView: View {
    @ObservedObject var addressViewModel:AddressViewModel
    @State var nameTxt = ""
    @State var buildingNameTxt = ""
    @State var landmarkTxt = ""
    @State var streetTxt = ""
    @State var cityTxt = ""
    @State var stateTxt = ""
    @State var zipTxt = ""
    @State var countryTxt = ""
    @State var phoneNumber1Txt = ""
    @State var phoneNumber2Txt = ""
    
    @Binding var enableEditAddress:Bool
    @Binding var tappedAddress:AddressModel
    @Binding var showAddAddressView:Bool
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text("Name")
                    Text("Building")
                    Text("landmark")
                    Text("street")
                    Text("city")
                    Text("state")
                    Text("zipcode")
                    Text("country")
                    Text("phone no.1")
                    Text("phone no.2")
                }
                
                VStack{
                    TextField("name", text: $nameTxt)
                    TextField("Building Name", text: $buildingNameTxt)
                    TextField("landmark", text: $landmarkTxt)
                    TextField("Street", text: $streetTxt)
                    TextField("city", text: $cityTxt)
                    TextField("state", text: $stateTxt)
                    TextField("zipcode", text: $zipTxt)
                    TextField("country", text: $countryTxt)
                    TextField("PhoneNumber 1", text: $phoneNumber1Txt)
                    TextField("Phone Number 2", text: $phoneNumber2Txt)
                }
            }
            
            HStack{
                Text("Save address")
                    .font(.subheadline.bold())
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color("bg-main-darkBrown"))
            .cornerRadius(20)
            .foregroundColor(Color.white)
            
            .shadow(color:.black,radius: 3)
            .onTapGesture {
                
               
                
                //means adding new address
                if enableEditAddress == false{
                    let id = UUID().uuidString
                    let newAddress = AddressModel(id:id,name: nameTxt, buildingName: buildingNameTxt, landmark: landmarkTxt, street: streetTxt, city: cityTxt, state: stateTxt, zipCode: zipTxt, country: countryTxt, phoneNumber1: phoneNumber1Txt, phoneNumber2: phoneNumber2Txt)
                    addressViewModel.updateAddress(addressModel: newAddress)
                }else{
                //means eding address so no need to use another id use same id.
                    let newAddress = AddressModel(id:tappedAddress.id,name: nameTxt, buildingName: buildingNameTxt, landmark: landmarkTxt, street: streetTxt, city: cityTxt, state: stateTxt, zipCode: zipTxt, country: countryTxt, phoneNumber1: phoneNumber1Txt, phoneNumber2: phoneNumber2Txt)
                    addressViewModel.updateAddress(addressModel: newAddress)
                }
                
                showAddAddressView = false
                
            }
            
            if enableEditAddress {
                HStack{
                    Text("delete address")
                        .font(.subheadline.bold())
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color("bg-main-darkBrown"))
                .cornerRadius(20)
                .foregroundColor(Color.white)
                
                .shadow(color:.black,radius: 3)
                .onTapGesture {
                    addressViewModel.deleteProductFromCart(addressId: tappedAddress.id)
                    showAddAddressView = false
                }
            }
           
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .padding()
        .background(Color.white)
        .onAppear{
            if enableEditAddress{
                nameTxt = tappedAddress.name
                buildingNameTxt = tappedAddress.buildingName ?? ""
                landmarkTxt = tappedAddress.landmark
                streetTxt = tappedAddress.street
                cityTxt = tappedAddress.city
                stateTxt = tappedAddress.state
                zipTxt = tappedAddress.zipCode
                countryTxt = tappedAddress.country
                phoneNumber2Txt = tappedAddress.phoneNumber2
                phoneNumber1Txt = tappedAddress.phoneNumber1
                
            }
        }
        .onDisappear{
            enableEditAddress = false
        }
        
        
    }
    
}


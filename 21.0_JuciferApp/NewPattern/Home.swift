//
//  HomeView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.

import SwiftUI

struct Home: View {
    
    ///for search
    var searchResults: [JuiceModel] {
        if searchText.isEmpty {

            //for sorting
            switch(sortStatus){
            case ._default:
                let sorted = juiceVm.juicesArray
                if filterStatus == ._default{
                    return sorted
                }else{
                    let filtered = sorted.filter{$0.type.localizedCaseInsensitiveContains(filterStatus.rawValue)}
                    return filtered
                }
            case .highToLow:
                let sorted = juiceVm.juicesArray.sorted { $0.currentPrice > $1.currentPrice }
                if filterStatus == ._default{
                    return sorted
                }else{
                    let filtered = sorted.filter{$0.type.localizedCaseInsensitiveContains(filterStatus.rawValue)}
                    return filtered
                }
            case .lowToHigh:
                let sorted = juiceVm.juicesArray.sorted { $0.currentPrice < $1.currentPrice }
                if filterStatus == ._default{
                    return sorted
                }else{
                    let filtered = sorted.filter{$0.type.localizedStandardContains(filterStatus.rawValue)}
                    return filtered
                }
        }
            
        } else {//if searchText is not empty
            
            //for sorting
            switch(sortStatus){
            case ._default:
                let sorted = juiceVm.juicesArray.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                if filterStatus == ._default{
                    return sorted
                }else{
                    let filtered = sorted.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                    return filtered
                }
            case .highToLow:
                let sorted = juiceVm.juicesArray.sorted { $0.currentPrice > $1.currentPrice }
                
                if filterStatus == ._default{
                    return sorted
                }else{
                    let filtered = sorted.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                    return filtered
                }
            case .lowToHigh:
                let sorted = juiceVm.juicesArray.sorted { $0.currentPrice < $1.currentPrice }
                if filterStatus == ._default{
                    return sorted
                }else{
                    let filtered = sorted.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                    return filtered
                }
        }
            
           
        }//:else
    }
    
    enum sortEnum:String,CaseIterable{
        case lowToHigh = "Low to High"
        case highToLow = "High to Low"
        case _default = "Default"
    }
    
    enum filterEnum:String,CaseIterable{
       case juice = "Juice"
        case smoothie = "Smoothie"
        case shakes = "Shakes"
        case _default = "Default"
    }
    
    @State var sortStatus:sortEnum = ._default
    @State var filterStatus:filterEnum = ._default
    
    
    @AppStorage("LOGGIN_STATUS") var LOGGIN_STATUS = false
    @AppStorage("USER_NAME") var USER_NAME = ""
    
    
    var nameAaray = ["alen" , "aron" , "hello" , "unix"]
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    @EnvironmentObject var juiceVm:JuiceViewModel
    
    
    @State var selectedOption = ""

    @State var isHomeActive = false
    
    let options = ["drink" , "juice" , "shake"]
    @State var selectedItem = "Shak"
    @State var searchText = ""
    var body: some View {
        NavigationStack{
            ZStack{
                //for background linear gradient color
                LinearGradient(gradient:appCredentialsVm.gradient, startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                
                //for full vstack
                VStack{
                    //header
                    HStack{
                        //hamburger
                        VStack{
                            Image(systemName: "line.3.horizontal")
                        
                                .padding()
                                
                        }
                        .frame(width: 50,height: 50)
                        .background(Color("bg-component-highlighter"))
                        .cornerRadius(10)
                        .onTapGesture {
                             LOGGIN_STATUS = false
                             USER_NAME = ""
                            
                        }
                       Spacer()
                        
                        //bell icon
                        VStack{
                            Image(systemName: "bell.fill")
                                .resizable()
                                .padding()
                                
                                .cornerRadius(10)
                        }
                        .frame(width: 50,height: 50)
                        .background(Color("bg-component-highlighter"))
                        .cornerRadius(10)
                        
                    }//:header
                    .padding()
                    .foregroundColor(Color.white)
                    
                    
                    //for search field
                    TextField("Search ...", text: $searchText)
                        .frame(height:35)
                                    .padding(7)
                                    .padding(.horizontal, 40)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .padding(.horizontal, 10)
                                    .overlay(alignment:.leading){
                                        Image(systemName: "magnifyingglass")
                                            .bold()
                                            .padding(.leading,30)
                                        
                                    }
                    
                    //for sort and filter
                    HStack{
                       
                        Menu {
                            ForEach(filterEnum.allCases,id:\.self) { each in
                                Button {
                                    filterStatus = each
                                } label: {
                                    Text("\(each.rawValue)")
                                }

                            }
                        } label: {
                            //for filter
                            HStack{
                                Image(systemName: "slider.vertical.3")
                                Text("filter")
                            }
                            .frame(height: 40)
                            .frame(maxWidth: appCredentialsVm.screenWidth/2)
                            .background(Color.white)
                            .cornerRadius(10)
                            
                        }//:Label
                        Spacer()
                        
                        //for sort
                        Menu {
                            //ForEach
                            ForEach(sortEnum.allCases,id: \.self) { each in
                                Button {
                                    sortStatus = each
                                } label: {
                                    Text("\(each.rawValue)")
                                }

                            }
                        } label: {
                           
                            HStack{
                                Image(systemName: "line.3.horizontal.decrease")
                                Text("sort")
                            }
                            .frame(height: 40)
                            .frame(maxWidth: appCredentialsVm.screenWidth/2)
                            .background(Color.white)
                            .cornerRadius(10)
                        }//:label

                    }
                    .padding()
                    
                    HStack{
                   
                        HStack{
                            VStack{
                                ForEach(options,id: \.self){each in
                                    HStack{
                                        Text("\(each)")
                                            .bold()
                                            .foregroundColor(Color.white)
                                            .rotationEffect(Angle(degrees: -90))
                                            .font(.subheadline)
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            selectedItem = each
                                        }
                                    }
                                    .frame(minHeight: 100)
                                    .frame(maxWidth: 50)
                                    .background(selectedItem == each ? Color("bg-component-highlighter") : .clear)
                                    .cornerRadius(10)
                                    
                                    
                                }
                                .padding(.top,19)
                            
                                Spacer()
                            }
                            .frame(maxWidth:45,maxHeight:.infinity)
                            .background(.clear)
                        }
                        .frame(maxWidth:70,maxHeight: .infinity)
                        Spacer()
                        
                        
                            ScrollView(.vertical){
                                Spacer(minLength: 50)
                                ForEach(searchResults,id: \.id){ each in
                                    
//                                    VStack{
//                                        NavigationLink {
//                                            SingleJuice(juiceData:each, isHomeActive: $isHomeActive)
//                                        } label: {
//                                            VStack{
//                                                CustomJuiceView(juice: each)
//                                                    .frame(width: 250,height: 350)
//                                            }
//                                            .padding(.trailing,20)
//                                            .padding(.top,10)
//                                        }
                                        
//                                    }
                                    
                                    
                                    NavigationLink {
                                        SingleJuice(juiceData:each, isHomeActive: $isHomeActive)
                                    } label: {
                                        VStack{
                                            CustomJuiceView(juice: each)
                                                .frame(width: 250,height: 350)
                                        }
                                        .padding(.trailing,20)
                                        .padding(.top,10)
                                    }
                                }

                                Spacer()
                                
                            }
                        
                     
                        Spacer()
                            
                    }
                    .frame(maxWidth: .infinity,maxHeight: appCredentialsVm.screenHeight)
                    .background(.clear)
                    .padding()
    
                }//: for full vstack
                .frame(maxWidth: .infinity,maxHeight:appCredentialsVm.screenHeight)
            }
            .fullScreenCover(isPresented: $appCredentialsVm.showSingleJuiceView) {
//                SingleJuiceView()
            }
            .onAppear {
                
            }
        }//:NavigationStack
        
        
    }
}




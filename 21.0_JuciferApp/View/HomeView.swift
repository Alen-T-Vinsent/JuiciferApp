//
//  HomeView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("LOGGIN_STATUS") var LOGGIN_STATUS = false
    @AppStorage("USER_NAME") var USER_NAME = ""
    

    
    var nameAaray = ["alen" , "aron" , "hello" , "unix"]
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    @EnvironmentObject var juiceVm:JuiceViewModel
    @EnvironmentObject var navigationPathVm:NavigationPathVm
    
    
    @State var selectedOption = ""

    @State var isHomeActive = false
    
    let options = ["All" , "juice" , "shake"]
    @State var selectedItem = "Shak"
    @State var searchText = ""
    var body: some View {
        NavigationView{
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
                        //for filter
                        HStack{
                            Image(systemName: "slider.vertical.3")
                            Text("filter")
                        }
                        .frame(height: 40)
                        .frame(maxWidth: appCredentialsVm.screenWidth/2)
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        Spacer()
                        
                        //for sort
                        HStack{
                            Image(systemName: "line.3.horizontal.decrease")
                            Text("sort")
                        }
                        .frame(height: 40)
                        .frame(maxWidth: appCredentialsVm.screenWidth/2)
                        .background(Color.white)
                        .cornerRadius(10)    
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
    //                        .background(Color.yellow)
                            .background(.clear)
    //                        .overlay(alignment:.trailing){
    //                            Rectangle()
    //                                .frame(width: 1,height: 350)
    //                                .foregroundColor(Color.white)
    //                                .offset(x:7,y:-60)
    //                        }
                                
                        }
                        .frame(maxWidth:70,maxHeight: .infinity)
    //                    .background(Color.pink)
                        //.background(.clear)
                        
                       
                        Spacer()
                        
                        
                            ScrollView(.vertical){
                                Spacer(minLength: 50)
                                ForEach(juiceVm.juicesArray,id: \.name){ each in
                                
                                    NavigationLink(isActive: $isHomeActive) {
                                        SingleJuiceView(juiceData:each, isHomeActive: $isHomeActive)
                                    } label: {
                                        VStack{
                                            CustomJuiceView(juice: each)
                                                .frame(width: 250,height: 350)
                                                .overlay(alignment:.center){
                                                }
                                        }
                                        .padding(.trailing,20)
                                        .padding(.top,10)
                                    }
                                }

                                //making searchable
                                .searchable(text: $searchText)
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




struct CustomJuiceView:View{
    @State var juice:JuiceModel
    var body:some View{
        VStack {
            Image("Image")
                .resizable()
                .frame(width: 220,height: 250)
                .aspectRatio(contentMode: .fit)
                .overlay(alignment:.topTrailing){
                    Image(systemName: "heart.fill")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 40,height: 40)
                        .padding()
                }
    
                .overlay(alignment:.center){
                    VStack(alignment:.center){
                        VStack{
                            Image("image2")
                                .resizable()
                                //.frame(width: 700,height: 450)
                                .frame(width: 400,height: 290)
                        }
                            //.frame(width: 700,height: 500)
                            .frame(width: 220,height: 300)
                            .overlay(alignment:.bottom){
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("\(juice.name)")
                                            
                                            .font(.headline)
                                            .foregroundColor(Color("bg-main-darkBrown"))
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)
                                    HStack{
                                        Text("\(juice.currentPrice) rs")
                                           
                                            .font(.headline)
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                .padding(.leading,70)
                                .offset(x:-30,y:40)
                            }

                    }
                    .offset(x:-10,y:-70)
                   
                    

                }
//                .overlay(alignment:.topTrailing){
//                    Image(systemName: "heart.fill")
//                        .resizable()
//                        .frame(width: 50,height: 50)
//                        .foregroundColor(Color.red)
//                        .padding(40)
//                }
                
        }
//        .frame(width: 220,height: 300)
        .background(Color.clear)
    }
}


struct CustomJuiceViewCopy:View{
    var body:some View{
        VStack {
            Image("Image")
                .resizable()
                .frame(width: 220,height: 250)
                .aspectRatio(contentMode: .fit)
                .overlay(alignment:.topTrailing){
                    Image(systemName: "heart.fill")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 40,height: 40)
                        .padding()
                }
    
                .overlay(alignment:.center){
                    VStack(alignment:.center){
                        VStack{
                            Image("image2")
                                .resizable()
                                //.frame(width: 700,height: 450)
                                .frame(width: 400,height: 290)
                        }
                            //.frame(width: 700,height: 500)
                            .frame(width: 220,height: 300)
                            .overlay(alignment:.bottom){
                                VStack(alignment: .leading){
                                    Text("strwarberry \nshake")
                                        .font(.headline)
                                        .foregroundColor(Color("bg-main-darkBrown"))
                                    Text("$10")
                                        .font(.title)
                                }
                                .offset(x:-30,y:40)
                               
                            }

                    }
                    .offset(x:-10,y:-70)
                   
                    

                }
//                .overlay(alignment:.topTrailing){
//                    Image(systemName: "heart.fill")
//                        .resizable()
//                        .frame(width: 50,height: 50)
//                        .foregroundColor(Color.red)
//                        .padding(40)
//                }
                
        }
//        .frame(width: 220,height: 300)
        .background(Color.clear)
    }
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//            .environmentObject(AppCredentialsViewModel())
//            .previewLayout(PreviewLayout.sizeThatFits)
//    }
//}

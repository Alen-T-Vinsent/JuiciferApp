//import SwiftUI
//
//struct ContentView1: View {
//    var body: some View {
//        NavigationStack {
//            NavigationLink {
//                VStack{
//                    Text("text one")
//                }
//            } label: {
//                Text("Navigaton Link1")
//                Image(systemName: "person.fill")
//            }
//
//
//            NavigationLink {
//                DestinationView()
//                .background(Color.yellow)
//                .navigationBarBackButtonHidden(true)
//
//                NavigationLink {
//                    DestinationView2()
//                        .navigationBarBackButtonHidden(true)
//                } label: {
//                    Text("go to destinationView2")
//                }
//
//            } label: {
//                Text("Navigaton Link2")
//                Image(systemName: "person")
//            }
//
//            .navigationTitle("Main home")
//        }
//    }
//}
//
//struct DestinationView: View {
//    @Environment(\.presentationMode) var presentationMode
//    var body: some View {
//        Text("This is the destination view!")
//            .frame(maxWidth: .infinity,maxHeight: .infinity)
//            .overlay(alignment:.topLeading){
//                Image(systemName: "arrow.left")
//                    .padding()
//                    .foregroundColor(Color.red)
//                    .onTapGesture {
//                        print("custom backbutton pressed")
//                        presentationMode.wrappedValue.dismiss()
//                    }
//
//
//            }
//
//
//
//    }
//}
//
//struct DestinationView2: View {
//    @Environment(\.presentationMode) var presentationMode
//    var body: some View {
//        Text("This is the DestinationView2")
//            .frame(maxWidth: .infinity,maxHeight: .infinity)
//            .overlay(alignment:.topLeading){
//                Image(systemName: "arrow.left")
//                    .padding()
//                    .foregroundColor(Color.green)
//                    .onTapGesture {
//                        print("custom backbutton pressed")
//                        presentationMode.wrappedValue.dismiss()
//                    }
//
//            }
//
//        NavigationLink {
//            DestinationView3()
//                .navigationBarBackButtonHidden(true)
//        } label: {
//            Text("go to destinationView3")
//        }
//    }
//}
//
//
//struct DestinationView3: View {
//    @Environment(\.presentationMode) var presentationMode
//    var body: some View {
//        Text("This is the DestinationView3")
//            .frame(maxWidth: .infinity,maxHeight: .infinity)
//            .overlay(alignment:.topLeading){
//                Image(systemName: "arrow.left")
//                    .padding()
//                    .foregroundColor(Color.green)
//                    .onTapGesture {
//                        print("custom backbutton pressed")
//                        presentationMode.wrappedValue.dismiss()
//                    }
//
//            }
//
//        NavigationLink {
//            ContentView1()
//                .navigationBarBackButtonHidden(true)
//        } label: {
//            Text("go to root view Main home")
//        }
//    }
//}
//
//
//struct DestinationView4: View {
//    @Environment(\.presentationMode) var presentationMode
//    var body: some View {
//        Text("This is the DestinationView4")
//            .frame(maxWidth: .infinity,maxHeight: .infinity)
//            .overlay(alignment:.topLeading){
//                Image(systemName: "arrow.left")
//                    .padding()
//                    .foregroundColor(Color.green)
//                    .onTapGesture {
//                        print("custom backbutton pressed")
//                        presentationMode.wrappedValue.dismiss()
//                    }
//
//            }
//    }
//}
//
//
//struct previP:PreviewProvider{
//    static var previews: some View{
//        ContentView1()
//    }
//}


//----- ------ -------- -------- -------- -------- ----------


import SwiftUI

struct ContentView1: View {
    
    @State var showSettings = false
    
    @State var path = NavigationPath()
    
    
    var body: some View{
        VStack{
            NavigationStack(path:$path){
                Text("Root View")
                List{
                    NavigationLink("Go to details A",value: "show AAA")
                    
                    NavigationLink("Go to details B",value: "show BBB")
                    
                    NavigationLink("Go to details One",value: 1)
                    
                   
                    
                    Button("got to toggle settings") {
                        showSettings.toggle()
                    }
                    
                    Section("Old"){
                        NavigationLink("old link with destination"){
                            Text("old navigation link")
                        }
                        NavigationLink("old link limitation with destination"){
                            Text("old navigation link")
                            NavigationLink("go to 2", value: 2)
                        }
                    }
                    
                }
                .navigationDestination(for: String.self) { textValue in
                    DetailView(text: textValue)
                }
                .navigationDestination(for: Int.self) { intValue in
                    DetailView(text: "\(intValue)")
                }
                .navigationDestination(isPresented: $showSettings) {
                    Text("settings")
                }
                .navigationTitle("Main Root")
            }
            
            
            HStack{
                Text("Path : no of detail views  -> ")
                Text("\(path.count)")
            }
            
            HStack{
                Button {
                    path.removeLast()
                } label: {
                    Text("go back on View")
                }

               
            }
            
            HStack{
                Button {
                    path.append("NEW Appended")
                } label: {
                    Text("add to path  New Append")
                }

               
            }
            
            
            HStack{
                Button {
                    path = NavigationPath()
                } label: {
                    Text("go to root")
                }

               
            }
        }
    }
    
}

struct previP:PreviewProvider{
    static var previews: some View{
        ContentView1()
    }
}


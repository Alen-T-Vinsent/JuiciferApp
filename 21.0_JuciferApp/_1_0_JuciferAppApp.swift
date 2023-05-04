//
//  _1_0_JuciferAppApp.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 06/04/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct _1_0_JuciferAppApp: App {
  
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    

    @StateObject var appCredentialsVm = AppCredentialsViewModel()
    @StateObject var juiceVm = JuiceViewModel()
    @StateObject var navigationPathVm = NavigationPathVm()
    @StateObject var cartVm = CartViewModel()
    @StateObject var addressViewModel = AddressViewModel()
    
    @StateObject var signInVm = SignInViewModel()
    @StateObject var signUpVm = SignUpViewModel()

    
    //For OrderDetailsViewModel
    @StateObject var orderDetailsViewModel = OrderDetailsViewModel()
    
    @StateObject var buyViewModel = BuyViewModel()
    
    var body: some Scene {
        WindowGroup {
           // CoreDataBootcamp()
            VStack{

              ContentView()
            }
                .environmentObject(appCredentialsVm)
                .environmentObject(juiceVm)
                .environmentObject(navigationPathVm)
                .environmentObject(orderDetailsViewModel)
                .environmentObject(cartVm)
                .environmentObject(buyViewModel)
                .environmentObject(addressViewModel)
                .environmentObject(signInVm)
                .environmentObject(signUpVm)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("FIREBASE CONFIGURED")
    return true
  }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
}


import CoreData

class CoreDataViewModel:ObservableObject{
    @Published var savedEntities:[UserEntity] = []
    // Storage for Core Data
    let container: NSPersistentContainer
    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "UserCredentials")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        //for fetching
        fetchUser()
    }
    
    //fetch user
    func fetchUser(){
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        
        do{
            savedEntities =  try container.viewContext.fetch(request)
        }catch let error {
            print("Error fethching data ")
        }
        
    }
    
    func addUser(text:String){
        let newUser = UserEntity(context: container.viewContext)
        newUser.uniqueName = text
        saveUserdata()
    }
    func saveUserdata(){
        do{
            try  container.viewContext.save()
            fetchUser()
        }catch let error{
                print(error)
            }
    }
    
    func deleteUser(){
        if savedEntities.isEmpty == false{
            let entity = savedEntities[0]
            container.viewContext.delete(entity)
            saveUserdata()
        }
        
    }
    
    func updateZerothUser(entity:UserEntity,newText:String){
        if savedEntities.isEmpty == false{
            entity.uniqueName = newText
            saveUserdata()
        }
    }
    
    func updateUser(entity:UserEntity,newName:String){
        let currentUserName = entity.uniqueName
        entity.uniqueName = newName
        saveUserdata()
    }
    
}

struct CoreDataBootcamp:View{
    @StateObject var cvm = CoreDataViewModel()
    @State var text = "User22"
    var body: some View{
        ForEach(cvm.savedEntities,id:\.id){each in
            HStack{
                Text(each.uniqueName ?? "unknown")
                    .foregroundColor(Color.black)
                    .onTapGesture {
                        cvm.deleteUser()
                    }
            }
            Button {
                cvm.addUser(text: "dsd")
            } label: {
                Text("add")
            }

            
            
        }
        .onAppear{
            
                cvm.addUser(text: "User1111")
            
           
        }
    }
}

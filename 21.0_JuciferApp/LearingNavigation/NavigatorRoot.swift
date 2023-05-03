//
//  NavigatorRoot.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 15/04/23.
//

import SwiftUI

struct NavigatorRoot: View {
    @State var path = NavigationPath()
    var body: some View {
        VStack{
            NavigationStack(path:$path){
                ForEach(1...10,id:\.self){ each in
                    
                    NavigationLink("navigate",value: "navigate\(each)")
                        .navigationDestination(for:String.self) { text in
                            Text(text)
                        }

                    
                    
                }
                

            }
            
            Text("go back")
                .onTapGesture {
                    path.removeLast()
                }
            Text("\(path.count)")
            Text("\(path)" as String)
        }
    
    }
}

struct NavigatorRoot_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorRoot()
    }
}

//
//  DetailView.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 11/04/23.
//

import SwiftUI

struct DetailView: View {
    let text:String
    
    var body: some View {
        VStack{
            Text("detail view showing \(text)")
             Divider()
             NavigationLink("Link to 3", value: 3)
            NavigationLink("Link to CCC", value: "CCC")
        }
        .navigationTitle(text)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(text: "CCC")
    }
}

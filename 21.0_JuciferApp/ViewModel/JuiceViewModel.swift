//
//  JuiceViewModel.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 15/04/23.
//

import Foundation
import Firebase

class JuiceViewModel:ObservableObject{
    @Published var juicesArray:[JuiceModel] = []
    @Published var juicesArrayForSearch:[JuiceModel] = []
    
    private let db = Firestore.firestore()
    
    init(){
        fetchJuices()
    }
    
    func fetchJuices(){
        db.collection("Juices").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else{
                print("Error in fetching juices \(String(describing: error))")
                return
            }
            
            self.juicesArray = documents.compactMap({ document -> JuiceModel? in
                guard let data = document.data() as? [String:Any],
                      let name = data["name"] as? String,
                      let price = data["price"] as? Int,
                      let discountedPrice = data["discountedPrice"] as? Int,
                      let discountPercentage = data["discountPercentage"] as? Int,
                      let description = data["description"] as? String,
                      let type = data["type"] as? String
                else{return nil}
                
                self.juicesArrayForSearch = self.juicesArray

                print("returning juicemodel")
                let id = document.documentID
                print(JuiceModel(id: id, name: name, currentPrice: price, discountedPrice: discountedPrice, discountPercentage: discountPercentage, description: description, type: type))
                return JuiceModel(id: id, name: name, currentPrice: price, discountedPrice: discountedPrice, discountPercentage: discountPercentage, description: description, type: type)
            })
            
        }
        
    }

}


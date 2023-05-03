//
//  BuyViewModel.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 26/04/23.
//

import Foundation
import Firebase

class BuyViewModel: ObservableObject {
    
    //let cartRef = Firestore.firestore().collection("CART").document("user13")
    //hided to edit user13
    let cartRef = Firestore.firestore().collection("SingleOrders")
    
    @Published var juicesArray = [BuyItemModel]()
    private var listenerRegistration: ListenerRegistration?
    
    @Published var userName:String = "user13"

    @Published var lastAddedJuiceId:String = ""
   
    init(){
        fetchProducts()
    }
    
    func fetchProducts(){
        cartRef.document(self.userName).addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            guard let productData = data["product"] as? [[String: Any]] else {
                print("Product data was empty.")
                return
            }
            
            print(productData)
                     
                self.juicesArray = productData.map { data in
                    if let juiceId = data["juiceId"] as? String,
                       let juiceQuantity = data["juiceQuantity"] as? Int,
                       let juiceName = data["juiceName"] as? String,
                       let juicePrice = data["juicePrice"] as? Int {
                        print( BuyItemModel(juiceId: juiceId, juiceQuantity: juiceQuantity, juiceName: juiceName, juicePrice: juicePrice))
                        return BuyItemModel(juiceId: juiceId, juiceQuantity: juiceQuantity, juiceName: juiceName, juicePrice: juicePrice)
                    } else {
                        print("nil returening ")
                        return nil // or handle the error case in some other way
                    }
                }.compactMap { $0 }
                
                
                
        }
        
      
    }
    
    func stopListening() {
        listenerRegistration?.remove()
    }
    
    func updateProductInCart(itemModel:BuyItemModel) {

        let juiceId = itemModel.juiceId
        let newQuantity = itemModel.juiceQuantity
        
        cartRef.document(self.userName).getDocument { (document, error) in
            if let document = document, document.exists {
                var products = document.data()?["product"] as? [[String: Any]] ?? []
                if let index = products.firstIndex(where: { $0["juiceId"] as? String == juiceId }) {
                    // If the product with the given name exists in the array, update its price
                    products[index]["juiceQuantity"] = newQuantity
                    self.cartRef.document(self.userName).updateData(["product": products])
                } else {
                    // If the product with the given name doesn't exist in the array, do nothing
                    print("Product not found")
                    print("no product so calling addProductToCart...")
                    self.addProductToCart(item: itemModel)
                    
                }
            } else {
                // If the document doesn't exist, do nothing
                print("Document not found")
                self.addProductToCart(item: itemModel)
            }
        }
    }
    
    func addProductToCart(item:BuyItemModel) {
        cartRef.document(self.userName).getDocument { [self] (document, error) in
            if let document = document, document.exists {
                // If the document exists, update the array
                var products = document.data()?["product"] as? [[String: Any]] ?? []
               // Create the new product dictionary
                let newProduct = item.cartItemModelDictionary
                products.append(newProduct) // Add the new product to the array
                self.cartRef.document(self.userName).updateData(["product": products]) // Update the "product" field in the document with the new array
            } else {
                // If the document doesn't exist, create it with the new array
                // Create the new product dictionary
                let newProduct = item.cartItemModelDictionary // Create the new product dictionary
                let products = [newProduct] // Create an array with the new product
                self.cartRef.document(self.userName).setData(["product": products]) // Set the "product" field in the document with the new array
            }
        }
    }
    
    func deleteProductFromCart(juiceId: String) {
        cartRef.document(self.userName).getDocument { (document, error) in
            if let document = document, document.exists {
                // If the document exists, update the array
                var products = document.data()?["product"] as? [[String: Any]] ?? []
                products.removeAll { $0["juiceId"] as? String == juiceId } // Remove the product with matching name
                self.cartRef.document(self.userName).updateData(["product": products]) // Update the "product" field in the document with the modified array
            }
        }
    }
}

struct BuyItemModel{
    let juiceId:String
    let juiceQuantity:Int
    let juiceName:String
    let juicePrice:Int
    
    var cartItemModelDictionary:[String:Any]{
        return ["juiceId":juiceId,
                "juiceQuantity":juiceQuantity,
                "juiceName":juiceName,
                "juicePrice":juicePrice]
    }
}

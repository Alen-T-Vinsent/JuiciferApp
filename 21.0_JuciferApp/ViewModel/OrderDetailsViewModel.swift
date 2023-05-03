//
//  OrderDetailsViewModel.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 25/04/23.
//

import SwiftUI
import Firebase

class OrderDetailsViewModel:ObservableObject{
    @Published var orderedArray:[OrderDetailsModel] = []
    
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    private let userOrderRef = Firestore.firestore().collection("Orders")
    
    @Published var userNameFromAdd = ""
    
    @Published var totalCartPrice:Int = 0
    
    
    //MARK: Methods
    
    func stopListening() {
        listenerRegistration?.remove()
    }
    
    
    
    func fetchCurrentUserOrder(customerName:String){
        listenerRegistration = userOrderRef.document(customerName).addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            guard let orderData = data["product"] as? [[String: Any]] else {
                print("Product data was empty.")
                return
            }
            
            print(orderData)
            
            self.orderedArray = orderData.map{ data in
                guard let data = document.data() as? [String:Any],
                      let id = data["id"] as? String,
                      let stausString = data["status"] as? String,
                      let status:OrderStatusEnum =  OrderStatusEnum(rawValue: stausString) ,
                        let customerName:String = data["customerName"] as? String,
                        let products:[String] = data["products"] as? [String],
                        let price:Int = data["price"] as? Int
                        
                        
                else{
                    print("returning nil...from orederedArray coverting fb data ...")
                    return nil
                    
                }//:guard let
                
                
                return OrderDetailsModel(id: id, status: status, customerName: customerName, products: products, price: price)
                
            }.compactMap{$0}
            
        }
        
      
    }
    
    
    
    func updateOrderInOrders(itemModel:OrderDetailsModel) {
        userOrderRef.document(itemModel.customerName).updateData([
            "status": itemModel.status.rawValue,
            "price": itemModel.price,
            "products": itemModel.products
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document updated successfully!")
            }
        }
        
    }
    
    func addOrderToOrders(item:OrderDetailsModel) {
        
        self.userNameFromAdd = item.customerName
        userOrderRef.document(item.customerName).setData(item.orderDetailsModelDictionary) { error in
            if let error = error {
                print("Error adding order: \(error)")
            } else {
                print("Order added successfully!")
            }
        }
    }
    
    
    func deleteOrderFromOrders() {
        // Delete the document
        userOrderRef.document().delete() { error in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                print("Document deleted successfully!")
            }
        }
    }
    

    func fetchProducts() -> [CartItemModel] {
        var products = [CartItemModel]()
        userOrderRef.document(self.userNameFromAdd).addSnapshotListener { (documentSnapshot, error) in
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

            products = productData.compactMap { data -> CartItemModel? in
                guard let juiceId = data["juiceId"] as? String,
                    let juiceQuantity = data["juiceQuantity"] as? Int,
                    let juiceName = data["juiceName"] as? String,
                    let juicePrice = data["juicePrice"] as? Int else {
                        print("Invalid product data: \(data)")
                        return nil
                }
                return CartItemModel(juiceId: juiceId, juiceQuantity: juiceQuantity, juiceName: juiceName, juicePrice: juicePrice)
            }
        }

        return products
    }

    
    
    func getProductArray()->[String]{
        let products = fetchProducts()
        let productNames = products.map { $0.juiceName }
        print(productNames)
        return productNames
    }
    
    
}


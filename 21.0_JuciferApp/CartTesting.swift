//
//  CartTesting.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 17/04/23.
//

import SwiftUI
import Firebase

struct CartTesting: View {
    var body: some View {
        VStack(spacing:30){
            Button("delete product 1") {
                deleteProductFromCart(productName: "product-1")
            }
            Button("add product1 to cart") {
                addProductToCart(productName: "product-1", price: 1000)
            }
            
            
            
            Button("update product1 to cart") {
                updateProductInCart(productName: "product-1", newPrice: 1111)
            }
            
            Divider()
            
            Button("add product4 to cart") {
                addProductToCart(productName: "product-4", price: 4000)
            }
            
            Button("update product4 to cart") {
                updateProductInCart(productName: "product-4", newPrice: 4444)
            }
            Divider()
            
            
            Button("add product2 to cart") {
                addProductToCart(productName: "product-2", price: 2000)
            }
            
            Button("update product2 to cart") {
                updateProductInCart(productName: "product-2", newPrice: 2222)
            }
            
           
          
            
        }
        VStack{
            ProductList()
        }
    }
    
    
    //MARK: Functions
    
    func updateProductInCart(productName: String, newPrice: Double) {
        let db = Firestore.firestore()
        let cartRef = db.collection("cartProduct12").document("user12")
        cartRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var products = document.data()?["product"] as? [[String: Any]] ?? []
                if let index = products.firstIndex(where: { $0["name"] as? String == productName }) {
                    // If the product with the given name exists in the array, update its price
                    products[index]["price"] = newPrice
                    cartRef.updateData(["product": products])
                } else {
                    // If the product with the given name doesn't exist in the array, do nothing
                    print("Product not found")
                }
            } else {
                // If the document doesn't exist, do nothing
                print("Document not found")
            }
        }
    }
    
    
    
    func addProductToCart(productName: String, price: Double) {
        let db = Firestore.firestore()
        let cartRef = db.collection("cartProduct12").document("user12")
        cartRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // If the document exists, update the array
                var products = document.data()?["product"] as? [[String: Any]] ?? []
                let newProduct = ["name": productName, "price": price] // Create the new product dictionary
                products.append(newProduct) // Add the new product to the array
                cartRef.updateData(["product": products]) // Update the "product" field in the document with the new array
            } else {
                // If the document doesn't exist, create it with the new array
                let newProduct = ["name": productName, "price": price] // Create the new product dictionary
                let products = [newProduct] // Create an array with the new product
                cartRef.setData(["product": products]) // Set the "product" field in the document with the new array
            }
        }
    }
    
    func deleteProductFromCart(productName: String) {
        let db = Firestore.firestore()
        let cartRef = db.collection("cartProduct12").document("user12")
        cartRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // If the document exists, update the array
                var products = document.data()?["product"] as? [[String: Any]] ?? []
                products.removeAll { $0["name"] as? String == productName } // Remove the product with matching name
                cartRef.updateData(["product": products]) // Update the "product" field in the document with the modified array
            }
        }
    }

    
    
}

//struct CartTesting_Previews: PreviewProvider {
//    static var previews: some View {
//        CartTesting()
//    }
//}
//


import SwiftUI
import Firebase

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var price: Double
}

class CartViewMode: ObservableObject {
    @Published var products = [Product]()
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    func fetchProducts() {
        listenerRegistration = db.collection("cartProduct12").document("user12").addSnapshotListener { (documentSnapshot, error) in
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
            self.products = productData.map { Product(name: $0["name"] as! String, price: $0["price"] as! Double) }
        }
    }
    
    func stopListening() {
        listenerRegistration?.remove()
    }
}

struct ProductList: View {
    @ObservedObject var cartViewModel = CartViewMode()
    
    var body: some View {
        Button("add dummy data") {
            addDummyData()
        }
        List(cartViewModel.products) { product in
            VStack(alignment: .leading) {
                Text(product.name)
                Text(String(product.price))
            }
        }
        .onAppear {
            cartViewModel.fetchProducts()
        }
        .onDisappear {
            cartViewModel.stopListening()
        }
    }
    
    //MARK: dummy function
    func addDummyData() {
        let db = Firestore.firestore()
        let cartRef = db.collection("cartProduct12").document("user12")
        cartRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // If the document exists, update the array
                var products = document.data()?["product"] as? [[String: Any]] ?? []
                for i in 1...5 {
                    let newProduct = ["name": "Product \(i)", "price": Double(i) * 10.0] // Create a dummy product dictionary
                    products.append(newProduct) // Add the dummy product to the array
                }
                cartRef.updateData(["product": products]) // Update the "product" field in the document with the new array
            } else {
                // If the document doesn't exist, create it with the new array
                var products = [[String: Any]]()
                for i in 1...5 {
                    let newProduct = ["name": "Product \(i)", "price": Double(i) * 10.0] // Create a dummy product dictionary
                    products.append(newProduct) // Add the dummy product to the array
                }
                cartRef.setData(["product": products]) // Set the "product" field in the document with the new array
            }
        }
    }

}

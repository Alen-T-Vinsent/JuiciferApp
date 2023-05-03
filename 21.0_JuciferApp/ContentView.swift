////
////  ContentView.swift
////  21.0_JuciferApp
////
////  Created by Apple  on 06/04/23.
////
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appCredentialsVm:AppCredentialsViewModel
    @AppStorage("LOGGIN_STATUS") var LOGGIN_STATUS = false
    @AppStorage("USER_NAME") var USER_NAME = ""
    var body: some View {
        //sign in and sign up views
        //if appCredentialsVm.loggInStatus || LOGGIN_STATUS == true{
            if LOGGIN_STATUS == true{
            Home()
        }else{
          SignInView()

        }
    }
}
//
//
//
//import SwiftUI
//import Firebase
//
//struct ProductModel {
//    let id: Int
//    let name: String
//    let quantity: Int
//}
//
//
//
////below code working for updating and addin new product in swift ui
//struct ContentView: View {
//    // Firestore reference
//    let db = Firestore.firestore()
//    let cartRef = Firestore.firestore().collection("Cart")
//    let user4Ref = Firestore.firestore().collection("Cart").document("user4")
//
//    // State variables
//    @State var carrotJuiceQuantity = 6
//    @State var orangeJuiceQuantity = 7
//
//    let products = [
//        ProductModel(id: 1, name: "Product 1", quantity: 10),
//        ProductModel(id: 2, name: "Product 2", quantity: 5),
//        ProductModel(id: 3, name: "Product 3", quantity: 2),
//        // Add more products as needed
//    ]
//
//    var body: some View {
//        Button("add to firebase1") {
//            addProductToCart(product: ProductModel(id: 4, name: "Product 4", quantity: 56) )
//        }
//
//
//        Button("add to firebase2") {
//            addProductToCart(product: ProductModel(id: 2, name: "Product 2", quantity: 2) )
//        }
//        Spacer()
//
//        Button("update product") {
//            let product = ProductModel(id: 4, name: "Product 4", quantity: 898)
//            updateProductQuantity(productId: 4, newQuantity: 899)
//        }
//
//        Spacer()
//
//        Button("replace product with ") {
//            let product = ProductModel(id: 4, name: "Product 4", quantity: 898)
//            replaceProduct(productId: 4, newProduct: product)
//        }
//
//
//        Spacer()
//
//        Button("delete product") {
//            let product = ProductModel(id: 4, name: "Product 4", quantity: 898)
//            deleteProduct(product:product)
//        }
//
//        Spacer()
//        VStack {
//            Text("Carrot Juice: \(carrotJuiceQuantity)")
//            HStack {
//                Button("-") {
//                    if carrotJuiceQuantity > 0 {
//                        carrotJuiceQuantity -= 1
//                        updateFirestore()
//                    }
//                }
//                Button("+") {
//                    carrotJuiceQuantity += 1
//                    updateFirestore()
//                }
//            }
//            Text("Orange Juice: \(orangeJuiceQuantity)")
//            HStack {
//                Button("-") {
//                    if orangeJuiceQuantity > 0 {
//                        orangeJuiceQuantity -= 1
//                        updateFirestore()
//                    }
//                }
//                Button("+") {
//                    orangeJuiceQuantity += 1
//                    updateFirestore()
//                }
//            }
//        }
//        .onAppear {
//            // Listen for changes in the carrot juice quantity
//            user4Ref.addSnapshotListener { snapshot, error in
//                guard let snapshot = snapshot else { return }
//                carrotJuiceQuantity = snapshot.data()?["carrotJuiceQuantity"] as? Int ?? 0
//            }
//
//            // Listen for changes in the orange juice quantity
//            user4Ref.addSnapshotListener { snapshot, error in
//                guard let snapshot = snapshot else { return }
//                orangeJuiceQuantity = snapshot.data()?["orangeJuiceQuantity"] as? Int ?? 0
//            }
//        }
//    }
//
//    // Update the Firestore document with the new quantities
//    func updateFirestore() {
//        // Check if the document exists
//        user4Ref.getDocument { snapshot, error in
//            guard let snapshot = snapshot, snapshot.exists else {
//                // Create the document with the initial quantity values
//                user4Ref.setData([
//                    "carrotJuiceQuantity": carrotJuiceQuantity,
//                    "orangeJuiceQuantity": orangeJuiceQuantity
//                ])
//                return
//            }
//
//            // Update the document with the new quantities
//            user4Ref.updateData([
//                "carrotJuiceQuantity": carrotJuiceQuantity,
//                "orangeJuiceQuantity": orangeJuiceQuantity
//            ])
//        }
//    }
//
//    //array union
//    func addProductToCart(product: ProductModel) {
//        // Assuming you have already configured Firebase and have a reference to Firestore
//        let db = Firestore.firestore()
//
//        // Create a reference to the "CartProduct" collection and the "user11" document
//        let cartProductRef = db.collection("CartProduct").document("user11")
//
//        // Append the new product data to the "products" array field in the document
//        cartProductRef.updateData(["products": FieldValue.arrayUnion([
//            ["id": product.id, "name": product.name, "quantity": product.quantity]
//        ])]) { error in
//            if let error = error {
//                // Handle the error
//                print("Error adding product to Firestore: \(error)")
//            } else {
//                // Product added successfully
//                print("Product added to Firestore")
//            }
//        }
//    }
//
//
//    func replaceProduct(productId: Int, newProduct: ProductModel) {
//        // Assuming you have already configured Firebase and have a reference to Firestore
//        let db = Firestore.firestore()
//
//        // Create a reference to the "CartProduct" collection and the "user11" document
//        let cartProductRef = db.collection("CartProduct").document("user11")
//
//        // Create a listener to monitor changes to the "products" field in the document
//        cartProductRef.addSnapshotListener { documentSnapshot, error in
//            guard let document = documentSnapshot else {
//                print("Error fetching document: \(error!)")
//                return
//            }
//
//            // Check if the document exists and has a "products" field
//            guard var products = document.data()?["products"] as? [[String: Any]] else {
//                print("Document does not exist or has no 'products' field")
//                return
//            }
//
//            // Find the index of the product to replace
//            if let index = products.firstIndex(where: { $0["id"] as? Int == productId }) {
//                // Replace the product with the new product data
//                products[index] = ["id": newProduct.id, "name": newProduct.name, "quantity": newProduct.quantity]
//
//                // Update the "products" field in the document with the new array
//                cartProductRef.updateData(["products": products]) { error in
//                    if let error = error {
//                        // Handle the error
//                        print("Error replacing product in Firestore: \(error)")
//                    } else {
//                        // Product replaced successfully
//                        print("Product replaced in Firestore")
//                    }
//                }
//            }
//        }
//    }
//
//
//////set data
////    func addProductToCart(product: ProductModel) {
////        // Assuming you have already configured Firebase and have a reference to Firestore
////        let db = Firestore.firestore()
////
////        // Create a reference to the "CartProduct" collection and the "user10" document
////        let cartProductRef = db.collection("CartProduct").document("user11")
////
////        // Update the "products" array field in the document with the new product data
////        cartProductRef.setData(["products": FieldValue.arrayUnion([
////            ["id": product.id, "name": product.name, "quantity": product.quantity]
////        ])]) { error in
////            if let error = error {
////                // Handle the error
////                print("Error adding product to Firestore: \(error)")
////            } else {
////                // Product added successfully
////                print("Product added to Firestore")
////            }
////        }
////    }
//
//
//    //was working
//
////    func updateProduct(product: ProductModel) {
////        // Assuming you have already configured Firebase and have a reference to Firestore
////        let db = Firestore.firestore()
////
////        // Create a reference to the "CartProduct" collection and the "user10" document
////        let cartProductRef = db.collection("CartProduct").document("user11")
////
////        // Create a listener to monitor changes to the "products" field in the document
////        cartProductRef.addSnapshotListener { documentSnapshot, error in
////            guard let document = documentSnapshot else {
////                print("Error fetching document: \(error!)")
////                return
////            }
////
////            // Check if the document exists and has a "products" field
////            guard let products = document.data()?["products"] as? [[String: Any]] else {
////                print("Document does not exist or has no 'products' field")
////                return
////            }
////
////            // Find the index of the product to update
////            if let index = products.firstIndex(where: { $0["id"] as? Int == product.id }) {
////                // Update the quantity of the product
////                let updatedProduct = ["id": product.id, "name": product.name, "quantity": product.quantity] as [String : Any]
////                var updatedProducts = products
////                updatedProducts[index] = updatedProduct
////
////                // Update the "products" field in the document
////                cartProductRef.updateData(["products": updatedProducts]) { error in
////                    if let error = error {
////                        // Handle the error
////                        print("Error updating product in Firestore: \(error)")
////                    } else {
////                        // Product updated successfully
////                        print("Product updated in Firestore")
////                    }
////                }
////            }
////        }
////    }
//
//
//
//    func updateProductQuantity(productId: Int, newQuantity: Int) {
//        // Assuming you have already configured Firebase and have a reference to Firestore
//        let db = Firestore.firestore()
//
//        // Create a reference to the "CartProduct" collection and the "user11" document
//        let cartProductRef = db.collection("CartProduct").document("user11")
//
//        // Update the quantity of the product with the given ID
//        cartProductRef.updateData([
//            "products": FieldValue.arrayUnion([
//                [
//                    "id": productId,
//                    "quantity": newQuantity
//                ]
//            ])
//        ]) { error in
//            if let error = error {
//                // Handle the error
//                print("Error updating product quantity in Firestore: \(error)")
//            } else {
//                // Product quantity updated successfully
//                print("Product quantity updated in Firestore")
//            }
//        }
//    }
//
//
//
//
//    func deleteProduct(product: ProductModel) {
//        // Assuming you have already configured Firebase and have a reference to Firestore
//        let db = Firestore.firestore()
//
//        // Create a reference to the "CartProduct" collection and the "user10" document
//        let cartProductRef = db.collection("CartProduct").document("user11")
//
//        // Remove the product from the "products" array field in the document
//        cartProductRef.updateData(["products": FieldValue.arrayRemove([
//            ["id": product.id, "name": product.name, "quantity": product.quantity]
//        ])]) { error in
//            if let error = error {
//                // Handle the error
//                print("Error deleting product from Firestore: \(error)")
//            } else {
//                // Product deleted successfully
//                print("Product deleted from Firestore")
//            }
//        }
//    }
//
//
//
//}
//
//
//
//
////struct ContentView_Previews: PreviewProvider {
////    static var previews: some View {
////        ContentView()
////    }
////}
//
////above is working good code
//
//
//
//
//
//
//

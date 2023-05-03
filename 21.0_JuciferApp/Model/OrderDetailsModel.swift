//
//  OrderDetailsModel.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 25/04/23.


import Foundation

struct OrderDetailsModel{
    let id:String
    let status:OrderStatusEnum
    let customerName:String
    let products:[String]
    let price:Int
    
    var orderDetailsModelDictionary:[String:Any]{
        return [
             "id":id,
             "status":status.rawValue,
             "customerName":customerName,
             "products":products,
             "price":price
        ]
    }
}


enum OrderStatusEnum:String{
    case ordered = "ordered"
    case cancelled = "cancelled"
    case returned = "returned"
    case pending = "pending"
    case pickedUp = "pickedUp"
    case delivered = "delivered"
}

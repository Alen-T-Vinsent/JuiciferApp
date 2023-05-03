//
//  JuiceModel.swift
//  21.0_JuciferApp
//
//  Created by Apple  on 14/04/23.
//

import Foundation

struct JuiceModel:Hashable{
    let id:String
    let name:String
    let currentPrice:Int
    let discountedPrice:Int
    let discountPercentage:Int
    let description:String
    let type:String
    
    var juiceDictionary:[String:Any]{
        return ["id":id,
                "name":name,
                "currentPrice":currentPrice,
                "discountedPrice":discountedPrice,
                "discountPercentage":discountPercentage,
                "description":description,
                "type":type
                
        ]
    }
}

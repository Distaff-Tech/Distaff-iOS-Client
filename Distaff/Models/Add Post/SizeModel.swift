//
//  SizeModel.swift
//  Distaff
//
//  Created by netset on 11/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation

struct SizeModel : Decodable {
    var id : Int?
    var size : String?
    let status : Bool?
    var isSelected:Bool? = false
    
    enum CodingKeys: String, CodingKey {
           case id, size,status
       }
    
    
}

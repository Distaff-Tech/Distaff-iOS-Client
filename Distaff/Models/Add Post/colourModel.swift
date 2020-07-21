//
//  file.swift
//  Distaff
//
//  Created by netset on 13/02/20.
//  Copyright © 2020 netset. All rights reserved.
//


import Foundation
import UIKit

struct ColourModel : Decodable {
    var id : Int?
    var colour : String?
    var colour_code : String?
    let status : Bool?
    var isSelected:Bool? = false
    
    enum CodingKeys: String, CodingKey {
           case id, colour,status,colour_code
       }
    
}

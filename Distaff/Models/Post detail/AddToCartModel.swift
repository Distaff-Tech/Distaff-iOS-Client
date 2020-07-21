//
//  AddToCartModel.swift
//  Distaff
//
//  Created by netset on 24/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit
struct AddToCartModel : Codable {
    let message : String?
    let cartCount : Int?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case cartCount = "cartCount"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        cartCount = try values.decodeIfPresent(Int.self, forKey: .cartCount)
    }
    
}

//
//  SignInModel.swift
//  Distaff
//
//  Created by netset on 03/02/20.
//  Copyright © 2020 netset. All rights reserved.
//


import UIKit
import Foundation

struct SignUpModel : Codable {
    let message : String?
    let token : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case token = "token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
    
}



//
//  PostImagesModel.swift
//  Distaff
//
//  Created by netset on 06/03/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit


struct PostImagesModel : Codable {
    var post:Int?
    var post_image:String?
    
    enum CodingKeys: String, CodingKey {
        
        case post = "post"
        case post_image = "post_image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        post = try values.decodeIfPresent(Int.self, forKey: .post)
        post_image = try values.decodeIfPresent(String.self, forKey: .post_image)
    }
    
}


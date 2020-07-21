//
//  File.swift
//  Distaff
//
//  Created by Aman on 17/04/20.
//  Copyright © 2020 netset. All rights reserved.
//


import Foundation
struct ShapeColor : Codable {
    let id : Int?
    let colour : String?
    var isSelected:Bool? = false

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case colour = "colour"

    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        colour = try values.decodeIfPresent(String.self, forKey: .colour)
        
    }

}

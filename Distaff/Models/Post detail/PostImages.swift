//
//  PostImages.swift
//  Distaff
//
//  Created by netset on 24/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
struct PostImages : Codable {
    let id : Int?
    let post_images : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case post_images = "post_images"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        post_images = try values.decodeIfPresent(String.self, forKey: .post_images)
    }

}

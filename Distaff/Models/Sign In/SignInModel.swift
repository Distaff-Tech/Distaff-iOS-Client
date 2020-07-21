//
//  File.swift
//  Distaff
//
//  Created by netset on 04/02/20.
//  Copyright © 2020 netset. All rights reserved.
//


import Foundation
struct SignInModel : Codable {
    let message : String?
    let response : Response?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case response = "response"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        response = try values.decodeIfPresent(Response.self, forKey: .response)
    }

}

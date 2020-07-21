/* 
 Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
struct List : Codable {
    let id : Int?
    let post : Int?
    let user : Int?
    let order : Int?
    var order_status : Int?
    let size : Int?
    let post_images : Int?
    let created_time : String?
    let post_description : String?
    let price : String?
    let fullname : String?
    let post_image : String?
    let colour : Int?
    let colour_name : String?
    let size_name : String?
    let post_by:String?
    let serviceCharge:Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case post = "post"
        case user = "user"
        case order = "order"
        case order_status = "order_status"
        case size = "size"
        case post_images = "post_images"
        case created_time = "created_time"
        case post_description = "post_description"
        case price = "price"
        case fullname = "fullname"
        case post_image = "post_image"
        case colour = "colour"
        case colour_name = "colour_name"
        case size_name = "size_name"
        case post_by = "post_by"
        case serviceCharge = "serviceCharge"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        post = try values.decodeIfPresent(Int.self, forKey: .post)
        user = try values.decodeIfPresent(Int.self, forKey: .user)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        order_status = try values.decodeIfPresent(Int.self, forKey: .order_status)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        post_images = try values.decodeIfPresent(Int.self, forKey: .post_images)
        created_time = try values.decodeIfPresent(String.self, forKey: .created_time)
        post_description = try values.decodeIfPresent(String.self, forKey: .post_description)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        fullname = try values.decodeIfPresent(String.self, forKey: .fullname)
        post_image = try values.decodeIfPresent(String.self, forKey: .post_image)
        colour = try values.decodeIfPresent(Int.self, forKey: .colour)
        colour_name = try values.decodeIfPresent(String.self, forKey: .colour_name)
        size_name = try values.decodeIfPresent(String.self, forKey: .size_name)
        post_by = try values.decodeIfPresent(String.self, forKey: .post_by)
        serviceCharge = try values.decodeIfPresent(Double.self, forKey: .serviceCharge)
        
    }
    
}

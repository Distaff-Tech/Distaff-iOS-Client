/* 
 Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
struct PostData : Codable {
    let cartCount:Int?
    let id : Int?
    let price : String?
    let post_description : String?
    let user : Int?
    let total_likes : Int?
    let total_comments : Int?
    let post_status : Int?
    let created_time : String?
    let fullname : String?
    let image : String?
    let address : String?
    let post_like : Bool?
    let post_fav : Bool?
    let post_image : [PostImages]?
    let post_image_colour : [Post_image_colour]?
    let size : [Size]?
    let fabric : [Fabric]?
    
    enum CodingKeys: String, CodingKey {
        
        case cartCount = "cartCount"
        case id = "id"
        case price = "price"
        case post_description = "post_description"
        case user = "user"
        case total_likes = "total_likes"
        case total_comments = "total_comments"
        case post_status = "post_status"
        case created_time = "created_time"
        case fullname = "fullname"
        case image = "image"
        case address = "address"
        case post_like = "post_like"
        case post_fav = "post_fav"
        case post_image = "post_image"
        case post_image_colour = "post_image_colour"
        case size = "size"
        case fabric = "fabric"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cartCount = try values.decodeIfPresent(Int.self, forKey: .cartCount)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        post_description = try values.decodeIfPresent(String.self, forKey: .post_description)
        user = try values.decodeIfPresent(Int.self, forKey: .user)
        total_likes = try values.decodeIfPresent(Int.self, forKey: .total_likes)
        total_comments = try values.decodeIfPresent(Int.self, forKey: .total_comments)
        post_status = try values.decodeIfPresent(Int.self, forKey: .post_status)
        created_time = try values.decodeIfPresent(String.self, forKey: .created_time)
        fullname = try values.decodeIfPresent(String.self, forKey: .fullname)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        post_like = try values.decodeIfPresent(Bool.self, forKey: .post_like)
        post_fav = try values.decodeIfPresent(Bool.self, forKey: .post_fav)
        post_image = try values.decodeIfPresent([PostImages].self, forKey: .post_image)
        post_image_colour = try values.decodeIfPresent([Post_image_colour].self, forKey: .post_image_colour)
        size = try values.decodeIfPresent([Size].self, forKey: .size)
        fabric = try values.decodeIfPresent([Fabric].self, forKey: .fabric)
    }
    
}

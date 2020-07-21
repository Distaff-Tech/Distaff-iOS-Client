/* 
 Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
struct ShoppingBagData : Codable {
    let id : Int?
    let post : Int?
    let post_images : Int?
    let size : Int?
    let user : Int?
    let created_time : String?
    let post_image : String?
    let colour_name : String?
    let post_description : String?
    let price : String?
    let design_by : String?
    let size_name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case post = "post"
        case post_images = "post_images"
        case size = "size"
        case user = "user"
        case created_time = "created_time"
        case post_image = "post_image"
        case colour_name = "colour_name"
        case post_description = "post_description"
        case price = "price"
        case design_by = "design_by"
        case size_name = "size_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        post = try values.decodeIfPresent(Int.self, forKey: .post)
        post_images = try values.decodeIfPresent(Int.self, forKey: .post_images)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        user = try values.decodeIfPresent(Int.self, forKey: .user)
        created_time = try values.decodeIfPresent(String.self, forKey: .created_time)
        post_image = try values.decodeIfPresent(String.self, forKey: .post_image)
        colour_name = try values.decodeIfPresent(String.self, forKey: .colour_name)
        post_description = try values.decodeIfPresent(String.self, forKey: .post_description)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        design_by = try values.decodeIfPresent(String.self, forKey: .design_by)
        size_name = try values.decodeIfPresent(String.self, forKey: .size_name)
    }
    
}

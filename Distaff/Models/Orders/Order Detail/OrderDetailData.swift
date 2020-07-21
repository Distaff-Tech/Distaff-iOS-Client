/* 
 Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
struct OrderDetailData : Codable {
    let id : Int?
    let post : Int?
    let user : Int?
    let order : Int?
    var order_status : Int?
    let size : Int?
    let post_images : String?
    let created_time : String?
    let seller_status : String?
    let buyer_status : String?
    let size_name : String?
    let colour_name : String?
    let colour : Int?
    let post_description : String?
    let price : String?
    let order_by : String?
    let design_by : String?
    let address : [AddressOrderBy]?
    let order_by_image : String?
    let design_by_image : String?
    let design_by_address : String?
    let date : String?
    let serviceCharge:Double?
    let message_id : Int?
    
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case post = "post"
        case user = "user"
        case order = "order"
        case order_status = "order_status"
        case size = "size"
        case post_images = "post_images"
        case created_time = "created_time"
        case seller_status = "seller_status"
        case buyer_status = "buyer_status"
        case size_name = "size_name"
        case colour_name = "colour_name"
        case colour = "colour"
        case post_description = "post_description"
        case price = "price"
        case order_by = "order_by"
        case design_by = "design_by"
        case address = "order_by_address"
        case design_by_image = "design_by_image"
        case order_by_image = "order_by_image"
        case design_by_address = "design_by_address"
        case message_id = "message_id"
        case date = "date"
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
        post_images = try values.decodeIfPresent(String.self, forKey: .post_images)
        created_time = try values.decodeIfPresent(String.self, forKey: .created_time)
        seller_status = try values.decodeIfPresent(String.self, forKey: .seller_status)
        buyer_status = try values.decodeIfPresent(String.self, forKey: .buyer_status)
        size_name = try values.decodeIfPresent(String.self, forKey: .size_name)
        colour_name = try values.decodeIfPresent(String.self, forKey: .colour_name)
        colour = try values.decodeIfPresent(Int.self, forKey: .colour)
        post_description = try values.decodeIfPresent(String.self, forKey: .post_description)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        order_by = try values.decodeIfPresent(String.self, forKey: .order_by)
        design_by = try values.decodeIfPresent(String.self, forKey: .design_by)
        address = try values.decodeIfPresent([AddressOrderBy].self, forKey: .address)
        design_by_image = try values.decodeIfPresent(String.self, forKey: .design_by_image)
        order_by_image = try values.decodeIfPresent(String.self, forKey: .order_by_image)
        design_by_address = try values.decodeIfPresent(String.self, forKey: .design_by_address)
        message_id = try values.decodeIfPresent(Int.self, forKey: .message_id)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        serviceCharge = try values.decodeIfPresent(Double.self, forKey: .serviceCharge)
    }
    
}

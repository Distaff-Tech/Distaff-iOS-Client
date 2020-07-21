/* 
 Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
struct NotificationData : Codable {
    let id : String?
    let sender : Int?
    let receiver : Int?
    let notification_time : String?
    let message : String?
    let is_read : Bool?
    let tag : String?
    let table_id : String?
    let title : String?
    let sender_image : String?
    let receiver_image : String?
    var follow_status : Bool?
    let sender_name : String?
    let order_id : Int?
    let post_image : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sender = "sender"
        case receiver = "receiver"
        case notification_time = "notification_time"
        case message = "message"
        case is_read = "is_read"
        case tag = "tag"
        case table_id = "table_id"
        case title = "title"
        case sender_image = "sender_image"
        case receiver_image = "receiver_image"
        case follow_status = "follow_status"
        case sender_name = "sender_name"
        case post_image = "post_image"
        case order_id = "order_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        sender = try values.decodeIfPresent(Int.self, forKey: .sender)
        receiver = try values.decodeIfPresent(Int.self, forKey: .receiver)
        notification_time = try values.decodeIfPresent(String.self, forKey: .notification_time)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        is_read = try values.decodeIfPresent(Bool.self, forKey: .is_read)
        tag = try values.decodeIfPresent(String.self, forKey: .tag)
        table_id = try values.decodeIfPresent(String.self, forKey: .table_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        sender_image = try values.decodeIfPresent(String.self, forKey: .sender_image)
        receiver_image = try values.decodeIfPresent(String.self, forKey: .receiver_image)
        follow_status = try values.decodeIfPresent(Bool.self, forKey: .follow_status)
        sender_name = try values.decodeIfPresent(String.self, forKey: .sender_name)
        post_image = try values.decodeIfPresent(String.self, forKey: .post_image)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
    }
    
}

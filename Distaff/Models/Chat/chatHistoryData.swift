/* 
 Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
struct chatHistoryData : Codable {
    let id : Int?
    let message : String?
    let is_read : Int?
    let sender_status : Int?
    let receiver_status : Int?
    let created_time : String?
    let receiver_id : Int?
    let sender_id : Int?
    
    let sender_name : String?
    let receiver_name : String?
    let receiver_image : String?
    let sender_image : String?
    let is_sent_by_me : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case message = "message"
        case is_read = "is_read"
        case sender_status = "sender_status"
        case receiver_status = "receiver_status"
        case created_time = "created_time"
        case receiver_id = "receiver_id"
        case sender_id = "sender_id"
        case sender_name = "sender_name"
        case receiver_name = "receiver_name"
        case receiver_image = "receiver_image"
        case sender_image = "sender_image"
        case is_sent_by_me = "is_sent_by_me"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        is_read = try values.decodeIfPresent(Int.self, forKey: .is_read)
        sender_status = try values.decodeIfPresent(Int.self, forKey: .sender_status)
        receiver_status = try values.decodeIfPresent(Int.self, forKey: .receiver_status)
        created_time = try values.decodeIfPresent(String.self, forKey: .created_time)
        receiver_id = try values.decodeIfPresent(Int.self, forKey: .receiver_id)
        sender_id = try values.decodeIfPresent(Int.self, forKey: .sender_id)
        sender_name = try values.decodeIfPresent(String.self, forKey: .sender_name)
        receiver_name = try values.decodeIfPresent(String.self, forKey: .receiver_name)
        receiver_image = try values.decodeIfPresent(String.self, forKey: .receiver_image)
        sender_image = try values.decodeIfPresent(String.self, forKey: .sender_image)
        is_sent_by_me = try values.decodeIfPresent(Bool.self, forKey: .is_sent_by_me)
        
    }
    
}

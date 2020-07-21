/*
 Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
struct Response : Codable {
    let id : Int?
    let token : String?
    let email : String?
    var phone : String?
    var fullname : String?
    var address : String?
    var date_of_birth : String?
    var gender : String?
    var about_me : String?
    var user_name : String?
    var deviceId : String?
    var deviceType : String?
    var is_profile_created : Bool?
    var image:String?
    var notificationStatus:Int?
    var login_type:String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case token = "token"
        case email = "email"
        case phone = "phone"
        case fullname = "fullname"
        case address = "address"
        case date_of_birth = "date_of_birth"
        case gender = "gender"
        case about_me = "about_me"
        case user_name = "user_name"
        case deviceId = "deviceId"
        case deviceType = "deviceType"
        case is_profile_created = "is_profile_created"
        case image = "image"
        case notificationStatus = "notificationStatus"
        case login_type = "login_type"
        
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        fullname = try values.decodeIfPresent(String.self, forKey: .fullname)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        about_me = try values.decodeIfPresent(String.self, forKey: .about_me)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        deviceType = try values.decodeIfPresent(String.self, forKey: .deviceType)
        is_profile_created = try values.decodeIfPresent(Bool.self, forKey: .is_profile_created)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        notificationStatus = try values.decodeIfPresent(Int.self, forKey: .notificationStatus)
        login_type = try values.decodeIfPresent(String.self, forKey: .login_type)
        
    }
    
}


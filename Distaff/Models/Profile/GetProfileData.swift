/* 
 Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
struct GetProfileData : Codable {
    let id : Int?
    let email : String?
    let social_id : String?
    let login_type : String?
    let cartNo : Int?
    let address : String?
    let fullname : String?
    let gender : String?
    let about_me : String?
    let stripe_id : String?
    let date_of_birth : String?
    let onoffnotification : Int?
    let post_count : Int?
    let total_follower : Int?
    let total_following : Int?
    let created_time : String?
    let image : String?
    let phone : String?
    let adminCardId : String?
    let role : Int?
    let user_name:String?
    let post_images : [PostImagesModel]?
    let follow_status : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case email = "email"
        case social_id = "social_id"
        case login_type = "login_type"
        case cartNo = "cartNo"
        case address = "address"
        case fullname = "fullname"
        case gender = "gender"
        case about_me = "about_me"
        case stripe_id = "stripe_id"
        case date_of_birth = "date_of_birth"
        case onoffnotification = "onoffnotification"
        case post_count = "post_count"
        case total_follower = "total_follower"
        case total_following = "total_following"
        case created_time = "created_time"
        case image = "image"
        case phone = "phone"
        case adminCardId = "adminCardId"
        case role = "role"
        case post_images = "post_images"
        case follow_status = "follow_status"
        case user_name = "user_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        social_id = try values.decodeIfPresent(String.self, forKey: .social_id)
        login_type = try values.decodeIfPresent(String.self, forKey: .login_type)
        cartNo = try values.decodeIfPresent(Int.self, forKey: .cartNo)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        fullname = try values.decodeIfPresent(String.self, forKey: .fullname)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        about_me = try values.decodeIfPresent(String.self, forKey: .about_me)
        stripe_id = try values.decodeIfPresent(String.self, forKey: .stripe_id)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        onoffnotification = try values.decodeIfPresent(Int.self, forKey: .onoffnotification)
        post_count = try values.decodeIfPresent(Int.self, forKey: .post_count)
        total_follower = try values.decodeIfPresent(Int.self, forKey: .total_follower)
        total_following = try values.decodeIfPresent(Int.self, forKey: .total_following)
        created_time = try values.decodeIfPresent(String.self, forKey: .created_time)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        adminCardId = try values.decodeIfPresent(String.self, forKey: .adminCardId)
        role = try values.decodeIfPresent(Int.self, forKey: .role)
        post_images = try values.decodeIfPresent([PostImagesModel].self, forKey: .post_images)
        follow_status = try values.decodeIfPresent(Bool.self, forKey: .follow_status)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
    }
    
}



/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct FollowData : Codable {
	let id : Int?
	let follow_to : Int?
	let follow_by : Int?
	let created_time : String?
	let fullname : String?
	let image : String?
	let user_name : String?
    var follow_status:Bool?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case follow_to = "follow_to"
		case follow_by = "follow_by"
		case created_time = "created_time"
		case fullname = "fullname"
		case image = "image"
		case user_name = "user_name"
        case follow_status = "follow_status"
        
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		follow_to = try values.decodeIfPresent(Int.self, forKey: .follow_to)
		follow_by = try values.decodeIfPresent(Int.self, forKey: .follow_by)
		created_time = try values.decodeIfPresent(String.self, forKey: .created_time)
		fullname = try values.decodeIfPresent(String.self, forKey: .fullname)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        follow_status = try values.decodeIfPresent(Bool.self, forKey: .follow_status)
	}

}

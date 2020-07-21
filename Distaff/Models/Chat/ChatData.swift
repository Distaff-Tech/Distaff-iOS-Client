/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ChatData : Codable {
	let id : Int?
	let sender : Int?
	let receiver : Int?
	let message : String?
	let is_read : Bool?
	let sender_status : Bool?
	let receiver_status : Bool?
	let created_time : String?
	let image : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case sender = "sender"
		case receiver = "receiver"
		case message = "message"
		case is_read = "is_read"
		case sender_status = "sender_status"
		case receiver_status = "receiver_status"
		case created_time = "created_time"
		case image = "image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		sender = try values.decodeIfPresent(Int.self, forKey: .sender)
		receiver = try values.decodeIfPresent(Int.self, forKey: .receiver)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		is_read = try values.decodeIfPresent(Bool.self, forKey: .is_read)
		sender_status = try values.decodeIfPresent(Bool.self, forKey: .sender_status)
		receiver_status = try values.decodeIfPresent(Bool.self, forKey: .receiver_status)
		created_time = try values.decodeIfPresent(String.self, forKey: .created_time)
		image = try values.decodeIfPresent(String.self, forKey: .image)
	}

}

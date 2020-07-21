/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Bank_detail : Codable {
	let id : Int?
	let account_name : String?
	let type : String?
	let routing_number : String?
	let acc_number : String?
	let user : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case account_name = "Account_name"
		case type = "Type"
		case routing_number = "routing_number"
		case acc_number = "acc_number"
		case user = "user"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		account_name = try values.decodeIfPresent(String.self, forKey: .account_name)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		routing_number = try values.decodeIfPresent(String.self, forKey: .routing_number)
		acc_number = try values.decodeIfPresent(String.self, forKey: .acc_number)
		user = try values.decodeIfPresent(Int.self, forKey: .user)
	}

}
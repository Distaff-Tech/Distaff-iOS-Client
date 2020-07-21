/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct AddressData : Codable {
	let id : Int?
	let user : Int?
	let first_name : String?
	let last_name : String?
	let phone : String?
	let address : String?
	let city : String?
	let postal_code : String?
	let created_time : String?
	var default_address : Bool?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case user = "user"
		case first_name = "first_name"
		case last_name = "last_name"
		case phone = "phone"
		case address = "address"
		case city = "city"
		case postal_code = "postal_code"
		case created_time = "created_time"
		case default_address = "default_address"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		user = try values.decodeIfPresent(Int.self, forKey: .user)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		postal_code = try values.decodeIfPresent(String.self, forKey: .postal_code)
		created_time = try values.decodeIfPresent(String.self, forKey: .created_time)
		default_address = try values.decodeIfPresent(Bool.self, forKey: .default_address)
    }

}

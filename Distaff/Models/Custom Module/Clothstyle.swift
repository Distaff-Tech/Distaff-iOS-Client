/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Clothstyle : Codable {
	let id : Int?
	let style_name : String?
	let price : Double?
	let status : Bool?
	var clothStyle_Colour : [ClothStyle_Colour]?
	var clothStyle_pattern : [ClothStyle_pattern]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case style_name = "style_name"
		case price = "price"
		case status = "status"
		case clothStyle_Colour = "clothStyle_Colour"
		case clothStyle_pattern = "clothStyle_pattern"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		style_name = try values.decodeIfPresent(String.self, forKey: .style_name)
		price = try values.decodeIfPresent(Double.self, forKey: .price)
		status = try values.decodeIfPresent(Bool.self, forKey: .status)
		clothStyle_Colour = try values.decodeIfPresent([ClothStyle_Colour].self, forKey: .clothStyle_Colour)
		clothStyle_pattern = try values.decodeIfPresent([ClothStyle_pattern].self, forKey: .clothStyle_pattern)
	}

}

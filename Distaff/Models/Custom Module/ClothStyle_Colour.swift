/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ClothStyle_Colour : Codable {
	let id : Int?
	let colour : String?
	let colour_code : String?
	let status : Bool?
	let image : String?
	let cloth_style : Int?
    var isSelected:Bool? = false
	let clothStyle_colour_pattern : [ClothStyle_colour_pattern]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case colour = "colour"
		case colour_code = "colour_code"
		case status = "status"
		case image = "image"
		case cloth_style = "cloth_style"
		case clothStyle_colour_pattern = "clothStyle_colour_pattern"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		colour = try values.decodeIfPresent(String.self, forKey: .colour)
		colour_code = try values.decodeIfPresent(String.self, forKey: .colour_code)
		status = try values.decodeIfPresent(Bool.self, forKey: .status)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		cloth_style = try values.decodeIfPresent(Int.self, forKey: .cloth_style)
		clothStyle_colour_pattern = try values.decodeIfPresent([ClothStyle_colour_pattern].self, forKey: .clothStyle_colour_pattern)
	}

}

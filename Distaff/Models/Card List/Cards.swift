/* 
 Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
struct Cards : Codable {
    let address_city : String?
    let address_country : String?
    let address_line1 : String?
    let address_line1_check : String?
    let address_line2 : String?
    let address_state : String?
    let address_zip : String?
    let address_zip_check : String?
    let brand : String?
    let country : String?
    let customer : String?
    let cvc_check : String?
    let dynamic_last4 : String?
    let exp_month : Int?
    let exp_year : Int?
    let fingerprint : String?
    let funding : String?
    let id : String?
    let last4 : String?
    let card_image:String?
    
    let name : String?
    let object : String?
    let tokenization_method : String?
    
    enum CodingKeys: String, CodingKey {
        
        case address_city = "address_city"
        case address_country = "address_country"
        case address_line1 = "address_line1"
        case address_line1_check = "address_line1_check"
        case address_line2 = "address_line2"
        case address_state = "address_state"
        case address_zip = "address_zip"
        case address_zip_check = "address_zip_check"
        case brand = "brand"
        case country = "country"
        case customer = "customer"
        case cvc_check = "cvc_check"
        case dynamic_last4 = "dynamic_last4"
        case exp_month = "exp_month"
        case exp_year = "exp_year"
        case fingerprint = "fingerprint"
        case funding = "funding"
        case id = "id"
        case last4 = "last4"
        case name = "name"
        case object = "object"
        case tokenization_method = "tokenization_method"
        case card_image = "card_image"
        
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address_city = try values.decodeIfPresent(String.self, forKey: .address_city)
        address_country = try values.decodeIfPresent(String.self, forKey: .address_country)
        address_line1 = try values.decodeIfPresent(String.self, forKey: .address_line1)
        address_line1_check = try values.decodeIfPresent(String.self, forKey: .address_line1_check)
        address_line2 = try values.decodeIfPresent(String.self, forKey: .address_line2)
        address_state = try values.decodeIfPresent(String.self, forKey: .address_state)
        address_zip = try values.decodeIfPresent(String.self, forKey: .address_zip)
        address_zip_check = try values.decodeIfPresent(String.self, forKey: .address_zip_check)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        customer = try values.decodeIfPresent(String.self, forKey: .customer)
        cvc_check = try values.decodeIfPresent(String.self, forKey: .cvc_check)
        dynamic_last4 = try values.decodeIfPresent(String.self, forKey: .dynamic_last4)
        exp_month = try values.decodeIfPresent(Int.self, forKey: .exp_month)
        exp_year = try values.decodeIfPresent(Int.self, forKey: .exp_year)
        fingerprint = try values.decodeIfPresent(String.self, forKey: .fingerprint)
        funding = try values.decodeIfPresent(String.self, forKey: .funding)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        last4 = try values.decodeIfPresent(String.self, forKey: .last4)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        object = try values.decodeIfPresent(String.self, forKey: .object)
        tokenization_method = try values.decodeIfPresent(String.self, forKey: .tokenization_method)
         card_image = try values.decodeIfPresent(String.self, forKey: .card_image)
    }
}



import Foundation

enum Sign_Up {
    static let email = "email"
    static let phone = "phone"
    static let password = "password"
    static let deviceId = "deviceId"
    static let deviceType = "deviceType"
}
enum Sign_In {
    static let email = "email"
    static let password = "password"
    static let deviceId = "deviceId"
    static let deviceType = "deviceType"
}
enum Forgot_Password {
    static let email = "email"
}

enum Resend_OTP {
    static let emailAddress = "emailAddress"
}

enum Resset_Passcode {
    static let emailAddress = "emailAddress"
    static let otp = "otp"
    static let newPasscode = "newPasscode"
}

enum Create_Profile {
    static let address = "address"
    static let aboutMe = "about_me"
    static let gender = "gender"
    static let dob = "date_of_birth"
    static let fullName = "fullname"
    static let email = "email"
    static let userName = "user_name"
    static let data = "data"
    static var image = "image"
    static var is_from_edit = "is_from_edit"
}


enum Add_Post {
    static let price = "price"
    static let postDescription = "post_description"
    static let fabric = "fabric"
    static let size = "size"
    static let post_images = "post_images"
    static let data = "data"
    static let colour = "colour"
    
}






enum Add_Card {
    static let cardNumber = "cardNumber"
    static let expMonth = "expMonth"
    static let expYear = "expYear"
    static let cvc = "cvc"
    static let name = "name"
}


enum Contact_Us {
    static let fullname = "fullname"
    static let email = "email"
    static let subject = "subject"
    static let message = "message"
    
}

enum Change_Password {
    static let currentPassword = "currentPassword"
    static let newPassword = "newPassword"
}

enum Social_SignIN {
    static let social_id = "social_id"
    static let email = "email"
    static let deviceId = "deviceId"
    static let deviceType = "deviceType"
    static let login_type = "login_type"
}


enum like_UnlikePost {
    static let post_id = "post_id"
    static let like_status = "like_status"
}

enum fav_UnfavouritePost {
    static let post_id = "post_id"
    static let fav_status = "fav_status"
}

enum reportPost {
    static let post_id = "post_id"
    static let reason = "reason"
}
enum Post_Comment {
    static let post_id = "post_id"
    static let comment = "comment"
    
}

enum Delete_Comment {
    static let comment = "comment"
    
}

enum Delete_Card {
    static let card_id = "card_id"
    
}


enum Add_Cart {
    static let post_id = "post_id"
    static let image_id = "image_id"
    static let size_id = "size_id"
}


enum Notification_Toggle {
    static let notificationStatus = "notificationStatus"
}

enum Get_message {
    static let id = "id"
}


enum Send_message {
    static let message = "message"
    static let receiver_id = "receiver_id"
}

enum Delete_ChatHistory {
    static let receiver_id = "receiver_id"
    static let page_num = "page_num"
}
enum Delete_Cart {
    static let cart_id = "cart_id"
}

enum Delete_Order {
    static let order_id = "order_id"
}


enum Add_Address {
    static let first_name = "first_name"
    static let last_name = "last_name"
    static let phone = "phone"
    static let city = "city"
    static let postal_code = "postal_code"
    static let address = "address"
    
    
}

enum Delete_Address {
    static let address = "address"
}

enum Make_Payment {
    static let card = "card"
    static let amt = "amt"
    static let address_id = "address_id"
}

enum Search_Users {
    static let searchText = "searchText"
}


enum Follow_UnFollow {
    static let follow_to = "follow_to"
    static let follow_status = "follow_status"
}

enum Follow_FollowingList {
    static let user_id = "user_id"
}

enum My_Requests {
    static let timeZone = "timeZone"
}


enum Accept_DeclineOrder {
    static let order_id = "order_id"
     static let order_status = "order_status"
}


enum Order_Detail {
    static let order_id = "order_id"
}

enum Cancel_Order {
    static let order_id = "order_id"
     static let order_status = "order_status"
}

enum Update_Token {
     static let deviceId = "deviceId"
}

enum Add_Bank {
     static let accountHolderName = "account_holder_name"
     static let accountType = "account_holder_type"
     static let routingNumber = "routing_number"
     static let accountNumber = "account_number"
}


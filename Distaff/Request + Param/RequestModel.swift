

import Foundation
import UIKit

enum SignIN {
    struct Request {
        var email: String?
        var password: String?
    }
}

enum SignUP {
    struct Request {
        var email: String?
        var phoneNumber: String?
        var password: String?
        var confirmPassword: String?
    }
}

enum CreatePasscode {
    struct Request {
        var enterPasscode: String?
        var reEnterPasscode: String? = nil
        var emailAddress:String? = nil
        var otp: String? = nil
    }
}

enum VerifyOTP {
    struct Request {
        var otpCode: String?
    }
}

enum ForgotPassword {
    struct Request {
        var email: String?
    }
}

enum ResendOTP {
    struct Request {
        var email: String?
    }
}


enum MakePayment {
    struct Request {
        var amount:Double?
        var cardId:String?
        var addressId:Int?
    }
}




enum CreateProfile {
    struct Request {
        var userName:String? = nil
        var fullName:String? = nil
        var completeAddress:String? = nil
        var profilePicture:UIImage? = nil
        var gender:String? = nil
        var DateOfBirth:String? = nil
        var about:String? = nil
        var isFirstPage:Bool? = nil
        var isFromEditProfile:Int? = nil
        
    }
}

enum AddCard {
    struct Request {
        var cardNumber:String?
        var name:String?
        var expiryDate:String?
        var cvv:String?
        
    }
}

enum ChangePassword {
    struct Request {
        var currentPassword:String?
        var newPassword:String?
        var confirmPassword:String?
    }
}

enum HelpAndSupport {
    struct Request {
        var name:String?
        var email:String?
        var subject:String?
        var message:String?
    }
}

enum Comment {
    struct Request {
        var comment: String?
        var postId:Int?
    }
}


enum Message {
    struct Request {
        var message: String?
        var receiver_id:Int?
    }
}


enum DeleteComment {
    struct Request {
        var comment: Int?
        
    }
}



enum AddNewAddress {
    struct Request {
        var firstName:String?
        var lastName:String?
        var mobileNumber:String?
        var address:String?
        var city:String?
        var postalCode:String?
        
    }
}


enum AddPost {
    struct Request {
        var price:String?
        var description:String?
        var clothMaterial:[String]?
        var sizesAvailable :[String]?
        var postImage:UIImage?
        
    }
}

enum AddToCart {
    struct Request {
        var postId: Int?
        var imageId: Int?
        var sizeId: Int?
    }
}

enum OrderDetail {
    struct Request {
        var order_id: Int?
    }
}

enum CancelOrder {
    struct Request {
        var order_id: Int?
        var orderStatus: Int?
    }
}

enum DeleteChat {
    struct Request {
        var receiverId: Int?
        var currentPage: Int?
    }
}


enum AddBank {
    struct Request {
        var acoountHolderName:String?
        var accountHolderType:String?
        var routingNumber:String?
        var bankAccountNumber:String?
    }
}

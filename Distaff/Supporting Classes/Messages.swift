


import Foundation
class Messages: NSObject {
    
    struct Validation {
        // Sign In
        static let enterEmail = "Email address field can't be empty"
        static let enterCorrectEmail = "Please enter valid email"
        
        //Sign UP
        static let enterPassword = "Password field can't be empty"
        static let enterPhone = "Phone number field can't be empty"
        static let enterConfirmPassword = "Confirm password field can't be empty"
        static let passwordDoesNotMatch = "Password does not match"
        static let enterValidPassword = "Password must be be of miminum 8 characters."
        
        //Create Profile
        static let enterUserName = "User Name field can't be empty"
        static let enterFullName = "Full Name field can't be empty"
        static let enterCompleteAddress  = "Address field can't be empty"
        static let enterDOB = "Please select date of birth"
        static let enterAboutMe = "Description field can't be empty"
        static let chooseProfilePic = "Please choose profile pic"
        
        // set payment
        static let enterCardNumber      = "Card Number field can't be empty"
        static let enterCardName      = "Name Of Card field can't be empty"
        static let enterExpiryDate      = "Please select expiry date"
        static let enterCvvNumber       = "Cvv field can't be empty"
        static let enterValidCardNumber       = "Please enter valid card number"
        static let enterValidCvv       = "Please enter valid cvv"
        
        
        // change Password
        static let enterCurrentPassword     = "Current password field can't be empty"
        static let enterNewPassword     = "New password field can't be empty"
        static let oldPasswordDoesNotMatch = "New password and Confirm password does not match"
        
        
        // feedback and Support
        static let enterName = "Name field can't be empty"
        static let enterSubject = "Subject field can't be empty"
        static let enterMessage = "Message field can't be empty"
        
        // Comments
        static let enterComment = "Comment field can't be empty"
        
        // add Address
        static let enterFirstName = "First Name field can't be empty"
        static let enterLastName = "Last Name field can't be empty"
        static let enterMobile = "Mobile number field can't be empty"
        static let enterAddress = "Address field can't be empty"
        static let enterCity = "City field can't be empty"
        static let enterPostalCode = "Postal Code field can't be empty"
        static let enterValidMobile = "Please enter valid mobile number"
        
        
        // Add Post
        static let enterPrice = "Price field can't be empty"
        static let entervalidPrice = "Please enter valid price"
        static let chooseClothMaterial = "Please choose cloth material"
        static let chooseClothSizes = "Please choose available sizes"
        static let chooseColorScheme = "Please choose color scheme"
        static let uploadMaximumImage = "You can upload maximum of 5 images"
        
        // Custom Design
        static let chooseProduct = "Please choose product first"
        static let chooseShape = "Please select shape first"
        static let chooseShapeColor = "Please select shape color first"
        static let chooseFabric = "Please select fabric first"
        static let chooseFabricColor = "Please select fabric color first"
        static let chooseSew = "Please select Sew first"
        static let waitForImage = "Please wait while product is loading."
        
        //Add bank
        static let enterActHolderName = "Account holder name field can't be empty"
        static let chooserActHolderType = "Please choose account type"
        static let enterRoutingNumber = "Routing number field can't be empty"
        static let enterActNumber = "Account number field can't be empty"
        
        
        
        
        
    }
    
    struct TextMessages {
        static let forgotPassword = "Enter your registered email address and we'll\nsend you an email to get back into your account."
        static let passwordResetEmail = "We have sent you an email to\nyour registered email address with\na link to reset your password."
        
        
        // Help and Support
        static let helpAndSupport = "Feel free to ask any query, we will respond\nas soon as possible."
        
        static let changePassword = "Please complete the following fields to\nchange your password."
        
        // Enter Cvv popup
        static let enterCvv = "Enter CVV number for yourcard\nending with (3123)"
        
        
    }
    
    
    
    struct NoDataMessage {
        // Post
        static let noPostFound = "Post list found empty"
        // Comment
        static let noCommentFound = "Comment list found empty"
        // Cart List
        static let noDataInCart = "You have no item in cart yet"
        static let cartListEmpty = "Cart List found empty"
        // Address List
        static let noAddressFound = "You haven't added any address yet."
        
        //Message & Chat
        static let noChatList = "Chat list found empty"
        static let noMessage = "No message found"
        
        // Search page
        static let noUserFound = "No user Found"
        
        // profile page
        static let noFollower = "No follower Yet"
        static let noFollowing = "No following Yet"
        static let noPost = "No posts Yet"
        
        // favourite page
        static let noFavouritePost = "Favourite list found Empty"
        
        // My orders
        static let noMyRequest = "My request list found Empty"
        static let noMyOrder = "My order list found Empty"
        
        // notification List
        static let noNotification = "No notification found"
        
        // card List
        static let noSavedCard = "NO SAVED CARDS"
        static let savedCard = " SAVED CARDS"
        
        // Add Post
        static let noClothMaterialList = "Cloth material list found empty"
        
    }
    
    struct CustomServerMessages {
        static let addPostSuccessfully = "Your post has been added successfully"
    }
    
    struct NetworkMessages {
        static let errrOccured = "Error has been occured.Please try again"
        static let noInternetConnection = "No Internet connection! Please check your Internet connectivity."
        static let seassionLogout  =  "It seems like you have Signed in from another device. Please sign in again"
    }
    
    struct DialogMessages {
        static let deleteCard = "Are you sure want to delete this card?"
        static let deleteAddress = "Are you sure want to delete this address?"
        static let deleteItem = "Are you sure want to delete this item?"
        static let deleteOrder = "Are you sure want to delete this order?.This action can't be undone"
        static let deleteEntireChat = "Are you sure want to delete entire chat with"
        static let deleteAllNotifications = "Are you sure want to delete all notifications?"
        
        // Add post
        static let cancelPosting = "Are you sure want to cancel this posting?"
        
        static let removePatterns = "This will remove the pattern, color and shapes used on image.Are you sure?"
        
    }
    
    struct LocalSuccessMessages {
        static let photoSavedSuccessfully  = "Photo Saved Successfully"
    }
    
    
}

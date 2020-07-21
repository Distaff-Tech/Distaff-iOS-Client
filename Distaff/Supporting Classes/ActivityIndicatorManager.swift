//
import Foundation
import NVActivityIndicatorView

class ActivityIndicatorManager {
    static let sharedInstance = ActivityIndicatorManager()
    
    func startAnimating() {
        let size = CGSize(width: 50, height: 50)
        let activityData = ActivityData(size: size, type: .ballRotateChase, color:UIColor.white)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func stopAnimating() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    
    
    
}

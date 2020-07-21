
import Foundation
import UIKit
import IQKeyboardManager
import SKPhotoBrowser
import AVFoundation
import MIBadgeButton_Swift
class BaseClass: UIViewController {
    
    var picker:UIImagePickerController?=UIImagePickerController()
    let datePicker = UIDatePicker()
    var expiryDatePicker = MonthYearPickerView()
    var refreshControl = UIRefreshControl()
    var searchBarController =  UISearchBar()
    var lastRotation : CGFloat = 0.0
    var previousScale : CGFloat = 1.0
    var beginX : CGFloat = 0.0
    var beginY : CGFloat = 0.0
    var recentShapeAdded: UIView?
    var objectToDelete:UIView?
    var addedShapesPriceArray = NSMutableArray()
       var pickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.navigationController?.interactivePopGestureRecognizer!.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        clearSDWebCache()
    }
    
    func addDatePickerInTextField(textField:UITextField) {
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(BaseClass.handleDatePickerSelection), for: UIControl.Event.valueChanged)
        datePicker.datePickerMode = .date
        let langStr = Locale.current.languageCode
        self.datePicker.locale = Locale(identifier:langStr!)
        self.datePicker.set18YearValidation()
    }
    
    
    func addPickerViewInTextField(textField:UITextField) {
        textField.inputView = pickerView
        pickerView.delegate = self
        pickerView.reloadAllComponents()
        
    }
    
    
    
    func addRefreshControlInTable(tableView:UITableView) {
        let attributes = [NSAttributedString.Key.foregroundColor: AppColors.appColorBlue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        refreshControl.attributedTitle = NSAttributedString(string: "", attributes: attributes)
        refreshControl.tintColor = AppColors.appColorBlue
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    
    func addRefreshControlInScrollView(scrollView:UIScrollView) {
        let attributes = [NSAttributedString.Key.foregroundColor: AppColors.appColorBlue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        refreshControl.attributedTitle = NSAttributedString(string: "", attributes: attributes)
        refreshControl.tintColor = AppColors.appColorBlue
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: UIControl.Event.valueChanged)
        scrollView.refreshControl = refreshControl
        scrollView.alwaysBounceVertical = true
        
    }
    
    func removeRefreshControl() {
        refreshControl.endRefreshing()
        refreshControl.isHidden = true
    }
    
    
    func handleUnreadNotificationUI(btn:MIBadgeButton) {
        btn.badgeString = Variables.shared.hasPendingNotifications ? "●" : ""
        
    }
    
    
    @objc func refreshData() {
        
    }
    
    func addExpiryDatePickerInTextField(textField:UITextField) {
        textField.inputView = expiryDatePicker
        expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
            textField.text = "\(String(format: "%02d", month))/\(String(year))"
        }
    }
    
    
    
    func displayZoomImages(imageArray:[SKPhotoProtocol],index:Int) {
        if InternetReachability.sharedInstance.isInternetAvailable() {
            let browser = SKPhotoBrowser(photos:imageArray)
            browser.initializePageIndex(index)
            browser.delegate = self
            present(browser, animated: true, completion: nil)
        }
    }
    
    
    func displayZoomSingleImages(url:String) {
        var images = [SKPhotoProtocol]()
        let photo = SKPhoto.photoWithImageURL("\(WebServicesApi.imageBaseUrl)\(url)")
        photo.shouldCachePhotoURLImage = true
        images.append(photo)
        let browser = SKPhotoBrowser(photos: images)
        browser.delegate = self
        present(browser, animated: true, completion: nil)
        
    }
    
    
    
    func addKeyBoardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseClass.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseClass.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    func removeAllObserversAdded() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //               bottomConstraints.constant = keyboardSize.height
            //               UIView.animate(withDuration: 1.0, animations: {
            //                   self.view.layoutIfNeeded()
            //                   //                self.scrollTableToLastIndex()
            //                   self.view.setNeedsLayout()
            //               })
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //               bottomConstraints.constant = 0
            //               UIView.animate(withDuration: 1.0, animations: {
            //                   self.view.layoutIfNeeded()
            //                   self.view.setNeedsLayout()
            //               })
        }
    }
    
    
    
    
    @objc func handleDatePickerSelection() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        _ = formatter.string(from: datePicker.date)
    }
    
    
    
    
    func handleNavigationBarTranparency(shouldTranparent:Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(shouldTranparent == true ? UIImage() : #imageLiteral(resourceName: "navigationImage") , for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = shouldTranparent
        self.navigationController?.view.backgroundColor = AppColors.appColorBlue
        
    }
    
    
    //MARK:- pop view contrller here
    func PopViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func popTwoViewControllers() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    
    func enableIQKeyboard() {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
    }
    
    func disableIQKeyboard() {
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
    }
    
    func handleTabbarVisibility(shouldHide:Bool) {
        self.tabBarController?.tabBar.isHidden = shouldHide ? true : false
    }
    
    
    
    //MARK:- push vc here
    func pushToViewController(VC:String) {
        let targetVc = self.storyboard?.instantiateViewController(withIdentifier:VC)
        self.navigationController?.pushViewController(targetVc!, animated: true)
    }
    
    
    func presentViewController(withIdentifer:String) {
        let targetVc = self.storyboard!.instantiateViewController(withIdentifier:withIdentifer)
        targetVc.modalPresentationStyle = .overCurrentContext
        present(targetVc, animated: true, completion: nil)
    }
    
    func presentViewControllerWithNavigation(withIdentifer:String) {
        DispatchQueue.main.async {
            let targetVc = self.storyboard!.instantiateViewController(withIdentifier:withIdentifer)
            let navigationController: UINavigationController = UINavigationController(rootViewController: targetVc)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    
    //    func handleNavigationBarLiftingWithScroll(shouldLift:Bool,scrollView:UIScrollView? = nil) {
    //        if let navigationController = self.navigationController as? ScrollingNavigationController {
    //            if shouldLift {
    //                navigationController.followScrollView(scrollView ?? UIScrollView(), delay: 10.0)
    //            }
    //            else {
    //                navigationController.stopFollowingScrollView()
    //            }
    //
    //        }
    //
    //
    //    }
    
    
    //MARK:- pop vc here
    func popToRootVc() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func dismissAndPopToRoot() {
        let presentingVC = self.presentingViewController
        let navigationController = presentingVC is UINavigationController ? presentingVC as? UINavigationController : presentingVC?.navigationController
        navigationController?.popToRootViewController(animated: false)
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismissPopToRootAndChangeTabbar() {
        let presentingVC = self.presentingViewController
        let navigationController = presentingVC is UINavigationController ? presentingVC as? UINavigationController : presentingVC?.navigationController
        navigationController?.popToRootViewController(animated: false)
        let newNav = navigationController?.tabBarController?.viewControllers?.last as? UINavigationController
        let myOrderPage = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.orderHistoryVC) as? OrderHistoryVC
        myOrderPage?.isFromShoppingFlow = true
        newNav?.pushViewController(myOrderPage ?? UIViewController(), animated: true)
        navigationController?.tabBarController?.selectedIndex = 4
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismissAndPushToViewController(identifer:String) {
        self.dismiss(animated: true, completion: nil)
        let presentingVC = self.presentingViewController!
        let navigationController = presentingVC is UINavigationController ? presentingVC as? UINavigationController : presentingVC.navigationController
        let targetVc = self.storyboard?.instantiateViewController(withIdentifier:identifer)
        navigationController?.pushViewController(targetVc!, animated: true)
    }
    
    func dismissAndPresentViewController(identifer:String) {
        self.dismiss(animated: true, completion: nil)
        let presentingVC = self.presentingViewController!
        let navigationController = presentingVC is UINavigationController ? presentingVC as? UINavigationController : presentingVC.navigationController
        let targetVc = self.storyboard?.instantiateViewController(withIdentifier:identifer)
        targetVc?.modalPresentationStyle = .overCurrentContext
        navigationController?.present(targetVc ?? UIViewController(), animated: true, completion: nil)
    }
    
    func addSerachBarInNavigation(placeholderText:String,backgroundColor:UIColor? = nil,textFont:UIFont? = nil) {
        searchBarController.sizeToFit()
        searchBarController.delegate = self
        searchBarController.placeholder = placeholderText
        searchBarController.backgroundImage = UIImage()
        if #available(iOS 13.0, *) {
            searchBarController.searchTextField.font = textFont
            searchBarController.searchTextField.backgroundColor = backgroundColor
        }
        else {
            let textFieldInsideUISearchBar = searchBarController.value(forKey: "_searchField") as? UITextField
            textFieldInsideUISearchBar?.font  = textFont
            textFieldInsideUISearchBar?.backgroundColor = backgroundColor
            
        }
        
        self.navigationController?.navigationBar.topItem?.titleView = searchBarController
    }
    
    func removeSearchBarFromNavigationBar() {
        self.navigationController?.navigationBar.topItem?.titleView = nil
    }
    
    func handleCartButtonSelection(btnCart:MIBadgeButton) {
        if btnCart.badgeString == "" {
            self.view.showToast(Messages.NoDataMessage.noDataInCart, position: .bottom, popTime: 2.0, dismissOnTap: true)
        }
        else {
            pushToViewController(VC: ViewControllersIdentifers.shoppingBagVC)
        }
        
    }
    
    
    //MARK:- Dismiss Keyboard
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    //MARK:- Show Alert
    func showAlert(message:String) {
        let alert = UIAlertController(title:AppInfo.appName, message: message, preferredStyle: .alert)
        alert.view.tintColor = AppColors.appColorBlue
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    func showAlertWithAction(message:String,onComplete:@escaping (()->())) {
        let alert = UIAlertController(title: AppInfo.appName, message: message, preferredStyle: .alert)
        alert.view.tintColor = AppColors.appColorBlue
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            onComplete()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithActionAndCancel(message:String,onComplete:@escaping (()->())) {
        let alert = UIAlertController(title: AppInfo.appName, message: message, preferredStyle: .alert)
        alert.view.tintColor = AppColors.appColorBlue
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            onComplete()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCancelAndOkAction(message:String,onComplete:@escaping (()->()),onCancel:@escaping (()->())) {
        let alert = UIAlertController(title: AppInfo.appName, message: message, preferredStyle: .alert)
        alert.view.tintColor = AppColors.appColorBlue
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            onComplete()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            onCancel()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func hideNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    func showNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.view.backgroundColor = AppColors.appColorBlue
        
    }
    
    
    func openCameraGalleryPopUp(onComplete:(()->())? = nil)  {
        dismissKeyboard()
        let optionMenu = UIAlertController(title: nil, message:nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.checkCameraValidations()
        })
        let saveAction = UIAlertAction(title: "Gallery", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openGallary()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            onComplete?()
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        optionMenu.view.tintColor  = AppColors.appColorBlue
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    
    // MARK:-  Open camera Method 
    fileprivate func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            picker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker!.sourceType = UIImagePickerController.SourceType.camera
            picker?.modalPresentationStyle = .overCurrentContext
            picker?.allowsEditing = true
            present(picker!, animated: true, completion: nil)
        }
            
        else {
            self.showAlert(message:OtherMessages.cameraNotFound)
        }
        
    }
    
    
    
    func checkCameraValidations() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch (authStatus){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.openCamera()
                    }
                }
            }
        case .restricted:
            alertForCameraPermission()
        case .denied:
            alertForCameraPermission()
        case .authorized:
            DispatchQueue.main.async {
                self.openCamera()
            }
        @unknown default:
            print("")
        }
        
    }
    
    
    
    // MARK:-  Open galary Method 
    func openGallary() {
        picker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        showNavigationBar()
        picker?.allowsEditing = true
        picker?.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker?.modalPresentationStyle = .overCurrentContext
        UINavigationBar.appearance().barTintColor = AppColors.appColorBlue
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        present(picker!, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    func getParticulatViewWithTag<T: UIView>(ofType type: T.Type,tag:Int) -> T?  {
        var viewToReturn: T?
        for i in self.view.subviewsRecursive() {
            if i.tag == tag {
                viewToReturn = i as? T
                break
            }
        }
        return viewToReturn
        
    }
    
    func numberOfShapedAdded() -> Int {
        let activeShapesArray = addedShapesPriceArray.filter { ($0 as? Double) != 0.0 }
        return activeShapesArray.count
        
    }
    
    
    
    func getParticulatViewWithIdentifer<T: UIView>(ofType type: T.Type,identifer:String) -> T?  {
        var viewToReturn: T?
        for i in self.view.subviewsRecursive() {
            if i.restorationIdentifier == identifer {
                viewToReturn = i as? T
                break
            }
        }
        return viewToReturn
    }
    
    
    
    func removeAllObjectsAddedInAvailableFunctionalView() {
        guard  let availableView = getParticulatViewWithIdentifer(ofType: UIView.self, identifer: RestorationIdentifer.availableView) else {
               return
               }
        for i in  availableView.subviews {
            i.removeFromSuperview()
        }
    }
    
    
    
    func createParticularShapeWithFabric(index:Int,productImage:UIImageView) {
        
        if let recentShape = recentShapeAdded {
            recentShape.removeFromSuperview()
        }
        
        guard  let screenShotView = getParticulatViewWithIdentifer(ofType: UIView.self, identifer:RestorationIdentifer.screenShotView) else {
            return
        }
        
        let availabeView = addAvailableFunctionalViewForGurstures(productImage: productImage)
        let width = CGFloat(80)
        let shapeView = UIView()    // create UI
        shapeView.borderColor = UIColor.black
        shapeView.borderWidth = 1.5
        shapeView.clipsToBounds = true
        shapeView.layer.cornerRadius = index == 1 ? width / 2 : 0
        shapeView.tag = addedShapesPriceArray.count - 1
        shapeView.restorationIdentifier = RestorationIdentifer.shapeView
        shapeView.frame = CGRect(x: ((availabeView.frame.width ) / 2) - width / 2 , y: (screenShotView.frame.height / 2) - width / 2, width: width, height: width)
        availabeView.addSubview(shapeView)
        let fabricImage = UIImageView(frame: CGRect(x: 0, y: 0, width: shapeView.frame.width, height: shapeView.frame.height))
        fabricImage.restorationIdentifier = RestorationIdentifer.fabricImage
        fabricImage.tag = 5
        shapeView.addSubview(fabricImage)
        
        // add guesture
        addRequiredGuestureOnView(view: shapeView)
        recentShapeAdded = shapeView
        
    }
  

    
    func addRequiredGuestureOnView(view:UIView) {
        let panGuesture = UIPanGestureRecognizer(target: self, action: #selector(BaseClass.handlePanOnSticker(sender:)))
        view.addGestureRecognizer(panGuesture)
        
        let pinchGuesture = UIPinchGestureRecognizer(target: self, action: #selector(BaseClass.handlePinchGesture(sender:)))
        view.addGestureRecognizer(pinchGuesture)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(BaseClass.handleTapOnSticker))
        view.isUserInteractionEnabled = true
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        let rotateGuesture = UIRotationGestureRecognizer(target: self, action: #selector(BaseClass.handleRotateGesture(_:)))
        view.addGestureRecognizer(rotateGuesture)
        view.isUserInteractionEnabled = true
    }
    
    func calculateRectOfImageInImageView(imageView: UIImageView) -> CGRect {
        let imageViewSize = imageView.frame.size
        let imgSize = imageView.image?.size
        
        guard let imageSize = imgSize else {
            return CGRect.zero
        }
        
        let scaleWidth = imageViewSize.width / imageSize.width
        let scaleHeight = imageViewSize.height / imageSize.height
        let aspect = fmin(scaleWidth, scaleHeight)
        
        
        let percentage = ((imageSize.width * aspect) * 44.4 ) / 100
        var imageRect = CGRect(x: 0, y: 0, width: (imageSize.width * aspect) , height: imageSize.height * aspect)
        // Center image
        imageRect.origin.x = ((imageViewSize.width - imageRect.size.width) / 2) - 1.0
        imageRect.origin.y = (imageViewSize.height - imageRect.size.height) / 2
        
        // Add imageView offset
        imageRect.origin.x += imageView.frame.origin.x
        imageRect.origin.y += imageView.frame.origin.y
        
        return imageRect
    }
    
    func addStickerImageInView(selectedImage:UIImage,productImage:UIImageView) {
        
        guard  let screenShotView = getParticulatViewWithIdentifer(ofType: UIView.self, identifer: RestorationIdentifer.screenShotView) else {
            return
        }
        
        let availableView = addAvailableFunctionalViewForGurstures(productImage: productImage)
        let width = CGFloat(80)
        let stickerView = UIView()    // create UI
        stickerView.frame = CGRect(x: ((availableView.frame.width ) / 2) - width / 2 , y: (screenShotView.frame.height / 2) - width / 2, width: width, height: width)
        stickerView.restorationIdentifier = RestorationIdentifer.stickerView
        availableView.addSubview(stickerView)
        
        let stickerImage = UIImageView()
        stickerImage.tag = 5
        stickerImage.isUserInteractionEnabled = false
        stickerImage.contentMode = .scaleAspectFill
        stickerImage.image = selectedImage
        stickerImage.frame = CGRect(x: 0, y: 0, width: width , height: width)
        stickerView.addSubview(stickerImage)
        
        let panGuesture = UIPanGestureRecognizer(target: self, action: #selector(BaseClass.handlePanOnSticker(sender:)))
        stickerView.addGestureRecognizer(panGuesture)
        
        let pinchGuesture = UIPinchGestureRecognizer(target: self, action: #selector(BaseClass.handlePinchGesture(sender:)))
        stickerView.addGestureRecognizer(pinchGuesture)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(BaseClass.handleTapOnSticker))
        stickerView.isUserInteractionEnabled = true
        singleTap.numberOfTapsRequired = 1
        stickerView.addGestureRecognizer(singleTap)
        let rotateGuesture = UIRotationGestureRecognizer(target: self, action: #selector(BaseClass.handleRotateGesture(_:)))
        stickerView.addGestureRecognizer(rotateGuesture)
        stickerView.isUserInteractionEnabled = true
    }
    
    
    func addAvailableFunctionalViewForGurstures(productImage:UIImageView) -> UIView {
        guard  let availableView = getParticulatViewWithIdentifer(ofType: UIView.self, identifer: RestorationIdentifer.availableView) else {
            let screenShotView = getParticulatViewWithIdentifer(ofType: UIView.self, identifer:RestorationIdentifer.screenShotView)
            let availableView = UIView(frame: calculateRectOfImageInImageView(imageView: productImage))
            availableView.clipsToBounds = true
            availableView.restorationIdentifier = RestorationIdentifer.availableView
            let newImageView = UIImageView(frame: productImage.frame)
            newImageView.image = productImage.image
            newImageView.contentMode = .scaleAspectFit
            availableView.frame = newImageView.frame
             availableView.backgroundColor = .clear
            availableView.mask = newImageView
         screenShotView?.addSubview(availableView)
            
            return availableView
        }
        return availableView
        
    }
    
    
    @objc func deleteStickerAction(_ sender:UIButton) {
        if let stickerView = sender.superview {
            stickerView.removeFromSuperview()
            
        }
    }
    
    @objc func handleTapOnSticker(_ sender: UITapGestureRecognizer) {
        //        let btnDelete =  sender.view?.viewWithTag(10) as? UIButton
        //        let isBtnHidden = btnDelete?.isHidden
        //        btnDelete?.isHidden = !(isBtnHidden ?? true)
        objectToDelete = sender.view
        handleDeleteUI(view: sender.view!)
    }
    
    func isStickerViewAdded() -> Bool {
        
        guard  getParticulatViewWithIdentifer(ofType: UIView.self, identifer:RestorationIdentifer.stickerView) != nil else {
            return false
        }
        return true
    }
    
    func handleDeleteUI(view:UIView) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        let deleteItem = UIMenuItem(title: "Delete", action: #selector(BaseClass.deleteObject))
        menu.menuItems = [deleteItem]
        menu.setTargetRect(CGRect(x: (view.bounds.midX - 10), y: 5.0, width: 20, height: 20), in: view)
        menu.setMenuVisible(true, animated: true)
    }
    
    @objc func deleteObject() {
        if objectToDelete == recentShapeAdded {
            
        }
        
        objectToDelete?.removeFromSuperview()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(BaseClass.deleteObject) {
            return true
        }
        
        return false
    }
    
    
    @objc func handlePanOnSticker(sender: UIPanGestureRecognizer) {
        if let stickerView = sender.view {
            var newCenter = sender.translation(in: self.view)
            if(sender.state == .began){
                beginX = stickerView.center.x
                beginY = stickerView.center.y
            }
            stickerView.viewWithTag(10)?.isHidden = true
            newCenter = CGPoint.init(x: beginX + newCenter.x, y: beginY + newCenter.y)
            stickerView.center = newCenter
        }
    }
    
    @objc func handlePinchGesture(sender:UIPinchGestureRecognizer) {
        guard sender.view != nil else {return}
        sender.view?.viewWithTag(10)?.isHidden = true
        let deleteButton =  sender.view?.viewWithTag(10) as? UIButton
        
        if sender.state == .changed {
            // Use the x or y scale, they should be the same for typical zooming (non-skewing)
            let currentScale = (sender.view?.layer.value(forKeyPath: "transform.scale.x") as? NSNumber)?.floatValue ?? 0.0
            // Variables to adjust the max/min values of zoom
            let minScale: Float = 0.4
            let maxScale: Float = 1.9
            let zoomSpeed: Float = 0.5
            var deltaScale = Float(sender.scale )
            // You need to translate the zoom to 0 (origin) so that you
            // can multiply a speed factor and then translate back to "zoomSpace" around 1
            deltaScale = ((deltaScale - 1) * zoomSpeed) + 1
            
            // Limit to min/max size (i.e maxScale = 2, current scale = 2, 2/2 = 1.0)
            //  A deltaScale is ~0.99 for decreasing or ~1.01 for increasing
            //  A deltaScale of 1.0 will maintain the zoom size
            deltaScale = min(deltaScale, maxScale / currentScale)
            deltaScale = max(deltaScale, minScale / currentScale)
            let zoomTransform = sender.view?.transform.scaledBy(x: CGFloat(deltaScale), y: CGFloat(deltaScale))
            sender.view?.transform = zoomTransform!
            // Reset to 1 for scale delta's
            //  Note: not 0, or we won't see a size: 0 * width = 0
            sender.scale = 1
        }
        
        
    }
    //MARK: HANDLE ROTATE GUESTURE
    @objc func handleRotateGesture(_ sender:UIRotationGestureRecognizer) {
        if  let stickerView = sender.view {
            stickerView.viewWithTag(10)?.isHidden = true
            if sender.state == .ended{
                lastRotation = 0.0
                return
            }
            let rotation : CGFloat = 0.0 - (lastRotation - sender.rotation)
            let currentTransform = stickerView.transform
            let newTransform = currentTransform.rotated(by: rotation)
            stickerView.transform = newTransform
            stickerView.layer.shouldRasterize = true
            stickerView.layer.rasterizationScale = UIScreen.main.scale
            lastRotation = sender.rotation
        }
        
    }
    
    // MARK: SAVE IMAGE IN GALLARY
    func saveImageInPhotoGalary(capturedImage:UIImage?) {
        if let image = capturedImage {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(BaseClass.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            self.view.showToast(Messages.LocalSuccessMessages.photoSavedSuccessfully, position: .bottom, popTime: 1.5, dismissOnTap: true)
        }
        
    }
    
}

//MARK:--  IMAGE PICKER DELEGATES 
extension BaseClass:UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        _ = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK:--  TEXT FIELD DELEGATES 
extension BaseClass : UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        showNavigationBar()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == TextFieldsTag.email {
            if !string.canBeConverted(to: String.Encoding.ascii) || string == " "{
                return false
            }
        }
        
        if textField.tag == TextFieldsTag.password {
            if !string.canBeConverted(to: String.Encoding.ascii) {
                return false
            }
        }
        if textField.tag == TextFieldsTag.firstname || textField.tag == TextFieldsTag.lastName {
            if !string.canBeConverted(to: String.Encoding.ascii) || string == " "{
                return false
            }
        }
        
        if textField.tag == TextFieldsTag.fullName {
            if !string.canBeConverted(to: String.Encoding.ascii) {
                return false
            }
        }
        
        return true
        
        
    }
    
}
////MARK:--  COUNTRY PICKER DELEGATES 
//extension BaseClass :MRCountryPickerDelegate {
//    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
//
//    }
//
//}
//MARK:--  TEXT VIEW DELEGATES 
extension BaseClass: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        showNavigationBar()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    
}
//MARK:--  SCROLL VIEW DELEGATES 
extension BaseClass: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
    }
    
}


//MARK:--  Photo Viewer DELEGATES 
extension BaseClass : SKPhotoBrowserDelegate {
    
}

//MARK:--  SEARCH BAR DELEGATES 
extension BaseClass :  UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarController.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarController.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarController.text = ""
        searchBarController.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if !text.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        return true
    }
    
}

//MARK:--  PICKER VIEW DELEGATES 
extension BaseClass:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name:AppFont.fontRegular, size:18)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = ""
        pickerLabel?.textColor = UIColor.black
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
    }
    
    
    
}

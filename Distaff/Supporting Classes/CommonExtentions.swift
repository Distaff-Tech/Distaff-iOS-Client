

import Foundation
import UIKit
import WebKit
import UITextView_Placeholder
import SDWebImage
import MIBadgeButton_Swift


//MARK:- UIVIEW EXTENTION
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shadowRadius
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.shadowColor!)
            return color
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    func constraintWith(identifier: String) -> NSLayoutConstraint?{
        return self.constraints.first(where: {$0.identifier == identifier})
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
    
    func screenshot() -> UIImage {
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: CGRect(origin: .zero, size: bounds.size), afterScreenUpdates: true)
        }
    }
    
    func circularView()
    {
        // self.layer.backgroundColor = colour.cgColor
        self.layer.cornerRadius = self.layer.frame.size.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
        
    }
    
    func handleVisibility(shouldHide:Bool) {
        self.subviews.forEach { $0.isHidden = shouldHide }
    }
    
    
}

class RotatedView: UIScrollView {
    @IBInspectable var roateAngle: Double = 0 {
        didSet {
            rotateView(labelRotation: roateAngle)
            self.layoutIfNeeded()
        }
    }
    
    func rotateView(labelRotation: Double)  {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(roateAngle) * CGFloat(Double.pi/180) )
        let imageView = self.subviews[0] as! UIImageView
        imageView.layer.allowsEdgeAntialiasing = true
        self.layer.allowsEdgeAntialiasing = true
    }
    
    
    
}

//MARK:- COLOR EXTENTION
extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    
    
}

//MARK:- STRING EXTENTION
extension String
{
    
    func toDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter.number(from: self)?.doubleValue
    }
    
    private static let decimalFormatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        return formatter
    }()
    
    private var decimalSeparator:String{
        return String.decimalFormatter.decimalSeparator ?? "."
    }
    
    func isValidDecimal(maximumFractionDigits:Int)->Bool{
        
        // Depends on you if you consider empty string as valid number
        guard self.isEmpty == false else {
            return true
        }
        
        // Check if valid decimal
        if let _ = String.decimalFormatter.number(from: self){
            
            // Get fraction digits part using separator
            let numberComponents = self.components(separatedBy: decimalSeparator)
            let fractionDigits = numberComponents.count == 2 ? numberComponents.last ?? "" : ""
            return fractionDigits.count <= maximumFractionDigits
        }
        
        return false
    }
    
    
    
    func whiteSpaceCount(text:String) -> Int {
        return text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).count
        
    }
    
    //MARK: Email validation Method
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        
        if size.width < 35
        {
            return 55
        }
        if size.width < 65
        {
            return 85
        }
        
        return size.width
    }
    
    
}


private var __maxLengths = [UITextField: Int]()

//MARK:- TEXT FIELD EXTENTION
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
    
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
}


extension UILabel{
    func circularLabel()
    {
        // self.layer.backgroundColor = colour.cgColor
        self.layer.cornerRadius = self.layer.frame.size.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
    }
    
    
    // MARK: - spacingValue is spacing that you need
    func addInterlineSpacing(spacingValue: CGFloat = 2, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacingValue
        paragraphStyle.alignment = .center
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))
        
        attributedText = attributedString
    }
    
    
    
    
}

extension UIImageView{
    
    func setImageWithurl(urlString:NSURL?) {
        if let url = urlString {
            self.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.sd_setImage(with: url as URL, placeholderImage:nil)
        }
    }
    
    
    func setSdWebImage(url:String,isForCustomDesign:Bool? = nil) {
        if url == "" {
            self.image = Variables.shared.placeholderImage
        }
        else {
            self.sd_imageIndicator = isForCustomDesign ?? false ? SDWebImageActivityIndicator.grayLarge : SDWebImageActivityIndicator.gray
            self.sd_setImage(with: URL.init(string: "\(WebServicesApi.imageBaseUrl)\(url)"), placeholderImage:isForCustomDesign ?? false ? nil : #imageLiteral(resourceName: "noImage"), options: .highPriority, completed: nil)
        }
        
    }
    
    
    func circular()
    {
        // self.layer.backgroundColor = colour.cgColor
        self.layer.cornerRadius = self.layer.frame.size.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
        
    }
    func circularClearColor()
    {
        // self.layer.backgroundColor = colour.cgColor
        self.layer.cornerRadius = self.layer.frame.size.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
    }
    func roundCornerBorderOnly()
    {
        // self.layer.backgroundColor = colour.cgColor
        self.layer.cornerRadius = self.layer.frame.size.height/2
        self.layer.borderWidth = 3
        self.layer.borderColor =  UIColor(red: 121/255, green: 196/255, blue: 205/255, alpha: 1).cgColor
        
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.0
        self.clipsToBounds = false
    }
    
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 10
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
    
}

extension Double {
    
    func calculateCurrency(fractionDigits:Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    
}



extension WKWebView {
    func loadUrlRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
        else {
            // show Alert here
        }
        
    }
}


extension UIButton{
    
    func setSdWebImage(url:String) {
        if url == "" {
            self.setImage(Variables.shared.placeholderImage, for: .normal)
        }
        else {
            self.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.sd_setImage(with: URL.init(string: "\(WebServicesApi.imageBaseUrl)\(url)"), for: .normal, placeholderImage: #imageLiteral(resourceName: "noImage"), options: .highPriority, completed: nil)
        }
        
    }
    
    
    func roundCornerWithClearBackground(colour:UIColor)
    {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = self.layer.frame.size.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = colour.cgColor
        
    }
    
    func roundCornerWithBackground(colour:UIColor)
    {
        self.layer.backgroundColor = colour.cgColor
        self.layer.cornerRadius = self.layer.frame.size.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = colour.cgColor
        
    }
    
    func roundCorner()
    {
        // self.layer.backgroundColor = colour.cgColor
        self.layer.cornerRadius = self.layer.frame.size.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        
    }
    
    
    
    func roundCornerBorderOnly()
    {
        // self.layer.backgroundColor = colour.cgColor
        self.layer.cornerRadius = self.layer.frame.size.height/4
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        
    }
    
}

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    func offsetLong(date: Date) -> String {
        if years(from: date)   > 0
        {
            if months(from: date)  < 12
            {
                return months(from: date) > 1 ? "\(months(from: date)) months ago" : "\(months(from: date)) month ago"
            }
            else
            {
                return years(from: date) > 1 ? "\(years(from: date)) years ago" : "\(years(from: date)) year ago"
            }
        }
        if months(from: date)  > 0
        {
            if weeks(from: date)   < 4
            {
                return weeks(from: date) > 1 ? "\(weeks(from: date)) weeks ago" : "\(weeks(from: date)) week ago"
            }
            else
            {
                return months(from: date) > 1 ? "\(months(from: date)) months ago" : "\(months(from: date)) month ago"
            }
        }
        if weeks(from: date)   > 0
        {
            if days(from: date)    < 7
            {
                return days(from: date) > 1 ? "\(days(from: date)) days ago" : "\(days(from: date)) day ago"
            }
            else
            {
                return weeks(from: date) > 1 ? "\(weeks(from: date)) weeks ago" : "\(weeks(from: date)) week ago"
            }
        }
        if days(from: date)    > 0
        {
            if hours(from: date)   < 24
            {
                return hours(from: date) > 1 ? "\(hours(from: date)) hours ago" : "\(hours(from: date)) hour ago"
            }
            else
            {
                return days(from: date) > 1 ? "\(days(from: date)) days ago" : "\(days(from: date)) day ago"
            }
        }
        if hours(from: date)   > 0
        {
            if minutes(from: date) < 59
            {
                return minutes(from: date) > 1 ? "\(minutes(from: date)) minutes ago" : "\(minutes(from: date)) minute ago"
            }
            else
            {
                return hours(from: date) > 1 ? "\(hours(from: date)) hours ago" : "\(hours(from: date)) hour ago"
            }
        }
        if minutes(from: date) > 0
        {
            if seconds(from: date) < 59
            {
                return seconds(from: date) > 1 ? "\(seconds(from: date)) seconds ago" : "\(seconds(from: date)) second ago"
            }
            else
            {
                return minutes(from: date) > 1 ? "\(minutes(from: date)) minutes ago" : "\(minutes(from: date)) minute ago"
            }
        }
        if seconds(from: date) > 0
        {
            return seconds(from: date) > 1 ? "\(seconds(from: date)) seconds ago" : "\(seconds(from: date)) second ago"
        }
        
        return "just now"
    }
    
    
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   == 1
        {
            return "\(years(from: date)) year"
        }
        else if years(from: date)   > 1
        {
            return "\(years(from: date)) years"
        }
        if months(from: date)  == 1
        {
            return "\(months(from: date)) month"
        }
        else if months(from: date)  > 1
        {
            return "\(months(from: date)) month"
        }
        if weeks(from: date)   == 1
        {
            return "\(weeks(from: date)) week"
        }
        else if weeks(from: date)   > 1
        {
            return "\(weeks(from: date)) weeks"
        }
        if days(from: date)    == 1
        {
            return "\(days(from: date)) day"
        }
        else if days(from: date)    > 1
        {
            return "\(days(from: date)) days"
        }
        if hours(from: date)   == 1
        {
            return "\(hours(from: date)) hour"
        }
        else if hours(from: date)   > 1
        {
            return "\(hours(from: date)) hours"
        }
        if minutes(from: date) == 1
        {
            return "\(minutes(from: date)) minute"
        }
        else if minutes(from: date) > 1
        {
            return "\(minutes(from: date)) minutes"
        }
        return ""
    }
    
    
    func offsetFrom(date : Date) -> String {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self);
        
        let seconds = "\(difference.second ?? 0)sec"
        let minutes = "\(difference.minute ?? 0)min" + " " + seconds
        let hours = "\(difference.hour ?? 0)hours" + " " + minutes
        let days = "\(difference.day ?? 0)days" + " " + hours
        
        if let day = difference.day, day          > 0 { return days }
        if let hour = difference.hour, hour       > 0 { return hours }
        if let minute = difference.minute, minute > 0 { return minutes }
        if let second = difference.second, second > 0 { return seconds }
        return ""
        
    }
    
    
    func monthAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MMM")
        return df.string(from: self)
    }
    
}

@IBDesignable
class StackView: UIStackView {
    @IBInspectable private var color: UIColor?
    override var backgroundColor: UIColor? {
        get { return color }
        set {
            color = newValue
            self.setNeedsLayout() // EDIT 2017-02-03 thank you @BruceLiu
        }
    }
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
        backgroundLayer.fillColor = self.backgroundColor?.cgColor
    }
}

extension UIDatePicker {
    func set18YearValidation() {
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.year = -18
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        components.year = -100
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        self.minimumDate = minDate
        self.maximumDate = maxDate
    } }

extension UITableView {
    func removeExtraSeprators() {
        self.tableFooterView = UIView()
    }
    
    func setContentInsect(edgeInsets:UIEdgeInsets) {
        self.contentInset = edgeInsets
    }
    
    func showNoDataLabel(message:String,arrayCount:Int) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: AppFont.fontRegular, size: 15)
        messageLabel.sizeToFit()
        if arrayCount == 0 {
            self.backgroundView = messageLabel
        }
        else  {
            self.backgroundView = nil
        }
    }
    
    func reloadDataWithoutScroll() {
        let offset = contentOffset
        reloadData()
        layoutIfNeeded()
        setContentOffset(offset, animated: false)
    }
    
    
    
    func scrollToBottom(indexPath:NSIndexPath) {
        self.selectRow(at: indexPath as IndexPath, animated: false, scrollPosition: .bottom)
        
    }
    
    func scrollToTop(indexPath:NSIndexPath) {
        self.selectRow(at: indexPath as IndexPath, animated: true, scrollPosition: .top)
    }
}


extension UICollectionView {
    func showNoDataLabel(message:String,arrayCount:Int) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: AppFont.fontRegular, size: 15)
        messageLabel.sizeToFit()
        if arrayCount == 0 {
            self.backgroundView = messageLabel
        }
        else  {
            self.backgroundView = nil
        }
    }
    var centerPoint : CGPoint {
        
        get {
            return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y);
        }
    }
    
    var centerCellIndexPath: IndexPath? {
        
        if let centerIndexPath: IndexPath  = self.indexPathForItem(at: self.centerPoint) {
            return centerIndexPath
        }
        return nil
    }
    
}

extension UISwitch {
    func resize(with scaleX:CGFloat,scaleY:CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        
    }
    
}

extension UITextView {
    func setPlaceholder(with text:String, padding:UIEdgeInsets? = nil,placeholderColor:UIColor) {
        if let paddings = padding {
            self.textContainerInset = paddings
        }
        self.placeholder = text
        self.placeholderColor = placeholderColor
    }
    
}
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension UIViewController {
    
    func calculateCurrentPage(index:Int) -> Int {
        let itemsPerPage = 20
        let value = index / itemsPerPage
        print((index % itemsPerPage) == 0 ? value :  value + 1)
        return (index % itemsPerPage) == 0 ? value :  value + 1
    }
    
    
    
    func isBankAdded() ->(Bool,Bank_detail? ) {
        if let id = (userdefaultsRef.value(Bank_detail.self, forKey: UserDefaultsKeys.bankInfo))?.id {
            print(id)
             return (true,(userdefaultsRef.value(Bank_detail.self, forKey: UserDefaultsKeys.bankInfo)))
               }
        return (false,nil)
        
    }
    
    
    func clearSDWebCache() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }
    
    func showCartCount(btnCart: MIBadgeButton!) {
        if  let totalCount = userdefaultsRef.value(forKey: UserDefaultsKeys.cartCount) as? Int {
            btnCart.badgeString = totalCount == 0 ? "" : "\(totalCount)"
        }
    }
    
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
    
    func alertForCameraPermission() {
        let alert = UIAlertController(
            title: "IMPORTANT",
            message: "Camera access required for capturing photos!",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.view.tintColor = AppColors.appColorBlue
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            
        }))
        present(alert, animated: true, completion: nil)
    }
    
 func alertForGallaryPermission() {
     let alert = UIAlertController(
         title: "IMPORTANT",
         message: "Save to Gallery permission is required.",
         preferredStyle: UIAlertController.Style.alert
     )
     alert.view.tintColor = AppColors.appColorBlue
     alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
     alert.addAction(UIAlertAction(title: "Settings", style: .cancel, handler: { (alert) -> Void in
         UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
         
     }))
     present(alert, animated: true, completion: nil)
 }

    
    
}

extension UserDefaults {
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}

extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            
            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                guard let statusBarFrame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame else { return nil }
                let statusBarView = UIView(frame: statusBarFrame)
                statusBarView.tag = tag
                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        } else {
            return nil
        }
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIScrollView {
    func resetContentSize() {
        if self.contentOffset.y > 0 {
            self.contentOffset.y = 0
        }
    }
}
extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension MutableCollection {
    mutating func mutateEach(_ body: (inout Element) throws -> Void) rethrows {
        for index in self.indices {
            try body(&self[index])
        }
    }
}

extension Array {
    func uniques<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return reduce([]) { result, element in
            let alreadyExists = (result.contains(where: { $0[keyPath: keyPath] == element[keyPath: keyPath] }))
            return alreadyExists ? result : result + [element]
        }
    }
}

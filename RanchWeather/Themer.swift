import UIKit
import CoreText

private enum BNRColors {
    // Note: These are called hexadecimal literals
    static let OffWhite  = UIColor(hex: 0xEEEEEE)
    static let OffBlack  = UIColor(hex: 0x333333)
    static let Red       = UIColor(hex: 0xE15827)
    static let Yellow    = UIColor(hex: 0xECB02F)
}

enum Theme: String {
    case day   = "com.ranchweather.theme.day"
    case night = "com.ranchweather.theme.night"
    
    var backgroundColor: UIColor {
        switch self {
        case .day:   return BNRColors.OffWhite
        case .night: return BNRColors.OffBlack
        }
    }
    
    var tableViewBackgroundColor: UIColor {
        switch self {
        case .day:   return BNRColors.OffWhite
        case .night: return BNRColors.OffBlack
        }
    }
    
    var tableViewCellBackgroundColor: UIColor {
        switch self {
        case .day:   return UIColor.white
        case .night: return UIColor.black
        }
    }
    
    var tableViewCellTextColor: UIColor {
        switch self {
        case .day:   return BNRColors.OffBlack
        case .night: return BNRColors.OffWhite
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .day:   return BNRColors.OffBlack
        case .night: return BNRColors.OffWhite
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .day:   return BNRColors.Red
        case .night: return BNRColors.Yellow
        }
    }
    
    var preferredStatusBarStyle: UIStatusBarStyle {
        switch self {
        case .day:   return UIStatusBarStyle.default
        case .night: return UIStatusBarStyle.lightContent
        }
    }
    
}

struct Themer {
    let theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        updateGlobalThemeSettings()
    }
    
    func updateGlobalThemeSettings() {
        updateNavigationBar()
        reloadWindow()
    }
    
    // Note: UIAppearance settings are only good for new 
    // views created and thus changing the values while 
    // the app is running does not cause a visual change. 
    // To force this one hacky option is to remove everything 
    // from the view hierachy and add it back which will
    // utilize the new appearance settings.
    func reloadWindow() {
        let windows = UIApplication.shared.windows
        for window in windows {
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
    }
    
    func updateNavigationBar() {
        let apperance = UINavigationBar.appearance()
        apperance.barTintColor = theme.backgroundColor
        apperance.titleTextAttributes = [NSForegroundColorAttributeName: theme.textColor]
        apperance.tintColor = theme.tintColor
    }
    
    // Manual calls
    
    func theme(tableView: UITableView) {
        tableView.backgroundColor = theme.tableViewBackgroundColor
    }
    
    func theme(tableViewCell cell: UITableViewCell) {
        cell.backgroundColor = theme.tableViewCellBackgroundColor
        cell.textLabel?.textColor = theme.tableViewCellTextColor
    }
    
    func theme(backgroundView view: UIView) {
        view.backgroundColor = theme.tableViewBackgroundColor
    }
}

private extension UIColor {
    convenience init(hex: UInt32) {
        // Note: This is called the bit shift operator
        let red   = CGFloat((hex >> 16) & 0xff) / 255
        let green = CGFloat((hex >>  8) & 0xff) / 255
        let blue  = CGFloat((hex      ) & 0xff) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

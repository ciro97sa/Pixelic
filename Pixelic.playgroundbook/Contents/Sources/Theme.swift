import UIKit

//Theme chooses
public enum Theme {
    case light
    case basic
    case blue
    
    //The main color
    var mainColor: UIColor {
        switch self {
        case .light:
            return .lightGray
        case .basic:
            return Theme.basicColor
        case .blue :
            return Theme.clearBlue
        }
    }
    
   //SecondColor of the theme
    public var accentColor: UIColor {
        switch self {
        case .light:
            return .white
        case .basic:
            return Theme.secondBasicColor
        case .blue:
            return Theme.clearRed
        }
    }
    
    var paletteDefault: UIColor {
        switch self {
        case .light:
            return .lightGray
        case .basic:
            return .lightGray
        case .blue:
            return .lightGray
        }
    }
    
    var paletteSelected: UIColor {
        switch self {
        case .light:
            return Theme.xcodeDarkGray
        case .basic:
            return Theme.gold
        case .blue :
            return Theme.clearRed
        }
    }
    
    
    //First colors:
    static var clearRed = UIColor(red: 245/255, green: 140/255, blue: 163/255, alpha: 1)
    static var basicColor = UIColor(red: 108/255, green: 91/255, blue: 123/255, alpha: 1)
    
    //Second Colors:
    static var clearBlue = UIColor(red: 89/255, green: 84/255, blue: 234/255, alpha: 1)
    static var secondBasicColor = UIColor(red: 248/255, green: 177/255, blue: 149/255, alpha: 1)
    
    //For palettes
    static var gold = UIColor(red: 255/255, green: 251/255, blue: 0, alpha: 1)
    static var xcodeDarkGray = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
}

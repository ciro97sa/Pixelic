import UIKit


class DataModel{
public static let shared = DataModel()
public var arrayOfIcons : [String] = ["Stitch","mushroom","Maggie","Bugs Bunny","Muffin","Hour glass","Panda","Wile Coyote","Minion","SuperMario"]
}

public var saveLabel = UILabel(frame : CGRect(x : 0, y : 0, width:  Metrics.large * 3 + 10, height: Metrics.large + 10))

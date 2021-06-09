//
//  ViewController.swift
//  productname
//
//  Created by Ciro Sannino on 29/03/18.
//  Copyright © 2018 Ciro Sannino. All rights reserved.
//

import UIKit
import PlaygroundSupport
@objc(ViewController)
public class ViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension ViewController {
    //loadfromStoryboard to use in Commands
    public class func loadFromStoryboard()-> ViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateInitialViewController() as! ViewController
    }
}


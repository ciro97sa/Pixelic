/*:
 ## **Draw your Icon**
 
 Miss all the pixel perfect art that was popular in the 90's? If so, Pixel Art Maker is for you! Try and replicate old classics like Crash, SuperMario or freestyle your own art!
 
 Tap `Run My Code` to interact with Pixelic features on the screen.  Once you're finished just enjoy the next page about live coding!

 [**Next Page**](@next)
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-hidden-code

import UIKit
import PlaygroundSupport
let page = PlaygroundPage.current
public let vc = ViewController.loadFromStoryboard() as! ViewController
page.liveView = vc

//#-end-hidden-code

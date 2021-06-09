/*:
 ## **Unleash your creativity**

 **Challenge**: Set the value of your workspace variables' and then use the suggested function 'createWorkspace(Workspace:YourWorkspace)' to create your [instance](glossary://instance) of the [class](glossary://class) Workspace!
 
As soon as you have completed the previous actions tap `Run My Code` to interact with the Pixelic Interface on the screen. Click on it and start to draw everything that you want! If you have no idea , don't worry! Tap in one of the suggested images (_"Tap me"_) and try to replicate that image ! If you want to see only your workspace swipe left or right (up or down) in the full-screen view to have a better view of your workspace. After this you can save your pixel masterpiece in your photo library!
 
 */
//#-hidden-code
import UIKit
import PlaygroundSupport
//#-end-hidden-code
//#-editable-code
let theme : Theme = .basic //try .light too!
//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
let heightWidthInPixels : Int = 20
let pixelSize : CGFloat = 20
let backgroundColor : UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let colorPalette : [UIColor] = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.9814051986, green: 0.7592356801, blue: 0.5372794271, alpha: 1),#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),#colorLiteral(red: 0.005403630435, green: 0.3112497032, blue: 0.6826733947, alpha: 1),#colorLiteral(red: 0.9969266057, green: 0.01187200751, blue: 0, alpha: 1)]
//#-end-editable-code
//: You are creating an instance of the class Workspace with your variables!
let myWorkspace = Workspace(
    width: heightWidthInPixels,
    height: heightWidthInPixels,
    pixelSize: pixelSize,
    sketchColor: backgroundColor,
    colorPalette: colorPalette,
    theme: theme)
//: Now use the suggested function createWorkspace(Workspace: yourWorkspace) , add your workspace and Tap 'Run my code'!
//#-code-completion(identifier, show, createWorkspace(Workspace:))
//#-code-completion(description, show, "createWorkspace(Workspace:Workspace)")
//#-editable-code Tap to enter code
//#-end-editable-code


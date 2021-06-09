import UIKit
import PlaygroundSupport


//MARK : setupAssessements() function
public func setupAssessements(){
// Define hints and solutions
PlaygroundPage.current.assessmentStatus = PlaygroundPage.AssessmentStatus.fail(hints: ["First you need to create your workspace otherwise how will you be able to draw your favourite image ?!","Once the workspace has been created you can move on to animate it!", "You need to set all the variables to create your own workspace"], solution: "First use `createWorkspace()`to create the workspace ")
}



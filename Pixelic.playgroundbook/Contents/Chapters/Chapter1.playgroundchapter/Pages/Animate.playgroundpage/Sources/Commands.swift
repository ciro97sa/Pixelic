import UIKit
import PlaygroundSupport

public func createWorkspace(/*workspace myWorkspace*/Workspace : Workspace){
// Setup the Live View
PlaygroundPage.current.liveView = Workspace
setupAssessements()
}

//MARK : createWorkspace to use in Contents.swift
//public func createWorkspace(){
//    createWorkspace(workspace: myWorkspace)
//}

//func say(_ message : String) {
//    let page = PlaygroundPage.current
//    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
//        proxy.send(.string(message))
//    }


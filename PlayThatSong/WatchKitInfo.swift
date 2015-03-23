//
//  WatchKitInfo.swift
//  PlayThatSong
//
//  Created by Jonas Baer on 23.03.15.
//  Copyright (c) 2015 jonas-baer.com. All rights reserved.
//

import Foundation

let key = "FunctionRequestKey"

// class existing in order to store information transfered beween WatchKit and Iphone App
class watchKitInfo {

    var replyBlock: ([NSObject : AnyObject]!) -> Void // same type like the one in AppDelegate.swift
    var playerRequest: String? // it is optional = "?" to cover the case we don't get a key back

    init (playerDictionary: [NSObject : AnyObject], reply: ([NSObject : AnyObject]!) -> Void) {

        // when playerDictionary is not nil ... then...
        if let playerDictionary = playerDictionary as? [String: String] { // AnyObject above changed to String !
            playerRequest = playerDictionary[key]
        }
        else {
            println("No Information Error")
        }

        replyBlock = reply // init requires a reply !
    }
}
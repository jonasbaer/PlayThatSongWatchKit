//
//  InterfaceController.swift
//  PlayThatSong WatchKit Extension
//
//  Created by Jonas Baer on 18.03.15.
//  Copyright (c) 2015 jonas-baer.com. All rights reserved.
//

import WatchKit
import Foundation

let key = "FunctionRequestKey"

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var songTitleLabel: WKInterfaceLabel!
    @IBOutlet weak var playButtonLabel: WKInterfaceButton!



    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    // IBActions

    @IBAction func previousSongButtonPressed() {

        var info = [key : "Previous"]
        WKInterfaceController.openParentApplication(info, reply: { (reply, error) -> Void in
            println("reply \(reply) error \(error)")
            if reply != nil {
                self.updateLabel(reply as [String : String])
            }
        })
    }

    @IBAction func nextSongButtonPressed() {

        var info = [key : "Next"]
        WKInterfaceController.openParentApplication(info, reply: { (reply, error) -> Void in
            println("reply \(reply) error \(error)")
            if reply != nil {
                self.updateLabel(reply as [String : String])
            }
        })
    }

    @IBAction func playSongButtonPressed() {

        var info = [key : "Play"]
        WKInterfaceController.openParentApplication(info, reply: { (reply, error) -> Void in
            println("reply \(reply) error \(error)")
            if reply != nil {
                self.updateLabel(reply as [String : String])
            }
        })
    }

    func updateLabel (songDictionary : [String : String]) { // allows to use var songDictionary in this function 
        let songName = songDictionary["currentSong"]
        self.songTitleLabel.setText(songName)
    }
}


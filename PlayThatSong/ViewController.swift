//
//  ViewController.swift
//  PlayThatSong
//
//  Created by Jonas Baer on 18.03.15.
//  Copyright (c) 2015 jonas-baer.com. All rights reserved.
//

import UIKit
import AVFoundation // see supporting file

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var currentSongLabel: UILabel!

    var audioSession: AVAudioSession!
    var audioPlayer: AVAudioPlayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("fuck it #1")

        self.configureAudioSession()
        self.configureAudioPlayer()
        println("fuck it #2")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // IBActions...



    @IBAction func playButtonPressed(sender: UIButton) {
        self.playMusic()

    }

    @IBAction func playPreviousButtonPressed(sender: UIButton) {

    }

    @IBAction func playNextButtonPressed(sender: UIButton) {

    }


    // Audio...

    func configureAudioSession () {
        self.audioSession = AVAudioSession.sharedInstance()

        var categoryError:NSError?
        var activeError:NSError?

        println("error \(categoryError)")
        self.audioSession.setCategory(AVAudioSessionCategoryPlayback, error: &categoryError)
        var success = self.audioSession.setActive(true, error: &activeError)
        if !success {
            println("error making audio session active \(activeError)")

        }
    }

    func configureAudioPlayer () {
        var songPath = NSBundle.mainBundle().pathForResource("Open Source - Sending My Signal", ofType: "mp3")
        var songURL = NSURL.fileURLWithPath(songPath!)

        println("SongURL: \(songURL)")

        var songError: NSError?
        self.audioPlayer = AVAudioPlayer(contentsOfURL: songURL, error: &songError)
        println("song error: \(songError)")
        self.audioPlayer.numberOfLoops = 0

    }

    func playMusic () {
        self.audioPlayer.prepareToPlay()
        self.audioPlayer.play()

    }


}


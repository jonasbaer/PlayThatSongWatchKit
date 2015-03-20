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

        self.configureAudioSession()
        self.configureAudioPlayer()

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

    func createSongs () -> [AnyObject] { // creates an array with song as array element
        let firstSongPath = NSBundle.mainBundle().pathForResource("CLASSICAL SOLITUDE", ofType: "wav")
        let secondSongPath = NSBundle.mainBundle().pathForResource("Timothy Pinkham - The Knolls of Doldesh", ofType: "mp3")
        let thirdSongPath = NSBundle.mainBundle().pathForResource("Open Source - Sending My Signal", ofType: "mp3")

        // create urls
        let firstSongURL = NSURL.fileURLWithPath(firstSongPath!)
        let secondSongURL = NSURL.fileURLWithPath(secondSongPath!)
        let thirdSongURL = NSURL.fileURLWithPath(thirdSongPath!)

        // bring them in a playable way
        let firstPlayItem = AVPlayerItem(URL: firstSongURL)
        let secondPlayItem = AVPlayerItem(URL: secondSongURL)
        let thirdPlayItems = AVPlayerItem(URL: thirdSongURL)



    }

}


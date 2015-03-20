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
//    var audioPlayer: AVAudioPlayer!
    var audioQueuePlayer: AVQueuePlayer!

    var currentSongIndex:Int!


    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.configureAudioSession()
//        self.configureAudioPlayer()
        self.configureAudioQueuePlayer()
    }


    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // >IBActions...<

    @IBAction func playButtonPressed(sender: UIButton) {

        self.playMusic()
    }


    @IBAction func stopButtonPressed(sender: UIButton) {

        //        self.audioPlayer.stop()
        self.audioQueuePlayer.pause()
    }


    @IBAction func playPreviousButtonPressed(sender: UIButton) {

        // there is no predefined function like below ;)


        // no index back before 0 !
        if currentSongIndex > 0 {
            self.audioQueuePlayer.pause()

            // reset the time to 0
            self.audioQueuePlayer.seekToTime(kCMTimeZero, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)

            // create temp var to show where we are and reduce by 1
            let temporaryNowPlayIndex = currentSongIndex
            // returns a array with all our MVP Items
            let temporaryPlayList = self.createSongs()

            // remove all items out of our queue
            self.audioQueuePlayer.removeAllItems()

            // recreate our queue - go back -1 from current song
            for var index = temporaryNowPlayIndex - 1; index < temporaryPlayList.count; index++ {

                // repopulating our queue - in a loop
                self.audioQueuePlayer.insertItem(temporaryPlayList[index] as AVPlayerItem, afterItem: nil)
            }

            // update current song Index
            self.currentSongIndex = temporaryNowPlayIndex - 1

            // 2nd time needed - iOS BUG :(
            self.audioQueuePlayer.seekToTime(kCMTimeZero, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)

            // play it :)
            self.audioQueuePlayer.play()
        }
    }


    @IBAction func playNextButtonPressed(sender: UIButton) {

        self.audioQueuePlayer.advanceToNextItem()
        self.currentSongIndex = self.currentSongIndex + 1
    }


    // >Audio...<


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

//    func configureAudioPlayer () {
//        var songPath = NSBundle.mainBundle().pathForResource("Open Source - Sending My Signal", ofType: "mp3")
//        var songURL = NSURL.fileURLWithPath(songPath!)
//
//        println("SongURL: \(songURL)")
//
//        var songError: NSError?
//        self.audioPlayer = AVAudioPlayer(contentsOfURL: songURL, error: &songError)
//        println("song error: \(songError)")
//        self.audioPlayer.numberOfLoops = 0
//
//    }


    func configureAudioQueuePlayer () {

        let songs = createSongs()
        self.audioQueuePlayer = AVQueuePlayer(items: songs)

        // when song is finished - receive notification! 
        for var songIndex = 0; songIndex < songs.count; songIndex++ { // send msg to this class
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "songEnded:", name: AVPlayerItemDidPlayToEndTimeNotification, object: songs[songIndex])
        }
    }


    func playMusic () {

        //Implement to use the audioplayer we replaced this with the audio queue player
//        self.audioPlayer.prepareToPlay()
//        self.audioPlayer.play()
        self.audioQueuePlayer.play()
        currentSongIndex = 0

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
        let thirdPlayItem = AVPlayerItem(URL: thirdSongURL)

        // creates the array
        let songs: [AnyObject] = [firstPlayItem, secondPlayItem, thirdPlayItem]

        return songs
    }


    // >audio notification<

    func songEnded (notification: NSNotification) {

        self.currentSongIndex = self.currentSongIndex + 1
    }

}


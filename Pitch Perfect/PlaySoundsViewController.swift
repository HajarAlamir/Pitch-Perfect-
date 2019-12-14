//
//  PlaySoundsViewController.swift
//  Pitch Perfect  SEND FEEDBACK Pitch Perfect
//
//  Created by Hajar F on 9/17/19.
//  Copyright © 2019 Hajar F. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: PlaySoundsViewController
class PlaySoundsViewController: UIViewController {
    
    // MARK: initialize Button
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // MARK: Button Type
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: play Sound For Button Functions
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            // play Sound Slow
            playSound(rate: 0.5)
        case .fast:
            // play Sound Fast
            playSound(rate: 1.5)
        case .chipmunk:
            // play Sound Chipmunk
            playSound(pitch: 1000)
        case .vader:
            // play Sound Vader
            playSound(pitch: -1000)
        case .echo:
            // play Sound Echo
            playSound(echo: true)
        case .reverb:
            // play Sound Reverb
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    // MARK: stop Button Pressed Functions
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
     // MARK: loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
   // MARK: view Will Appear Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
   
}

//
//  RecordSoundsViewController.swift
//  Pitch Perfect  SEND FEEDBACK Pitch Perfect
//
//  Created by Hajar F on 9/16/19.
//  Copyright © 2019 Hajar F. All rights reserved.
//

import UIKit
import AVFoundation


// MARK: - RecordSoundsViewController

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
// MARK: initialize  Button
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    
    // MARK: buttonset Functions
    func  buttonset  (lableText :String , stopRec : Bool , reco : Bool ){
        
        recordingLabel.text = lableText
        stopRecordingButton.isEnabled = stopRec
        recordButton.isEnabled = reco
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
       
    }

// MARK: record Audio Button Functions
    @IBAction func recordAudio(_ sender: Any) {
        buttonset (lableText : "Recording in Progress" , stopRec: true , reco: false)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }

    
    // MARK: stop Recording Button Functions
    @IBAction func stopRecording(_ sender: Any) {
        buttonset (lableText : "Tap to Record" , stopRec: false , reco: true)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: audio Recorder Did Finish Recording Functions
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
           performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
        print ("Recording was not successful")
    }
}
    // MARK: segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

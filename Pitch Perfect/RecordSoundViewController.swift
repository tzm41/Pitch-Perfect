//
//  RecordSoundViewController.swift
//  Pitch Perfect
//
//  Created by Colin Tan on 6/18/15.
//  Copyright © 2015 Colin Tan. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var tapToRecordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.hidden = false
        tapToRecordLabel.hidden = true
        stopButton.hidden = false
        recordButton.enabled = false
        
        // setup record path
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recoringName = "audio.wav"
        let pathArray = [dirPath, recoringName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        // setup audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        // setup recorder settings
        let recorderSettings: [String: AnyObject] = [
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue,
            AVEncoderBitRateKey: 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ]
        
        // init recorder
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: recorderSettings)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            recordedAudio = RecordedAudio(filePathURL: recorder.url, title: recorder.url.lastPathComponent)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            print("Recording error")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundVC: PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            let audio = sender as! RecordedAudio
            playSoundVC.receivedAudio = audio
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.hidden = true
        tapToRecordLabel.hidden = false
        stopButton.hidden = true
        recordButton.enabled = true
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
}


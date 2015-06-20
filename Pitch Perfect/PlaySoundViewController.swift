//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Colin Tan on 6/19/15.
//  Copyright © 2015 Colin Tan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    var audioPlayer: AVAudioPlayer!
    var audioEngine: AVAudioEngine!
    
    var receivedAudio: RecordedAudio!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        try! audioFile = AVAudioFile(forReading: receivedAudio.filePathURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playSlow(sender: UIButton) {
        playAtRatePitch(0.6)
    }
    
    @IBAction func playFast(sender: UIButton) {
        playAtRatePitch(1.4)
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        playAtRatePitch(pitch: 1000)
    }
    
    @IBAction func playDart(sender: UIButton) {
        playAtRatePitch(pitch: -1000)
    }

    @IBAction func stopPlay(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
    }
    
    func playAtRatePitch(rate: Float = 1.0, pitch: Float = 1.0) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changeTimePitch = AVAudioUnitTimePitch()
        changeTimePitch.pitch = pitch
        changeTimePitch.rate = rate
        audioEngine.attachNode(changeTimePitch)
        
        audioEngine.connect(audioPlayerNode, to: changeTimePitch, format: nil)
        audioEngine.connect(changeTimePitch, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
            try audioEngine.start()
        } catch let error as NSError {
            print(error.description)
        }
        audioPlayerNode.play()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
}

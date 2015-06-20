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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let quoteSound = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            try! audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: quoteSound))
            audioPlayer.enableRate = true
        } else {
            print("File path is empty")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.6
        audioPlayer.play()
    }
    
    @IBAction func playFast(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.4
        audioPlayer.play()
    }

    @IBAction func stopPlay(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Colin Tan on 6/18/15.
//  Copyright © 2015 Colin Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        
        recordButton.enabled = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.hidden = false
        stopButton.hidden = false
        
        recordButton.enabled = false
        // TODO: Record the user's voice
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.hidden = true
        stopButton.hidden = true
        
        recordButton.enabled = true
    }
}


//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Solomon Rajkumar on 27/03/17.
//  Copyright © 2017 Solomon Rajkumar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let audioFilePath = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let soundURL = URL(fileURLWithPath: audioFilePath!)
        
        do {
            
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let error as NSError {
            
            print(error.debugDescription)
            
        }
        
    }
    
    func playSound() {
        
        if btnSound.isPlaying {
            
            btnSound.stop()
            
        } else {
            
            btnSound.play()
            
        }
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        
        playSound()
        
    }


}


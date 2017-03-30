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
    
    var numberBeingEntered = ""
    
    var calculatorStack = ["", ""]
    
    var result = 0

    @IBOutlet weak var outputLabel: UILabel!
    
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
    
    
    
    @IBAction func equalsButtonPressed(_ sender: Any) {
        
        playSound()
        
        result = Int(calculatorStack[0])! + Int(numberBeingEntered)!
        
        print(result)
        
        outputLabel.text = "\(result)"
        calculatorStack[0] = "\(result)"
        calculatorStack[1] = ""
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        playSound()
        
        if (calculatorStack[0] == "") {
            
            calculatorStack[0] = numberBeingEntered
            
        }
        
        
        if (calculatorStack[1] == "") {

            calculatorStack[1] = "+"
            
        } else {
            
            calculatorStack[0] = "\(Int(calculatorStack[0])! + Int(numberBeingEntered)!)"
            outputLabel.text = calculatorStack[0]
            
        }
        
        numberBeingEntered = ""
        
    }
    
    
    @IBAction func numberPressed(sender: UIButton) {
        
        playSound()
        
        numberBeingEntered += "\(sender.tag)"
        
        outputLabel.text = numberBeingEntered
        
    }


}


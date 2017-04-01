//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Solomon Rajkumar on 27/03/17.
//  Copyright © 2017 Solomon Rajkumar. All rights reserved.
//

import UIKit
import AVFoundation

class CalculatorViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    
    var numberBeingEntered = ""
    
    let blankString = ""
    
    var operationsStack = [String]()
    
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
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        playSound()
        
        operatorPressed(mathSymbol: "+")

        
    }
    

    @IBAction func subtractButtonPressed(_ sender: Any) {
        
        playSound()
        
        operatorPressed(mathSymbol: "-")

        
    }
    
    
    @IBAction func multiplyButtonPressed(_ sender: Any) {
        
        playSound()
        
        operatorPressed(mathSymbol: "*")
        
    }
    
    @IBAction func divideButtonPressed(_ sender: Any) {
        
        playSound()
        
        operatorPressed(mathSymbol: "/")
        
    }
    
    
    func performOperation(operation: String, number1: Int, number2: Int) -> Int{
        
        switch operation {
            
            case "+":
                return number1 + number2
            
            case "-":
                return number1 - number2
            
            case "*":
                return number1 * number2
            
            case "/":
                return number1 / number2
            
            default:
                return 0
            
        }
        
    }
    
    func operatorPressed(mathSymbol: String) {
        
        
        if checkForEmptyOperationsStack() && numberBeingEntered != blankString{
            
            pushOperationsIntoStack(operation: numberBeingEntered)
            pushOperationsIntoStack(operation: mathSymbol)
            numberBeingEntered = blankString
            
            print(operationsStack)
            
        } else if !checkForEmptyOperationsStack() && numberBeingEntered != blankString{
            
            
            // add numberBeingEntered and operationsStack[0]
            let operation = popOperationsFromStack(index: 1)
            let operand = popOperationsFromStack(index: 0)
            
            let result = performOperation(operation: operation, number1: Int(operand)!, number2: Int(numberBeingEntered)!)
            
            pushOperationsIntoStack(operation: "\(result)")
            pushOperationsIntoStack(operation: mathSymbol)
            numberBeingEntered = blankString
            
            
            outputLabel.text = "\(result)"
            
            
        }

        
    }
    
    
    
    @IBAction func numberPressed(sender: UIButton) {
        
        playSound()
        
        numberBeingEntered += "\(sender.tag)"
        
        outputLabel.text = numberBeingEntered
        
    }
    
    func checkForEmptyOperationsStack() -> Bool {
        
        if operationsStack.isEmpty {
            
            return true
            
        }
        
        return false
        
        
    }
    
    func pushOperationsIntoStack(operation: String)  {
        
        operationsStack.append(operation)
        
    }
    
    func popOperationsFromStack(index: Int) -> String {
        
       return operationsStack.remove(at: index)
        
        
    }


}


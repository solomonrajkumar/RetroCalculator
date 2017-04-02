//
//  CalculatorViewController.swift
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
    var operationsStack = [String]()
    var result = 0
    
    // constants
    let blankString = ""
    let equalsSymbol = "="
    let addSymbol = "+"
    let subtractSymbol = "-"
    let multiplySymbol = "*"
    let divideSymbol = "/"


    @IBOutlet weak var outputLabel: UILabel!
    
    // To disable landscape mode
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Audio file to be played when button is pressed
        let audioFilePath = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let soundURL = URL(fileURLWithPath: audioFilePath!)
        
        do {
            
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let error as NSError {
            
            print(error.debugDescription)
            
        }
        
    }
    
    // function to play sound
    func playSound() {
        
        if btnSound.isPlaying {
            
            btnSound.stop()
            
        } else {
            
            btnSound.play()
            
        }
        
    }
    
    
    // function called when equals button is pressed
    @IBAction func equalsButtonPressed(_ sender: Any) {
        
        playSound()
        
        operatorPressed(mathSymbol: equalsSymbol)
        
        
    }
    
    // function called when add button is pressed
    @IBAction func addButtonPressed(_ sender: Any) {
        
        playSound()
        
        operatorPressed(mathSymbol: addSymbol)

        
    }
    

    // function called when subtract button is pressed
    @IBAction func subtractButtonPressed(_ sender: Any) {
        
        playSound()
        
        operatorPressed(mathSymbol: subtractSymbol)

        
    }
    
    // function called when multiply button is pressed
    @IBAction func multiplyButtonPressed(_ sender: Any) {
        
        playSound()
        
        operatorPressed(mathSymbol: multiplySymbol)
        
    }
    
    // function called when divide button is pressed
    @IBAction func divideButtonPressed(_ sender: Any) {
        
        playSound()
        
        operatorPressed(mathSymbol: divideSymbol)
        
    }
    
    
    // perform the required math operation
    func performOperation(operation: String, number1: Int, number2: Int) -> Int{
        
        switch operation {
            
            case addSymbol:
                return number1 + number2
            
            case subtractSymbol:
                return number1 - number2
            
            case multiplySymbol:
                return number1 * number2
            
            case divideSymbol:
                // to handle divide by zero scenario
                if number2 == 0 {
                    return 0
                } else {
                    return number1 / number2
                }
            default:
                return 0
            
        }
        
    }
    
    
    func operatorPressed(mathSymbol: String) {
        
        // first time when number is entered and operator is pressed
        if checkForEmptyOperationsStack() && numberBeingEntered != blankString && mathSymbol != equalsSymbol{
            
            performPushOperationOntoStack(operand: numberBeingEntered, mathSymbol: mathSymbol)
            
        }
        // operand and/or operator is already present in stack
        else if !checkForEmptyOperationsStack() && numberBeingEntered != blankString{
            
            // if operator and operand are present in stack
            if operationsStack.count == 2 {
                
                // get operand and operator
                let operation = popOperationsFromStack(index: 1)
                let operand = popOperationsFromStack(index: 0)
            
                // perform the required operation based on the number being entered
                let result = performOperation(operation: operation, number1: Int(operand)!, number2: Int(numberBeingEntered)!)
                
                // if equals button is not pressed, add the result of the operation and the current operator
                if mathSymbol != equalsSymbol {
                
                    performPushOperationOntoStack(operand: "\(result)", mathSymbol: mathSymbol)
                
                }
                // if equals is pressed, push only the result onto the stack
                else {
                
                    performPushOperationOntoStack(operation: "\(result)")
                
                }
            
                outputLabel.text = "\(result)"
                
            }
            // only operand is presen t in stack
            else {
                
                _ = popOperationsFromStack(index: 0)
                performPushOperationOntoStack(operand: numberBeingEntered, mathSymbol: mathSymbol)
                
            }
            
        }
        // if any other operator is pressd, push onto the stack
        else if !checkForEmptyOperationsStack() && numberBeingEntered == blankString{
            
            performPushOperationOntoStack(operation: mathSymbol)
            
        }

        
    }
    
    // push operand and operator onto stack
    func performPushOperationOntoStack(operand: String, mathSymbol: String) {
        
        pushOperationsIntoStack(operation: operand)
        pushOperationsIntoStack(operation: mathSymbol)
        numberBeingEntered = blankString
        
    }
    
    // push operation onto Stack
    func performPushOperationOntoStack(operation: String) {
        
        pushOperationsIntoStack(operation: operation)
        numberBeingEntered = blankString
        
    }
    
    
    // function to call when number is pressed
    @IBAction func numberPressed(sender: UIButton) {
        
        playSound()
        
        numberBeingEntered += "\(sender.tag)"
        
        outputLabel.text = numberBeingEntered
        
    }
    
    // check whether stack is empty
    func checkForEmptyOperationsStack() -> Bool {
        
        if operationsStack.isEmpty {
            
            return true
            
        }
        
        return false
        
        
    }
    
    // push operand/operator onto stack
    func pushOperationsIntoStack(operation: String)  {
        
        operationsStack.append(operation)
        
    }
    
    // pop operand/operator from stack
    func popOperationsFromStack(index: Int) -> String {
        
       return operationsStack.remove(at: index)
        
        
    }


}


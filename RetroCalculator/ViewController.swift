//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Ibrahim Mbaziira on 3/17/17.
//  Copyright © 2017 Ibrahim Mbaziira. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!

    @IBOutlet weak var OutputLabel: UILabel!

    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var RunningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        OutputLabel.text = "0"
    }
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        
        RunningNumber += "\(sender.tag)"
        OutputLabel.text = RunningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject){
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject){
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender:AnyObject){
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    @IBAction func onClearPressed(sender: AnyObject){
        playSound()
         currentOperation = Operation.Empty
         RunningNumber = "0"
         leftValStr = "0"
         rightValStr = "0"
         result = "0"
        OutputLabel.text = "0"
    }
    
    func processOperation(operation: Operation){
        if currentOperation != Operation.Empty{
            //A user selected an operator, but then selected another operator without entering a number
            if RunningNumber != ""{
                rightValStr = RunningNumber
                RunningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                OutputLabel.text = result
            }
            currentOperation = operation
        } else {
            //this is the first time an operator has been pressed
            leftValStr = RunningNumber
            RunningNumber = ""
            currentOperation = operation
        }
    }
}


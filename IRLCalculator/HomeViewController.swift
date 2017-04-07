//
//  ViewController.swift
//  IRLCalculator
//
//  Created by Alvin  Andino  on 7/17/16.
//  Copyright © 2016 Alvin  Andino . All rights reserved.
//


import UIKit

class HomeViewController: UIViewController {
  var numBuffer = ""
  var numOpenParen = 0
  var decimalInNum = false
  var doesnumhavesign = false
  var userIsInTheMiddleOFTyping = false
  private var calcModel = CalculatorModel()
  
  
  let digitSet = CharacterSet.decimalDigits
  
  var hasText: Bool {
    return !Display.text.isEmpty
  }
		
  var lastcharNum: Bool {
    
    return hasText ? digitSet.contains(Display.text.unicodeScalars.last!) : false
    
  }
  
  var lastcharopenParen: Bool {
    return hasText ? Display.text.characters.last == "(" : false
    
  }
  
  var lastcharocloseParen: Bool {
    return hasText ? Display.text.characters.last == ")" : false
    
  }
  
  var lastcharoperator: Bool {
    //change
    return hasText ? ["+", "-", "/", "*"].contains(String(describing: Display.text.characters.last!)) : false
  }
  
  var displayValue: Double {
    get {
      return Double(numBuffer)!
    }
    set {
      numBuffer = String(newValue)
    }
  }
		
  
  

  @IBOutlet weak var Display: UITextView!
  @IBOutlet weak var ResultText: UILabel!
  @IBOutlet weak var DeleteButton: UIButton!
    
  @IBAction func Evaluate() {
    //let mathExpression = NSExpression(format: Display.text)
    //let mathValue = mathExpression.expressionValue(with: nil, context: nil) as! Float
    ResultText.text = String(describing: mathValue)
  }
  @IBAction func Clear() {
    //Display.text.removeAll()
    ResultText.text?.removeAll()
    numBuffer.removeAll()
    DeleteButton.isEnabled = false
    decimalInNum = false
  }
  @IBAction func Delete() {
    let char = Display.text.characters.removeLast()
    numBuffer.characters.removeLast()
    if char == "." {
      decimalInNum = false
    }
    if !hasText {
      DeleteButton.isEnabled = false
    }
  }

  @IBAction func toggleSign() { //working
    if !hasText {
      Display.text.append("(-")
      numBuffer.append("(-")
      
    }
    
  }
  
  @IBAction func appendDecimal(_ sender: UIButton) {
    if !hasText || lastcharopenParen || lastcharoperator {
      Display.text.append("0.")
      decimalInNum = true
      DeleteButton.isEnabled = true
    } else if lastcharocloseParen {
      Display.text.append("*0.")
      decimalInNum = true
      DeleteButton.isEnabled = true
    } else if lastcharNum && !decimalInNum {
      Display.text.append(".")
      numBuffer.append(".")
      decimalInNum = true
      DeleteButton.isEnabled = true
      
    }
  }
  
  @IBAction func appendParen(_ sender: UIButton) {
    //dont append on decimal
    if hasText && (lastcharNum || lastcharocloseParen) {
      if numOpenParen > 0 {
        Display.text.append(")")
        numOpenParen -= 1
      } else {
       Display.text.append("*(")
        numOpenParen += 1
      }
    } else {
      Display.text.append("(")
      numOpenParen += 1
    }
    decimalInNum = false
    DeleteButton.isEnabled = true
    numBuffer.removeAll()
  }
  
  @IBAction func appendNumber(_ sender: UIButton) {
    let numString = sender.currentTitle!
    if userIsInTheMiddleOFTyping {
      Display.text.append(numString)
      numBuffer.append(numString)
    } else {
      Display.text = numString
      numBuffer = numString
      userIsInTheMiddleOFTyping = true
    }
    DeleteButton.isEnabled = true
    
  }
  @IBAction func appendOperator(_ sender: UIButton) {
    if userIsInTheMiddleOFTyping {
      calcModel.setOperand(displayValue)
      userIsInTheMiddleOFTyping = false
    }
    
    let operatorString = sender.currentTitle!
    calcModel.performOperation(operatorString)
    if let result = calcModel.result {
      displayValue = result
    }
    
  }
  
    override func viewDidLoad() {
      super.viewDidLoad()
      Display.text.removeAll()
      ResultText.text?.removeAll()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


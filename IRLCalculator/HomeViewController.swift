//
//  ViewController.swift
//  IRLCalculator
//
//  Created by Alvin  Andino  on 7/17/16.
//  Copyright © 2016 Alvin  Andino . All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  var result = 0
  var stack = [String]()
  var numOpenParen = 0
  let digitSet = CharacterSet.decimalDigits
  
  var hasText: Bool {
    get {
      return !Display.text.isEmpty
    }
  }
		
  var lastcharNum: Bool {
    get {
      return hasText ? digitSet.contains(Display.text.unicodeScalars.last!) : false
    }
  }
  
  var lastcharopenParen: Bool {
    get {
      return hasText ? Display.text.characters.last == "(" : false
    }
  }
  
  var lastcharocloseParen: Bool {
    get {
      return hasText ? Display.text.characters.last == ")" : false
    }
  }
  
  

  @IBOutlet weak var Display: UITextView!
  @IBOutlet weak var ResultText: UILabel!
  @IBOutlet weak var DeleteButton: UIButton!
    
  @IBAction func Evaluate() {
    let mathExpression = NSExpression(format: Display.text)
    let mathValue = mathExpression.expressionValue(with: nil, context: nil) as! Float
    ResultText.text = String(describing: mathValue)
  }
  @IBAction func Clear() {
    Display.text.removeAll()
    ResultText.text?.removeAll()
    DeleteButton.isEnabled = false
  }
  @IBAction func Delete() {
    Display.text.characters.removeLast(1)
    if !hasText {
      DeleteButton.isEnabled = false
    }
  }

  @IBAction func toggleSign() {
    
  }
  
  @IBAction func appendParen(_ sender: UIButton) {
    
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
  }
  
  @IBAction func appendNumber(_ sender: UIButton) {
    let numString = sender.currentTitle!
    Display.text.append(numString)
    DeleteButton.isEnabled = true
    
  }
  @IBAction func appendOperator(_ sender: UIButton) {
    let numString = sender.currentTitle!
    
    if hasText && (lastcharNum || lastcharocloseParen) {
      Display.text.append(numString)
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


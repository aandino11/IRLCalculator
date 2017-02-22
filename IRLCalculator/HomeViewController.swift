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
    if Display.text.isEmpty {
      DeleteButton.isEnabled = false
    }
  }

  @IBAction func toggleSign() {
    
  }
  
  @IBAction func appendNumber(_ sender: UIButton) {
    let numString = sender.currentTitle!
    Display.text.append(numString)
    DeleteButton.isEnabled = true
    
  }
  @IBAction func appendOperator(_ sender: UIButton) {
    let numString = sender.currentTitle!
    let digitSet = CharacterSet.decimalDigits
    
    if digitSet.contains(Display.text.unicodeScalars.last!) {
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


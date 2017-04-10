//
//  ViewController.swift
//  IRLCalculator
//
//  Created by Alvin  Andino  on 7/17/16.
//  Copyright © 2016 Alvin  Andino . All rights reserved.
//


import UIKit

class HomeViewController: UIViewController {
  private var calcModel = CalculatorModel() {
    didSet {
      updateUI()
    }
  }
  
  private var operations: Dictionary<String,OperatorType> = [
    "√" : .sqrt,
    "cos" : .cos,
    "*" : .multiply,
    "-" : .subtract,
    "+" : .add,
    "/" : .divide
    //"=" : .equals
  ]
  
  private var constants: Dictionary<String,Double> = [
    "π" : Double.pi,
    "e" : M_E
  ]
  
  var displayValue: Double {
    get {
      return Double(ResultText.text ?? "0")!
    }
    set {
      ResultText.text = String(newValue)
    }
  }
  
  private func updateUI() {
    Display.text = calcModel.expression
    let hasText = !Display.text.isEmpty
    DeleteButton.isEnabled = hasText
    print(hasText)
    
    if let result = calcModel.result {
      print(result)
      displayValue = result
    }
  }
		
  @IBOutlet weak var Display: UITextView!
  @IBOutlet weak var ResultText: UILabel!
  @IBOutlet weak var DeleteButton: UIButton!
  
  @IBAction func Evaluate() {
    
  }
  @IBAction func Clear() {
    //calcModel.clear()
  }
  @IBAction func Delete() {
    //calcModel.delete()
  }

  @IBAction func toggleSign() { //working
    //calcModel.toggleSign()
  }
  
  @IBAction func appendDecimal(_ sender: UIButton) {
    //calcModel.addDecimal()
  }
  
  @IBAction func appendParen(_ sender: UIButton) {
    calcModel.addAutoBracket()
  }
  
  @IBAction func appendNumber(_ sender: UIButton) {
    let numString = sender.currentTitle!
    calcModel.appendToOperand(Int(numString)!)
  }
  
  @IBAction func appendOperator(_ sender: UIButton) {
    let operatorString = sender.currentTitle!
    let operation = operations[operatorString]!
    calcModel.addOperator(operation)
  }
  
    override func viewDidLoad() {
      super.viewDidLoad()
      Display.text.removeAll()
      ResultText.text?.removeAll()
        // Do any additional setup after loading the view, typically from a nib.
    }
}


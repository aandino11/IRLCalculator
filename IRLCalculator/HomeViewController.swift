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
    
  @IBAction func Clear() {
    Display.text.removeAll()
    ResultText.text?.removeAll()
  }
  @IBAction func Delete() {
    Display.text.characters.removeLast(1)
    ResultText.text?.characters.removeLast(1)
  }

  @IBAction func toggleSign() {
    
  }
  
  @IBAction func appendNumber(_ sender: UIButton) {
    let numString = sender.currentTitle!
    Display.text.append(numString)
    
    ResultText.text?.append(numString)
  }
  @IBAction func appendOperator(_ sender: UIButton) {
    
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


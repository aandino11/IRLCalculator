//
//  CalculatorModel.swift
//  IRLCalculator
//
//  Created by Alvin  Andino  on 4/1/17.
//  Copyright © 2017 Alvin  Andino . All rights reserved.
//

import Foundation

struct CalculatorModel {
  private enum State {
    case editingOperand(operand: Double)
    case notEditingOperand
    
    mutating func updateOperand(newValue: Double) {
      self = .editingOperand(operand: newValue)
    }
  }
  
  private var state: State = .notEditingOperand
  
  private var tokenExpression = [CalculatorToken]()
  
  var numOpenParen = 0
  
  public var result: Double? {
    if canHaveValidResult {
      let mathExpression = NSExpression(format: expression)
      let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double
      return mathValue
    } else {
      return nil
    }
    
  }
  
  public var expression: String {
    var toString = "" // does this need to be initialized?
    for token in tokenExpression {
      toString += token.description
    }
    return toString
  }
  
  private mutating func addToken(_ calculatorToken: CalculatorToken) {
    tokenExpression.append(calculatorToken)
  }
  
  public mutating func addOperator(_ operatorType: OperatorType) {
    if haveTokens && (lastTokenIsNum || lastTokenIsCloseParen) {
      addToken(CalculatorToken(operatorType: operatorType))
      numOpenParen += operatorType.bracketValue
      state = .notEditingOperand
      
    }
  }
  
  public mutating func addOperand(_ operand: Double) {
    if lastTokenIsCloseParen {
      addOperator(.multiply)
    }
    addToken(CalculatorToken(operand: operand))
    state = .editingOperand(operand: operand)
  }
  
  public mutating func appendToOperand(_ operand: Int) {
    if operand < 10 {
      switch state {
      case .notEditingOperand:
        addOperand(Double(operand))
      case .editingOperand(let oldValue):
        let newValue = oldValue*10 + Double(operand)
        state.updateOperand(newValue: newValue)
        lastToken = CalculatorToken(operand: newValue)
      }
    }
  }
  /*
  public func addDecimal() {
    /*
    if !haveTokens || lastTokenIsOpenParen || lastcharoperator {
      Display.text.append("0.")
      decimalInNum = true
      DeleteButton.isEnabled = true
    } else if lastTokenIsCloseParen {
      Display.text.append("*0.")
      decimalInNum = true
      DeleteButton.isEnabled = true
    } else if lastTokenIsNum && !decimalInNum {
      Display.text.append(".")
      numBuffer.append(".")
      decimalInNum = true
      DeleteButton.isEnabled = true
    }
     */
  }
  
  public func toggleSign() {
    /*
    if !haveTokens {
      Display.text.append("(-")
      numBuffer.append("(-")
    }
     */
    
  }
 */
  
  public mutating func addAutoBracket() {
    //dont append on decimal
    if haveTokens && !lastTokenIsOpenParen { //or last char a decimal
      if lastTokenIsNum || lastTokenIsCloseParen {
        if numOpenParen > 0 {
          addCloseBracket()
        } else {
          addOperator(.multiply)
          addOpenBracket()
      }
    } else {
      addOpenBracket()
    }
    state = .notEditingOperand
    } else if !haveTokens {
      addOpenBracket()
    }
  }
  
  private mutating func addOpenBracket() {
    addToken(CalculatorToken(tokenType: .openBracket))
    numOpenParen += 1
  }
  
  private mutating func addCloseBracket() {
    addToken(CalculatorToken(tokenType: .closeBracket))
    numOpenParen -= 1
  }
  
  public mutating func clear() {
    tokenExpression.removeAll()
    state = .notEditingOperand
  }
  /*
  public func delete() {
    /*
     let char = Display.text.characters.removeLast()
     numBuffer.characters.removeLast()
     if char == "." {
     decimalInNum = false
     }
     if !hasText {
     DeleteButton.isEnabled = false
     }
     */
  }
  
  private struct currentOperand: CustomStringConvertible {
    var decimalInNum = false
    var doesnumhavesign = false
    
    public var description: String {
      
      return ""
    }
  }
 */
  // helper computed values
  private var haveTokens: Bool {
    return !tokenExpression.isEmpty
  }
  
  private var lastToken: CalculatorToken? {
    get {
      return tokenExpression.last
    }
    
    set {
      tokenExpression.removeLast()
      tokenExpression.append(newValue!) //check
    }
    
  }
		
  private var lastTokenIsNum: Bool {
    return haveTokens && (lastToken!.isOperand || lastToken!.isConstant)
  }
  
  private var lastTokenIsOpenParen: Bool {
    return haveTokens && lastToken!.isOpenBracket
  }
  
  private var lastTokenIsCloseParen: Bool {
    return haveTokens && lastToken!.isCloseBracket
  }
  
  private var lastcharoperator: Bool {
    return haveTokens && lastToken!.isOperator
  }
  
  private var canHaveValidResult: Bool {
    return haveTokens && !(lastToken!.isOperator) && numOpenParen == 0
  }
		
}

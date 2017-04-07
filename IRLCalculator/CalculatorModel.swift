//
//  CalculatorModel.swift
//  IRLCalculator
//
//  Created by Alvin  Andino  on 4/1/17.
//  Copyright © 2017 Alvin  Andino . All rights reserved.
//

import Foundation

struct CalculatorModel {
  
  private var currentOperand: Double?
  private var expression = [CalculatorToken]()
  
  private enum Operation {
    case constant(Double)
    case unary((Double) -> Double)
    case binary((Double, Double) -> Double)
    case equals
  }
  
  private var operations: Dictionary<String,Operation> = [
    "π" : .constant(Double.pi),
    "e" : .constant(M_E),
    "√" : .unary(sqrt),
    "cos" : .unary(cos),
    "x" : .binary(*),
    "=" : .equals
  ]
  
  public func addOperator(_ operatorType: OperatorType) {
    if hasText && (lastcharNum || lastcharocloseParen) {
      
      Display.text.append(operatorString)
      decimalInNum = false
      numBuffer.removeAll()
    }

    expression.append(Token(operatorType: operatorType))
  }
  
  public func addOperand(_ operand: Double) {
    expression.append(Token(operand: operand))
  }
  
  public func addOpenBracket() {
    expression.append(Token(tokenType: .openBracket))
  }
  
  public func addCloseBracket() {
    expression.append(Token(tokenType: .closeBracket))
  }
  
  
  mutating func appendToOperand(_ operand: Double) { // append onto operand?
    currentOperand = operand //fix
  }
  
  public var result: Double? {
    return currentOperand //return math experssion
  }
  
  public var expresion: String {
    return "" //string form
  }
		
}

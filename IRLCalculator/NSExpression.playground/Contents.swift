//: Playground - noun: a place where people can play

import UIKit

extension NSNumber {
  func factorial() -> NSNumber {
    return tgamma(self.doubleValue + 1) as NSNumber
  }
  
  func myCustomFunction(x: NSNumber) -> NSNumber {
    return (self.doubleValue) as NSNumber
  }
  
  func cosine() -> NSNumber {
    return  cos(self.doubleValue) as NSNumber
  }
  
}

var mathExpression = NSExpression(format: "3*FUNCTION(0,'cosine')*5.2")
//mathExpression = NSExpression(forFunction: "3", selectorName: "cosine")
let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double

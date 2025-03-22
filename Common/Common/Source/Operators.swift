//
//  Operators.swift
//  Common
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

precedencegroup FunctionApplicationPrecedence {
  associativity: left
  higherThan: BitwiseShiftPrecedence
}

infix operator &>: FunctionApplicationPrecedence

@discardableResult
public func &> <Input>(value: Input, function: (inout Input) throws -> Void) rethrows -> Input {
  var mValue = value
  try function(&mValue)
  return mValue
}

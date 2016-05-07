/*
   Copyright 2016 Ryuichi Saito, LLC

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import XCTest

@testable import parser
@testable import ast

class ParsingSubscriptExpressionTests: XCTestCase {
  let parser = Parser()

  func testParseSubscriptExpression() {
    parser.setupTestCode("foo[0]")
    guard let subscriptExpr = try? parser.parseSubscriptExpression() else {
      XCTFail("Failed in getting a subscript expression.")
      return
    }
    guard let idExpr = subscriptExpr.postfixExpression as? IdentifierExpression else {
      XCTFail("Failed in getting an identifier expression.")
      return
    }
    XCTAssertEqual(idExpr.identifier, "foo")
    XCTAssertEqual(subscriptExpr.indexExpressions.count, 1)
  }

  func testParseSubscriptExpressionWithExpressionList() {
    parser.setupTestCode("foo[0, 1, 5]")
    guard let subscriptExpr = try? parser.parseSubscriptExpression() else {
      XCTFail("Failed in getting a subscript expression.")
      return
    }
    guard let idExpr = subscriptExpr.postfixExpression as? IdentifierExpression else {
      XCTFail("Failed in getting an identifier expression.")
      return
    }
    XCTAssertEqual(idExpr.identifier, "foo")
    XCTAssertEqual(subscriptExpr.indexExpressions.count, 3)
  }

  func testParseSubscriptExpressionWithMultipleListThasHasVariables() {
    parser.setupTestCode("foo [ a, 0, b, 1, 5 ] ")
    guard let subscriptExpr = try? parser.parseSubscriptExpression() else {
      XCTFail("Failed in getting a subscript expression.")
      return
    }
    guard let idExpr = subscriptExpr.postfixExpression as? IdentifierExpression else {
      XCTFail("Failed in getting an identifier expression.")
      return
    }
    XCTAssertEqual(idExpr.identifier, "foo")
    XCTAssertEqual(subscriptExpr.indexExpressions.count, 5)
  }
}

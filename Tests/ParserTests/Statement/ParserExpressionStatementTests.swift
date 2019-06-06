/*
   Copyright 2016 Ryuichi Intellectual Property and the Yanagiba project contributors

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

@testable import AST
@testable import Parser

class ParserExpressionStatementTests: XCTestCase {
  func testAssignmentOpExprStmt() {
    parseStatementAndTest(
      "(a, _, (b, c)) = (\"test\", 9.45, (12, 3))",
      "(a, _, (b, c)) = (\"test\", 9.45, (12, 3))",
      testClosure: { stmt in
        XCTAssertTrue(stmt is Expression)
        XCTAssertTrue(stmt is AssignmentOperatorExpression)
      }
    )
  }

  func testExpressions() {
    let stmtParser = getParser("a = 1 ; b = 2 \n a>b ? a+1:b;foo()")
    do {
      let stmts = try stmtParser.parseStatements()
      XCTAssertEqual(stmts.count, 4)
      XCTAssertEqual(stmts.textDescription, """
      a = 1
      b = 2
      a > b ? a + 1 : b
      foo()
      """)
      XCTAssertTrue(stmts[0] is AssignmentOperatorExpression)
      XCTAssertTrue(stmts[1] is AssignmentOperatorExpression)
      XCTAssertTrue(stmts[2] is SequenceExpression)
      XCTAssertTrue(stmts[3] is FunctionCallExpression)
    } catch {
      XCTFail("Failed in parsing a list of expressions as statements.")
    }
  }

  static var allTests = [
    ("testAssignmentOpExprStmt", testAssignmentOpExprStmt),
    ("testExpressions", testExpressions),
  ]
}

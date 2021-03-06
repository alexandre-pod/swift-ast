/*
   Copyright 2016-2017, 2019 Ryuichi Intellectual Property
                             and the Yanagiba project contributors

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

public class IdentifierExpression : ASTNode, PrimaryExpression {
  public enum Kind {
    case identifier(Identifier, GenericArgumentClause?)
    case implicitParameterName(Int, GenericArgumentClause?)
    case bindingReference(String)
  }

  public let kind: Kind

  public init(kind: Kind) {
    self.kind = kind
  }

  // MARK: - ASTTextRepresentable

  override public var textDescription: String {
    switch kind {
    case let .identifier(id, generic):
      return "\(id)\(generic?.textDescription ?? "")"
    case let .implicitParameterName(i, generic):
      return "$\(i)\(generic?.textDescription ?? "")"
    case let .bindingReference(refVar):
      return "$\(refVar)"
    }
  }
}

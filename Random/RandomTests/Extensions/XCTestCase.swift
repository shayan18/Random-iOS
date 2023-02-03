import SwiftUI
import SnapshotTesting
import XCTest

extension XCTestCase {
  func assertScreenshot<Value: View>(
    variant: String,
    view: @autoclosure () throws -> Value,
    width: CGFloat,
    height: CGFloat,
    record recording: Bool = false,
    timeout: TimeInterval = 5,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
  ) {
    for userInterfaceStyle in UIUserInterfaceStyle.allCases {
      assertSnapshot(
        matching: try view().frame(width: width, height: height).padding(),
        as: .image(
          precision: 1,
          layout: .sizeThatFits,
          traits: .init(userInterfaceStyle: userInterfaceStyle)
        ),
        named: "\(variant)-\(userInterfaceStyle.rawValue.capitalized)",
        record: recording,
        timeout: timeout,
        file: file,
        testName: String(testName.dropFirst(4)),
        line: line
      )
    }
  }
}

extension UIUserInterfaceStyle: CaseIterable {
  public static var allCases: [UIUserInterfaceStyle] = [.light, .dark]

  var rawValue: String {
    switch self {
    case .light:
      return "light"

    case .dark:
      return "dark"

    default:
      return "???"
    }
  }
}

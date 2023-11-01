import EGTest
@testable import kaleid
import SwiftUI
import XCTest

@MainActor
final class ToPositiveRadiansTests: XCTestCase {
  private let fuzz = 0.00001

  func test_ToPositiveRadians() {
    let pi = Double.pi
    check(
      EG(2 * pi + pi / 2, expect: pi / 2, "just above 2*pi wraps"),
      EG(6 * pi, expect: 0, "well above 2*pi wraps"),
      EG(-pi - pi / 2, expect: pi / 2, "negative value wraps"),
      EG(-3 * pi - pi / 2, expect: pi / 2, "more negative value wraps"),
      EG(-pi, expect: pi, "adds 2*pi to negative"),
      EG(-pi / 2, expect: 3 * pi / 2, "negative to positive")
    ) {
      let radians = Angle.radians($0.input).toPositiveRadians
      XCTAssertEqual(radians, $0.expect, accuracy: fuzz, file: $0.file, line: $0.line)
    }
  }
}

final class ToXOffsetTests: XCTestCase {
  private let fuzz = 0.00001

  func test_toXOffset() {
    check(
      EG(0.0, expect: 0.0, "0 radians maps to 0 x offset"),
      EG(.pi / 4.0, expect: 12.5, "pi/4 => quarter x"),
      EG(.pi / 2.0, expect: 25.0, "pi/2 => mid x"),
      EG(3.0 * .pi / 4.0, expect: 37.5, "3*pi/4 => 3/4 x"),
      EG(.pi, expect: 50.0, "pi => max x"),
      EG(5.0 * .pi / 4.0, expect: 37.5, "5*pi/4 => 3/4 x"),
      EG(3.0 * .pi / 2.0, expect: 25.0, "3*pi/2 => 1/2 x"),
      EG(7.0 * .pi / 4.0, expect: 12.5, "7*pi/4 => 1/4 x")
    ) {
      let x = Angle.radians($0.input).toXOffset(CGSize(width: 100.0, height: 200.0))
      XCTAssertEqual(x, $0.expect, accuracy: fuzz, file: $0.file, line: $0.line)
    }
  }
}

@MainActor
final class ToYOffsetTests: XCTestCase {
  private let fuzz = 0.00001

  func test_toYOffset() {
    check(
      EG(0.0, expect: -25.0, "0 radians maps to neg middle of radius"),
      EG(.pi, expect: -25.0, "pi radians maps to neg middle of radius"),
      EG(-.pi, expect: -25.0, "-pi => neg mid x (yes, x)"),
      EG(.pi / 2.0, expect: 50.0, "pi/2 => Half height - radius"),
      EG(-.pi / 2.0, expect: -100.0, "-pi/2 => -1/2 height")
    ) {
      let y = Angle.radians($0.input).toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 1)
      XCTAssertEqual(y, $0.expect, accuracy: fuzz, file: $0.file, line: $0.line)
    }
  }

  func test_ZeroMapsToNegativeMiddleOfRadius_EvenWithRepeats() {
    let y = Angle.zero.toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 100)
    XCTAssertEqual(y, -25.0, accuracy: fuzz)
  }

  func test_Repeats() {
    let size = CGSize(width: 100.0, height: 200.0)
    let tenthOfCircle = 360 / 10

    let angle1 = Angle.degrees(18)
    let angle2 = Angle.degrees(Double(18 + tenthOfCircle))
    let angle3 = Angle.degrees(Double(18 + 2 * tenthOfCircle))

    let y1 = angle1.toYOffset(size, repeats: 10)
    let y2 = angle2.toYOffset(size, repeats: 10)
    let y3 = angle3.toYOffset(size, repeats: 10)

    XCTAssertEqual(y1, y2, accuracy: fuzz)
    XCTAssertEqual(y2, y3, accuracy: fuzz)
  }
}

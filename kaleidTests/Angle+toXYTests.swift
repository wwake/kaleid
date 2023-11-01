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
      XCTAssertEqual(radians, $0.expect, accuracy: fuzz)
    }
  }
}

final class toXTests: XCTestCase {
  private let fuzz = 0.00001

  func test_ZeroMapsToZero() {
    let x = Angle.zero.toXOffset(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 0.0, accuracy: fuzz)
  }

  func test_QuarterPiMapsToQuarterX() {
    let x = Angle.radians(.pi / 4).toXOffset(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 12.5, accuracy: fuzz)
  }

  func test_HalfPiMapsToMidX() {
    let x = Angle.radians(.pi / 2).toXOffset(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 25.0, accuracy: fuzz)
  }

  func test_ThreeQuarterPiMapsToThreeQuarterX() {
    let x = Angle.radians(3 * .pi / 4).toXOffset(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 37.5, accuracy: fuzz)
  }

  func test_PiMapsToMaxX() {
    let x = Angle.radians(.pi).toXOffset(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 50.0, accuracy: fuzz)
  }

  func test_FivePiOver4MapsToThreeQuarterX() throws {
    let x = Angle.radians(5 * .pi / 4).toXOffset(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 37.5, accuracy: fuzz)
  }

  func test_ThreePiOver2_MapsToMidX() {
    let x = Angle.radians(3 * .pi / 2).toXOffset(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 25.0, accuracy: fuzz)
  }

  func test_SevenPiOver4MapsToQuarterX() throws {
    let x = Angle.radians(7 * .pi / 4).toXOffset(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 12.5, accuracy: fuzz)
  }
}

@MainActor
final class toYTests: XCTestCase {
  private let fuzz = 0.00001

  func test_ZeroMapsToNegativeMiddleOfRadius() {
    let y = Angle.zero.toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, -25.0, accuracy: fuzz)
  }

  func test_ZeroMapsToNegativeMiddleOfRadius_EvenWithRepeats() {
    let y = Angle.zero.toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 100)
    XCTAssertEqual(y, -25.0, accuracy: fuzz)
  }

  func test_PiMapsToNegativeMiddleOfRadius() {
    let y = Angle.radians(.pi).toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, -25.0, accuracy: fuzz)
  }

  func test_NegPiMapsToMidX_YesX() {
    let y = Angle.radians(-.pi).toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, -25.0, accuracy: fuzz)
  }

  func test_HalfPiMapsToHalfHeightMinusRadius() {
    let y = Angle.radians(.pi / 2).toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, 50.0, accuracy: fuzz)
  }

  func test_NegHalfPiMapsToNegativeHalfHeight() {
    let y = Angle.radians(-.pi / 2).toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, -100.0, accuracy: fuzz)
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

@testable import kaleid
import SwiftUI
import XCTest

@MainActor
final class toXTests: XCTestCase {
  let fuzz = 0.00001

  func test_ZeroMapsToMidX() {
    let x = Angle.zero.toX(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 25.0, accuracy: fuzz)
  }

  func test_PiMapsToMaxX() {
    let x = Angle.radians(.pi).toX(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 50.0, accuracy: fuzz)
  }

  func test_HalfPiMapsToHalfMidToMaxX() {
    let x = Angle.radians(.pi / 2).toX(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 37.5, accuracy: fuzz)
  }

  func test_ValuesBelowNegPiWrapsAround() throws {
    let targetRadians = CGFloat.pi / 2
    let x = Angle.radians(-.pi - targetRadians).toX(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 37.5, accuracy: fuzz)
  }

  func test_ValuesWellBelowNegPiWrapAround() throws {
    let targetRadians = CGFloat.pi / 2
    let x = Angle.radians(-3 * .pi - targetRadians).toX(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 37.5, accuracy: fuzz)
  }

  func test_NegPiMapsToMinX() {
    let x = Angle.radians(-.pi).toX(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 0.0, accuracy: fuzz)
  }

  func test_NegHalfPiMapsToOneQuarterX() {
    let x = Angle.radians(-.pi / 2).toX(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 12.5, accuracy: fuzz)
  }

  func test_ValueJustAbovePiWrapsAround() {
    let x = Angle.radians(.pi + .pi / 2).toX(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 12.5, accuracy: fuzz)
  }

  func test_ValueWellAbovePiWrapsAround() {
    let x = Angle.radians(6 * .pi).toX(CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 25.0, accuracy: fuzz)
  }
}

@MainActor
final class toYTests: XCTestCase {
  let fuzz = 0.00001

  func test_ZeroMapsToMidX_YesX() {
    let y = Angle.zero.toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, 25.0, accuracy: fuzz)
  }

  func test_ZeroMapsToMidX_EvenWithRepeats() {
    let y = Angle.zero.toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 100)
    XCTAssertEqual(y, 25.0, accuracy: fuzz)
  }

  func test_PiMapsToMidX_YesX() {
    let y = Angle.radians(.pi).toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, 25.0, accuracy: fuzz)
  }

  func test_NegPiMapsToMidX_YesX() {
    let y = Angle.radians(-.pi).toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, 25.0, accuracy: fuzz)
  }

  func test_HalfPiMapsToMaxX_YesX() {
    let y = Angle.radians(.pi / 2).toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, 50.0, accuracy: fuzz)
  }

  func test_NegHalfPiMapsToMinX_YesX() {
    let y = Angle.radians(-.pi / 2).toYOffset(CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, 0.0, accuracy: fuzz)
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

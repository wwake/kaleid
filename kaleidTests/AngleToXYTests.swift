@testable import kaleid
import SwiftUI
import XCTest

@MainActor
final class AngleToXTests: XCTestCase {
  let fuzz = 0.00001

  func test_ZeroMapsToMidX() {
    let view = ContentView()
    let x = view.angleToX(.zero, CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 50.0, accuracy: fuzz)
  }

  func test_PiMapsToMaxX() {
    let view = ContentView()
    let x = view.angleToX(Angle.radians(.pi), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 100.0, accuracy: fuzz)
  }

  func test_HalfPiMapsToMidX() {
    let view = ContentView()
    let x = view.angleToX(Angle.radians(.pi / 2), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 75, accuracy: fuzz)
  }


  func test_ValuesBelowNegPiWrapsAround() throws {
    let view = ContentView()
    let targetRadians = CGFloat.pi / 2
    let x = view.angleToX(Angle.radians(-.pi - targetRadians), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 75, accuracy: fuzz)
  }

  func test_ValuesWellBelowNegPiWrapAround() throws {
    let view = ContentView()
    let targetRadians = CGFloat.pi / 2
    let x = view.angleToX(Angle.radians(-3 * .pi - targetRadians), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 75, accuracy: fuzz)
  }

  func test_NegPiMapsToMinX() {
    let view = ContentView()
    let x = view.angleToX(Angle.radians(-.pi), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 0, accuracy: fuzz)
  }

  func test_NegHalfPiMapsToOneQuarterX() {
    let view = ContentView()
    let x = view.angleToX(Angle.radians(-.pi / 2), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 25, accuracy: fuzz)
  }

  func test_ValueJustAbovePiWrapsAround() {
    let view = ContentView()
    let x = view.angleToX(Angle.radians(.pi + .pi / 2), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 25, accuracy: fuzz)
  }

  func test_ValueWellAbovePiWrapsAround() {
    let view = ContentView()
    let x = view.angleToX(Angle.radians(6 * .pi), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 50, accuracy: fuzz)
  }
}

@MainActor
final class AngleToYTests: XCTestCase {
  let fuzz = 0.00001

  func test_ZeroMapsToMidX_YesX() {
    let view = ContentView()
    let y = view.angleToY(.zero, CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, 50.0, accuracy: fuzz)
  }

  func test_ZeroMapsToMidX_EvenWithRepeats() {
    let view = ContentView()
    let y = view.angleToY(.zero, CGSize(width: 100.0, height: 200.0), repeats: 100)
    XCTAssertEqual(y, 50.0, accuracy: fuzz)
  }

  func test_PiMapsToMidX_YesX() {
    let view = ContentView()
    let y = view.angleToY(Angle.radians(.pi), CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, 50.0, accuracy: fuzz)
  }

  func test_NegPiMapsToMidX_YesX() {
    let view = ContentView()
    let y = view.angleToY(Angle.radians(-.pi), CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, 50.0, accuracy: fuzz)
  }

  func test_HalfPiMapsToMaxX_YesX() {
    let view = ContentView()
    let y = view.angleToY(Angle.radians(.pi / 2), CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, 100.0, accuracy: fuzz)
  }

  func test_NegHalfPiMapsToMinX_YesX() {
    let view = ContentView()
    let y = view.angleToY(Angle.radians(-.pi / 2), CGSize(width: 100.0, height: 200.0), repeats: 1)
    XCTAssertEqual(y, 0.0, accuracy: fuzz)
  }

  func test_Repeats() {

  }
}

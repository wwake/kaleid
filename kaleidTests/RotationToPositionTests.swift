@testable import kaleid
import SwiftUI
import XCTest

@MainActor
final class RotationToPositionTests: XCTestCase {
  func test_ZeroMapsToZeroX() {
    let view = ContentView()
    let x = view.angleToX(.zero, CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 50.0)
  }

  func test_PiMapsToMaxX() {
    let view = ContentView()
    let x = view.angleToX(Angle.radians(.pi), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 100.0)
  }

  func test_HalfPiMapsToMidX() {
    let view = ContentView()
    let x = view.angleToX(Angle.radians(.pi / 2), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 75)
  }


  func test_ValuesBelowNegPiWrapsAround() throws {
    let view = ContentView()
    let targetRadians = CGFloat.pi / 2
    let x = view.angleToX(Angle.radians(-.pi - targetRadians), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 75, accuracy: 0.00001)
  }

  func test_ValuesWellBelowNegPiWrapAround() throws {
    let view = ContentView()
    let targetRadians = CGFloat.pi / 2
    let x = view.angleToX(Angle.radians(-3 * .pi - targetRadians), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 75, accuracy: 0.00001)
  }

  func test_NegPiMapsToMinX() {
    let view = ContentView()
    let x = view.angleToX(Angle.radians(-.pi), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 0, accuracy: 0.00001)
  }

  func test_NegHalfPiMapsToOneQuarterX() {
    let view = ContentView()
    let x = view.angleToX(Angle.radians(-.pi / 2), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 25, accuracy: 0.00001)
  }

  func test_ValueJustAbovePiWrapsAround() {
    let view = ContentView()
    let x = view.angleToX(Angle.radians(.pi + .pi / 2), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 25, accuracy: 0.00001)
  }

  func test_ValueWellAbovePiWrapsAround() {
    let view = ContentView()
    let x = view.angleToX(Angle.radians(6 * .pi), CGSize(width: 100.0, height: 200.0))
    XCTAssertEqual(x, 50, accuracy: 0.00001)
  }
}

import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day00Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    abc1def2ghi
    jkl3mno4pqr
    stu5vwx6yz
    """

  func testPart1() throws {
    let challenge = Day01(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "102")
  }

  func testPart2() throws {
    let challenge = Day01(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "")
  }
}

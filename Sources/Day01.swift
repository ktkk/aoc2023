import Algorithms

struct Day01: AdventDay {
  var data: String

  var entities: [String] {
    data.split(separator: "\n").map { String($0) }
  }

  func part1() -> Any {
    let numbers = entities.map { line in
      guard let first = line.first(where: { $0.isNumber }) else {
        fatalError()
      }
      guard let second = line.reversed().first(where: { $0.isNumber }) else {
        fatalError()
      }

      return "\(first)\(second)"
    }.compactMap { Int($0) }

    return numbers.reduce(0, +)
  }

  func part2() -> Any {
      return ()
  }
}

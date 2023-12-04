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
      guard let second = line.last(where: { $0.isNumber }) else {
        fatalError()
      }

      return "\(first)\(second)"
    }.compactMap { Int($0) }

    return numbers.reduce(0, +)
  }

  func part2() -> Any {
    let numbersAsWords: [String: Character] = [
      "one": "1",
      "two": "2",
      "three": "3",
      "four": "4",
      "five": "5",
      "six": "6",
      "seven": "7",
      "eight": "8",
      "nine": "9",
    ]

    let numbers = entities.map { line in
      let first: Character?

      let prefix = line.prefix { !$0.isNumber }
      if prefix.isEmpty {
        first = line.first
      } else {
        let digit = prefix.findMatching(using: numbersAsWords)
        if let digit = digit {
          first = digit
        } else {
          first = line.first(where: { $0.isNumber })
        }
      }
      guard let first = first else {
        fatalError()
      }

      let second: Character?
      let suffix = line.suffix { !$0.isNumber }
      if suffix.isEmpty {
        second = line.last
      } else {
        let digit = suffix.findMatching(using: numbersAsWords, options: .backwards)
        if let digit = digit {
          second = digit
        } else {
          second = line.last(where: { $0.isNumber })
        }
      }
      guard let second = second else {
        fatalError()
      }

      return "\(first)\(second)"
    }.compactMap { Int($0) }

    return numbers.reduce(0, +)
  }
}

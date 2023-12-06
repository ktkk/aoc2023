import Algorithms

struct Day03: AdventDay {
  var data: String

  var entities: [String] {
    data.split(separator: "\n").map { String($0) }
  }

  func part1() -> Any {
    var partNumbers: [Int] = []
    for (index, line) in entities.enumerated() {
      let numbers = line.split { !$0.isNumber }
      
      let possibleSymbols = numbers.map { number in
        guard let value = Int(number) else {
          fatalError()
        }
        
        let lineStart = line.startIndex
        let lineEnd = line.index(before: line.endIndex)
        
        let numberStart = number.startIndex
        let numberEnd = number.index(before: number.endIndex)
        
        let front = line.index(numberStart, offsetBy: -1, limitedBy: lineStart)
        let back = line.index(numberEnd, offsetBy: 1, limitedBy: lineEnd)
        let breadth = [front] + number.indices.map { .some($0) } + [back]
        
        return (front: front, back: back, breadth: breadth, value: value)
      }
      
      var linePartNumbers: [Int] = []
      for possibleSymbol in possibleSymbols {
        if let front = possibleSymbol.front, line[front] != "." {
          linePartNumbers.append(possibleSymbol.value)
          continue
        }
        
        if let back = possibleSymbol.back, line[back] != "." {
          linePartNumbers.append(possibleSymbol.value)
          continue
        }
        
        if index != 0 {
          let previousLine = entities[index - 1]
          if possibleSymbol.breadth.compactMap({ $0 }).contains(where: { previousLine[$0] != "." }) {
            linePartNumbers.append(possibleSymbol.value)
            continue
          }
        }
        
        if index != entities.count - 1 {
          let nextLine = entities[index + 1]
          if possibleSymbol.breadth.compactMap({ $0 }).contains(where: { nextLine[$0] != "." }) {
            linePartNumbers.append(possibleSymbol.value)
            continue
          }
        }
      }
      
      partNumbers.append(contentsOf: linePartNumbers)
    }
    
    return partNumbers.reduce(0, +)
  }

  func part2() -> Any {
    return ()
  }
}

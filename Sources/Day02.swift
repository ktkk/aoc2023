import Algorithms

struct Day02: AdventDay {
  var data: String

  var entities: [String] {
    data.split(separator: "\n").map { String($0) }
  }

  func part1() throws -> Any {
    let games = try entities.map { try Game(input: $0) }

    let maxNrOfRedCubes = 12
    let maxNrOfGreenCubes = 13
    let maxNrOfBlueCubes = 14

    let possibleGames = games.filter { game in
      for set in game.sets {
        if set.nrOfRedCubes > maxNrOfRedCubes || set.nrOfGreenCubes > maxNrOfGreenCubes
          || set.nrOfBlueCubes > maxNrOfBlueCubes
        {
          return false
        }
      }

      return true
    }

    return possibleGames.map(\.id).reduce(0, +)
  }

  func part2() -> Any {
    return ()
  }

  struct Game: Identifiable {
    let id: Int
    let sets: [Set]
    init(input: any StringProtocol) throws {
      let (id, content) = try Game.parseId(input)
      self.id = id
      sets = try Game.parseContent(content)
    }
    enum ParseError: Error {
      case invalidId
    }
    private static func parseId(
      _ input: any StringProtocol
    ) throws -> (Int, rest: any StringProtocol) {
      let prefix = input.prefix { $0 != ":" }
      guard let gameId = Int(String(prefix.split(separator: " ")[1])) else {
        throw ParseError.invalidId
      }
      return (gameId, input[prefix.endIndex...].dropFirst(2))
    }
    private static func parseContent(
      _ input: any StringProtocol
    ) throws -> [Set] {
      let sets = input.split(separator: "; ")
      let cubes = sets.map {
        $0.split(separator: ", ").map { cube in
          let components = cube.split(separator: " ")
          guard let amount = Int(components[0]) else {
            fatalError()
          }
          return (amount, String(components[1]))
        }
      }
      return cubes.map { Game.Set($0) }
    }
    struct Set {
      var nrOfRedCubes: Int = 0
      var nrOfGreenCubes: Int = 0
      var nrOfBlueCubes: Int = 0
      init(_ cubes: [(Int, String)]) {
        for (amount, color) in cubes {
          switch color {
          case "red":
            nrOfRedCubes = amount
          case "green":
            nrOfGreenCubes = amount
          case "blue":
            nrOfBlueCubes = amount
          default:
            break
          }
        }
      }
    }
  }
}

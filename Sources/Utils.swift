//
//  File.swift
//
//
//  Created by Thuis on 04/12/2023.
//

import Foundation

extension StringProtocol {
  func findMatching<T>(
    using dictionary: [String: T],
    options: NSString.CompareOptions = []
  ) -> T? {
    func compare(_ first: Int, _ second: Int) -> Bool {
      return if options.contains(.backwards) {
        first > second
      } else {
        first < second
      }
    }

    var match: (distance: Int, value: T)? = nil
    for (word, value) in dictionary {
      if let range = self.range(of: word, options: options),
        match == nil
          || compare(self.distance(from: self.startIndex, to: range.lowerBound), match!.distance)
      {
        let distance = self.distance(from: self.startIndex, to: range.lowerBound)
        match = (distance, value)
      }
    }

    return match?.value
  }
}

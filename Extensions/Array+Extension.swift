import Foundation

extension Array {

    ///
    /// Returns an array containing this sequence shuffled
    ///

    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }

    ///
    /// Shuffles this sequence in place
    ///

    @discardableResult
    mutating func shuffle() -> Array {
        let c = count
        guard c > 1 else { return self }

        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            self.swapAt(firstUnshuffled, i)
        }
        return self
    }

    ///
    /// Random element from array
    ///

    var random: Element { return self[Int(arc4random_uniform(UInt32(count)))] }

    ///
    /// Used to get unsorted Array of random elements from an Array
    /// - parameter n: number random elements to be returned.
    /// - returns: Array of random elements having maximum count as n.
    ///

    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }
}

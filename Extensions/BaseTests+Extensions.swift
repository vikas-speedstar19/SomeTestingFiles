import KIF
@testable import ShopWell

extension KIFTestCase {

    // MARK: - constants
    var shortDelay: TimeInterval { return 1.0 }
    var mediumDelay: TimeInterval { return 2.0 }
    var longDelay: TimeInterval { return 5.0 }
    var extraLongDelay: TimeInterval { return 10.0 }

    ///
    /// Function to find random count
    ///
    /// - parameter modulus: Pass the Int range
    ///
    /// - returns Int: Returns the random integer count
    ///

    func random(_ modulus: Int) -> Int {
        return modulus != 0 ? Int(arc4random())%modulus : 0
    }
}

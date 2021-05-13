import XCTest
import KIF

class Element {

    var identifier: String?
    var label: String?
    let testActor: KIFUITestActor

    init(_ testActor: KIFUITestActor, identifier: AccessibilityIdentifier) {
        self.testActor = testActor
        self.identifier = identifier.rawValue
    }

    init (_ testActor: KIFUITestActor, identifier: String) {
        self.testActor = testActor
        self.identifier = identifier
    }

    init(_ testActor: KIFUITestActor, label: AccessibilityLabel) {
        self.testActor = testActor
        self.label = label.rawValue
    }
}

// MARK: - KIF Helper methods for accessing UI elements

extension Element {

    /**
     * Function to check the element is present or not
     *
     * returns: Bool
     */

    func isPresent() -> Bool {
        var isPresent = false
        if let identifier = identifier {
            isPresent = testActor.tryFindingView(withAccessibilityIdentifier: identifier)
        } else if let label = label {
            if let _ = try? testActor.tryFindingView(withAccessibilityLabel: label) {
                isPresent = true
            }
        } else {
            fatalError("No Identifier or Label has set for element")
        }
        return isPresent
    }

    /**
     * Function to tap on the element
     */

    func tap() {
        if let identifier = identifier {
            testActor.waitForTappableView(withAccessibilityIdentifier: identifier)
            testActor.tapView(withAccessibilityIdentifier: identifier)
        } else if let label = label {
            testActor.waitForTappableView(withAccessibilityLabel: label)
            testActor.tapView(withAccessibilityLabel: label)
        } else {
            fatalError("No Identifier or Label has set for element")
        }
    }

    /**
     *  Function to swipe view in given direction
     *
     *  - parameter direction: Swipe direction on given view
     */

    func swipe(_ direction: KIFSwipeDirection) {
        if let identifier = identifier {
            testActor.waitForView(withAccessibilityIdentifier: identifier)
            testActor.swipeView(withAccessibilityIdentifier: identifier, in: direction)
        } else if let label = label {
            testActor.waitForView(withAccessibilityLabel: label)
            testActor.swipeView(withAccessibilityLabel: label, in: direction)
        }
        testActor.waitForAnimationsToFinish()
    }

    /**
     *  Function to return a view
     *
     *  - returns: UIView of given type
     */

    func getView<ViewType>() -> ViewType? {
        if let identifier = identifier {
            return testActor.waitForView(withAccessibilityIdentifier: identifier) as? ViewType
        } else if let label = label {
            return testActor.waitForView(withAccessibilityLabel: label) as? ViewType
        } else {
            fatalError("No Identifier or Label has set for element")
            return nil
        }
    }

}

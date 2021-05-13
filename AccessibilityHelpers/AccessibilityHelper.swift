import UIKit

extension UIAccessibilityIdentification {
    func setAccessibilityIdentifier(_ identifier: AccessibilityIdentifier) {
        self.accessibilityIdentifier = identifier.rawValue
    }
}

extension NSObject {
    func setAccessibilityLabel(_ label: AccessibilityLabel) {
        self.isAccessibilityElement = true
        self.accessibilityLabel = label.rawValue
    }
}

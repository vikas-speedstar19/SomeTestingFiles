import XCTest
import KIF

class TextFieldElement: Element {

    func clearAndEnterText(text: String, expectedResult: String = "", delay: Double = 0.0) {
        testActor.clearTextFromView(withAccessibilityIdentifier: identifier)
        if expectedResult != "" {
            testActor.enterText(text, intoViewWithAccessibilityIdentifier: identifier, expectedResult: expectedResult)
        } else {
            testActor.enterText(text, intoViewWithAccessibilityIdentifier: identifier)
        }
        testActor.wait(forTimeInterval: delay)
    }

    func getText() -> String {
        let textField = testActor.waitForView(withAccessibilityIdentifier: identifier) as? UITextField
        return textField?.text ?? ""
    }

    func clearText() {
        testActor.clearTextFromView(withAccessibilityIdentifier: identifier)
    }
}

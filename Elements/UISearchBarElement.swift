class UISearchBarElement: Element {
    
    /**
     * Function to clear and enter text into UISearchBar
     *
     * - parameter text: Text to be enter
     * - parameter expectedResult: Expected text from view
     * - parameter delay: Time interval to wait
     */
    
    func clearAndEnterText(text: String, expectedResult: String = "", delay: Double = 0.0) {
        testActor.clearTextFromView(withAccessibilityIdentifier: identifier)
        if !(expectedResult.isEmpty) {
            testActor.enterText(text, intoViewWithAccessibilityIdentifier: identifier, expectedResult: expectedResult)
        } else {
            testActor.enterText(text, intoViewWithAccessibilityIdentifier: identifier)
        }
        testActor.wait(forTimeInterval: delay)
    }
    
    /**
     * Function to return text from UISearchBar
     *
     * - returns: Text from UISearchBar
     */
    
    func getText() -> String {
        let searchBar = testActor.waitForView(withAccessibilityIdentifier: AccessibilityIdentifier.searchScreenProductSearchBar.rawValue) as? UISearchBar
        return searchBar?.text ?? ""
    }
    
    /**
     * Function to to clear text from UISearchBar
     */
    
    func clearText() {
        testActor.clearTextFromView(withAccessibilityIdentifier: identifier)
    }
}

class UIButtonElement: Element {

    /**
     * Function to return selected state of UIButton
     *
     *
     * - returns: Selected state of UIButton
     */

    func getSelectedState() -> Bool {
        let button = testActor.waitForTappableView(withAccessibilityIdentifier: identifier) as? UIButton
        return button?.isSelected ?? false
    }
}

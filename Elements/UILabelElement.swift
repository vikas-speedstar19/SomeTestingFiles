class UILabelElement: Element {

    func getText() -> String {
        let label = testActor.waitForView(withAccessibilityIdentifier: identifier) as? UILabel
        return label?.text ?? ""
    }
}

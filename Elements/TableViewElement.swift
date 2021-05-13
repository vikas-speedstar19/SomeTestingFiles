class TableViewElement: Element {

    /**
     * Function to tap tableview cell of given type at specific indexpath
     *
     * - parameter indexPath: IndexPath of the cell
     *
     */

    func tapTableViewCell(at indexPath: IndexPath) {
        if let identifier = identifier {
            testActor.waitForCell(at: indexPath, inTableViewWithAccessibilityIdentifier: identifier)
            testActor.tapRow(at: indexPath, inTableViewWithAccessibilityIdentifier: identifier)
        } else {
            fatalError("No Identifier or Label has set for element")
        }
    }

    /**
     * Function to return tableview cell of given type at specific indexpath
     *
     * - parameter indexPath: IndexPath of the cell
     * - parameter cellType: Type of UITableViewCell
     *
     * - returns: UITableViewCell of given type
     */

    func tableViewCell<CellType>(indexPath: IndexPath) -> CellType? {
        if let identifier = identifier {
            return testActor.waitForCell(at: indexPath, inTableViewWithAccessibilityIdentifier: identifier) as? CellType
        } else {
            fatalError("No Identifier or Label has set for element")
            return nil
        }
    }

    /*
     * Function to retrive number of section of tableview
     */

    func getNumberOfSections() -> Int? {
        if let identifier = identifier {
            let tableView = testActor.waitForView(withAccessibilityIdentifier: identifier) as? UITableView
            return tableView?.numberOfSections
        }
        return nil
    }

    /*
     * Function to retrive number of rows in specified section
     *
     * - parameter section: Section number whose rows count to be retreived
     *
     */

    func getNumberOfRows(in section: Int = 0) -> Int? {
        testActor.waitForView(withAccessibilityIdentifier: identifier)
        if let identifier = identifier {
            let tableView = testActor.waitForView(withAccessibilityIdentifier: identifier) as? UITableView
            return tableView?.numberOfRows(inSection: section)
        }
        return nil
    }

    /*
     * Function to swipe particular table view cell at specified direction
     *
     * - parameter indexPath: IndexPath of the cell to be swiped
     * - parameter direction: Direction on which the cell to be swiped
     *
     */

    func swipeTableViewCell(at indexPath: IndexPath, at direction: KIFSwipeDirection) {
        if let identifier = identifier {
            testActor.waitForView(withAccessibilityIdentifier: identifier)
            let tableView = testActor.waitForView(withAccessibilityIdentifier: identifier) as? UITableView
            testActor.waitForCell(at: indexPath, inTableViewWithAccessibilityIdentifier: identifier)
            testActor.swipeRow(at: indexPath, in : tableView, in: direction)
        }
    }
}

import Foundation

class CollectionViewElement: Element {

    /**
     * Function to return collection view cell of given type at specific indexpath
     *
     * - parameter indexPath: IndexPath of the cell
     *
     */

    func tapCollectionViewCell(at indexPath: IndexPath) {
        if let identifier = identifier {
            testActor.waitForCell(at: indexPath, inCollectionViewWithAccessibilityIdentifier: identifier)
            testActor.tapItem(at: indexPath, inCollectionViewWithAccessibilityIdentifier: identifier)
        } else {
            fatalError("No Identifier or Label has set for element")
        }
    }

    /**
     * Function to return collection view cell of given type at specific indexpath
     *
     * - parameter indexPath: IndexPath of the cell
     * - parameter cellType: Type of UICollectionViewCell
     *
     * - returns: UICollectionViewCell of given type
     */

    func collectionViewCell<CellType>(indexPath: IndexPath) -> CellType? {
        testActor.waitForView(withAccessibilityIdentifier: identifier)
        if let identifier = identifier {
            return testActor.waitForCell(at: indexPath, inCollectionViewWithAccessibilityIdentifier: identifier) as? CellType
        } else {
            fatalError("No Identifier or Label has set for element")
            return nil
        }
    }

    /**
     * Function to fetch random indexpath from CollectionView
     */

    func getRandomIndexPath(for section: Int = 0) -> IndexPath? {
        testActor.waitForView(withAccessibilityIdentifier: identifier)
        if let identifier = identifier {
            let collectionView = testActor.waitForView(withAccessibilityIdentifier: identifier) as? UICollectionView
            let rowsCount = collectionView?.numberOfItems(inSection: section)
            let randomRow = (0..<(rowsCount!)).randomElement()!
            return IndexPath(row: randomRow, section: section)
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
            let collectionView = testActor.waitForView(withAccessibilityIdentifier: identifier) as? UICollectionView
            return collectionView?.numberOfSections
        }
        return nil
    }

    /*
     * Function to retreive number of items in specified section from Collection View
     *
     * - parameter section: Section number whose item count to be retreived
     *
     */

    func getNumberOfItems(in section: Int = 0) -> Int? {
        testActor.waitForView(withAccessibilityIdentifier: identifier)
        if let identifier = identifier {
            let collectionView = testActor.waitForView(withAccessibilityIdentifier: identifier) as? UICollectionView
            return collectionView?.numberOfItems(inSection: section)
        }
        return nil
    }
}

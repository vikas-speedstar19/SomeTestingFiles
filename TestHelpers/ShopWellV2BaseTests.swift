//
//  ShopWellV2BaseTests.swift
//  ShopWellV2BaseTests
//
//  Created by Tudip on 9/12/18.
//  Copyright © 2018 Innit. All rights reserved.
//

import XCTest
import KIF
@testable import ShopWell

class ShopWellV2BaseTests: KIFTestCase {

    // MARK: - KIF lifecycle methods

    override func setUp() {
        super.setUp()
        environment = Environment.preProduction
        UserDefaults.environment = Environment.preProduction
        AppDelegate.shared.updateServerTypeObjects()
        continueAfterFailure = false
        KIFTestActor.setDefaultTimeout(20)

        // Speedup animations
        UIApplication.shared.keyWindow?.layer.speed = 100
    }

    override func beforeEach() {
        environment = Environment.preProduction
        UserDefaults.environment = Environment.preProduction
        logoutIfNeeded()
    }

    // MARK: - KIF helper methods

    ///
    /// Function to logout the user after every test case
    ///

    func logoutIfNeeded() {
        navigateToOnboardingScreen()
    }

    ///
    /// Function to tap on view with accessibility label
    ///
    /// - parameter label: Accessibility label of the component
    /// - parameter checkpoint: To check for the API call
    /// - parameter delay: Wait for view with time interval
    ///

    func tapOnView(_ label: AccessibilityLabel, delay: Double = 0.0) {
        tester().waitForTappableView(withAccessibilityLabel: label.rawValue)
        tester().tapView(withAccessibilityLabel: label.rawValue)
        tester().wait(forTimeInterval: delay)
        testLog(format: "STEP: Tapped on '\(label.rawValue)'")
    }

    ///
    /// Function to tap on the view with accessibility identifier
    ///
    /// - parameter withAccessibilityIdentifier: Accessibility identifier of the view
    /// - parameter checkpoint: to check for the API call
    /// - parameter delay: Wait for view with time interval
    ///

    func tapOnView(_ identifier: AccessibilityIdentifier, delay: Double = 0.0) {
        tester().waitForTappableView(withAccessibilityIdentifier: identifier.rawValue)
        tester().tapView(withAccessibilityIdentifier: identifier.rawValue)
        tester().wait(forTimeInterval: delay)
        testLog(format: "STEP: Tapped on '\(identifier.rawValue)'")
    }

    ///
    /// Function to wait for a checkpoint and on response to that checkpoint execute a block
    ///
    /// - parameter checkpoint: To check for the API call
    /// - executionBlock: Block to execute if checkpoint hits
    ///

    func waitForCheckpoint(_ checkpoint: CheckPoint, executionBlock: (() -> (Void))? = nil) {
        system().waitForCheckpoint(withName: checkpoint.rawValue) {
            if let executionBlock = executionBlock {
                executionBlock()
            }
        }
    }

    ///
    /// Function to check if a component is present in the screen
    ///
    /// - parameter accessibilityIdentifier: AccessibilityIdentifier of the component.
    /// - parameter expected: expected state of the component.
    /// - parameter errorMessage: error message if the component fails to meet expected state.
    ///

    func verifyComponentInScreen(_ accessibilityIdentifier: AccessibilityIdentifier, expected: Bool, errorMessage: ErrorMessages) {
        var isComponentPresent = false
        if tester().tryFindingView(withAccessibilityIdentifier: accessibilityIdentifier.rawValue) {
            isComponentPresent = true
        }

        verifyComponent(currentState: isComponentPresent, expectedState: expected, errorMessage: errorMessage)
    }
    
    ///
    /// Function to check if a component is present in the screen
    ///
    /// - parameter accessibilityLabel: accessibilityLabel of the component.
    /// - parameter expected: expected state of the component.
    /// - parameter errorMessage: error message if the component fails to meet expected state.
    ///
    
    func verifyComponentInScreen(_ accessibilityLabel: AccessibilityLabel, expected: Bool, errorMessage: ErrorMessages) {
        var isComponentPresent = false
        if let _ = try? tester().tryFindingView(withAccessibilityLabel: accessibilityLabel.rawValue) {
            isComponentPresent = true
        }
        
        verifyComponent(currentState: isComponentPresent, expectedState: expected, errorMessage: errorMessage)
    }

    ///
    /// Function to check if a component is present in the screen
    ///
    /// - parameter accessibilityIdentifier: AccessibilityIdentifier of the component
    ///
    /// - returns: Returns boolean value representing element is present in screen or not
    ///

    func isComponentPresent(_ accessibilityIdentifier: AccessibilityIdentifier) -> Bool {
        return tester().tryFindingView(withAccessibilityIdentifier: accessibilityIdentifier.rawValue)
    }

    ///
    /// Function to check if a component is present in the screen
    ///
    /// - parameter accessibilityLabel: AccessibilityIdentifier of the component
    ///
    /// - returns: Returns boolean value representing element is present in screen or not
    ///

    func isComponentPresent(_ accessibilityLabel: AccessibilityLabel) -> Bool {
        if let _ = try? tester().tryFindingView(withAccessibilityLabel: accessibilityLabel.rawValue) {
            return true
        }
        return false
    }

    ///
    /// Function to verify component
    ///
    /// - parameter currentState: Actual state of the component
    /// - parameter expectedState: Expected state of the component
    /// - parameter errorMessage: Error message to show on failure
    ///

    func verifyComponent(currentState: Bool, expectedState: Bool, errorMessage: ErrorMessages) {
        if currentState != expectedState {
            do {
                try failTestWithErrorMessage(caption: errorMessage.rawValue)
            }
            catch let errorMessage {
                print(errorMessage)
            }
        }
    }
    
    ///
    /// Function to verify component
    ///
    /// - parameter currentState: Actual state of the component
    /// - parameter expectedState: Expected state of the component
    /// - parameter errorMessage: Error message to show on failure
    ///
    
    func verifyComponent(currentState: Bool, expectedState: Bool, errorMessage: String) {
        if currentState != expectedState {
            do {
                try failTestWithErrorMessage(caption: errorMessage)
            }
            catch let errorMessage {
                print(errorMessage)
            }
        }
    }

    ///
    /// Function to fail test with error message
    ///
    /// - parameter caption: Error message to show on failure
    ///

    func failTestWithErrorMessage(caption: String) throws {

        // Defining the error
        let verifyError = NSError(domain: "verificationError", code: 101, userInfo: [NSLocalizedDescriptionKey : caption])

        // Failing the test case with error
        tester().failWithError(verifyError, stopTest: true)
    }

    ///
    /// Function to verify Strings
    ///
    /// - parameter currentString: Observed string
    /// - parameter expectedString: Expected string
    /// - parameter errorMessage: Error message to show on failure
    /// - parameter isEqual: Bool, default value: true
    ///

    func verifyStrings(currentString: String, expectedString: String, errorMessage: String, isEqual: Bool = true) {
        if (isEqual && currentString != expectedString) || (!isEqual && currentString == expectedString) {
            do {
                try failTestWithErrorMessage(caption: errorMessage)
            }
            catch let errorMessage {
                print(errorMessage)
            }
        }
    }

    /**
     * Function to verify Strings
     *
     * - parameter currentString: Observed string
     * - parameter expectedString: ShopwellV2Strings enum
     * - parameter errorMessage: Error message to show on failure
     */

    func verifyStrings(currentString: String, expectedString: ShopwellV2Strings, errorMessage: String) {
        verifyStrings(currentString: currentString,
                      expectedString: expectedString.rawValue,
                      errorMessage: errorMessage)
    }
}

// MARK: - Navigation workflows helpers

extension ShopWellV2BaseTests {

    /**
     * Function to navigate test back to Onboarding screen
     */

    func navigateToOnboardingScreen() {
        tester().wait(forTimeInterval: shortDelay)
        if !UserDefaults.isNotificationPopupDisplayed {
            tester().wait(forTimeInterval: mediumDelay)
            tapOnView(.pushNotificationDialogAllowButton)
            tester().acknowledgeSystemAlert()
        }

        // Tap on OK button if visible
        if isComponentPresent(.alertViewOKButton) {
            tapOnView(.alertViewOKButton)
        }

        // Navigate to home screen if the test is stuck at Onboarding flow
        if isComponentPresent(.onboardingMaleUserButton) || isComponentPresent(.onboardingFemaleUserButton) {
            SignUpGenderPage(tester(), system())
                .selectRandomGender().1
                .selectBirthday(birthday: DataMocker.getRandomDate().0)
                .getHomePage()
                .handlePushNotificationDialog()
                .openProfilePage()
                .openProfileSettings()
                .logout()
                .navigateToOnboardingProfilePage()
                .openHomePage()
        }

        // Tap on cancel button of dialog to dismiss it
        if isComponentPresent(.addListDialogCancelButton) {
            tapOnView(.addListDialogCancelButton)
        }

        // Tap back button until there is no back button in navigation bar
        while isComponentPresent(.navigationBarBackButton) {
            tapOnView(.navigationBarBackButton)
        }

        // Tap back button until there is no back button in navigation bar
        while isComponentPresent(.navigationBarCloseButton) {
            tapOnView(.navigationBarCloseButton)
        }

        // Tap on OK button if visible
        if isComponentPresent(.alertViewOKButton) {
            tapOnView(.alertViewOKButton)
        }

        // Tap on cancel button if visible
        if isComponentPresent(.addListDialogCancelButton) {
            tapOnView(.addListDialogCancelButton)
        }

        // Tap profile Tab if visible
        if isComponentPresent(.profileTab) {
            tapOnView(.profileTab)

            waitForCheckpoint(.profileSettingVCDidAppeared) {
                self.tapOnView(.profileScreenSettingsButton)
            }

            // Logout the user if Logout button is present
            if isComponentPresent(.settingsScreenLogoutButton) {
                waitForCheckpoint(.signInVCDidAppeared) {
                    self.tapOnView(.settingsScreenLogoutButton)
                }
                tapOnView(.navigationBarBackButton)
                tester().wait(forTimeInterval: mediumDelay)
                Utils.switchToProductScanner()
            } else {
                tapOnView(.navigationBarBackButton)
                Utils.switchToProductScanner()
            }
        }
        tester().wait(forTimeInterval: mediumDelay)
        if isComponentPresent(.pushNotificationDialogAllowButton) {
            tapOnView(.pushNotificationDialogAllowButton)
            tester().acknowledgeSystemAlert()
        }
    }


    // MARK: - LoggedIn Flow Navigation helper methods

    /**
     *
     * Function to navigate to SignIn page
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     * - returns: Returns page object of Home page
     */

    func navigateToSignInScreen(_ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> SignInPage {
        return ShopwellHomePage(tester(), system())
            .getHomePage()
            .openProfilePage()
            .openSignInPage()
    }

    /**
     *
     * Function to navigate to SignIn page
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     * - returns: Returns page object of Sign Up page
     */

    func navigateToSignUpScreen(_ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> SignUpViewPage {
        return ShopwellHomePage(tester(), system())
            .getHomePage()
            .openProfilePage()
            .openSignUpPage()
    }

    func navigateToProductScanScreen(_ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> ScanPage {
        return ShopwellHomePage(tester(), system()).getHomePage().openScanPage()
    }

    /**
     * Function to navigate to Home screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of Home page
     */
    func loginAndNavigateToUserProfileScreen(_ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> UserProfilePage {
        return navigateToSignInScreen(testActor, systemActor).enterEmail(DataMocker.existingEmails.random)
            .enterPassword(DataMocker.existingEmailsPassword)
            .openUserProfilePage()
    }

    /**
     * Function to navigate to Product Search screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of Product Search page
     */

    func loginAndNavigateToHomeScreen(with email: String, _ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> ShopwellHomePage {
        return loginAndNavigateToUserProfileScreen(with: email, testActor, systemActor)
            .openHomePage()
    }


    /**
     * Function to navigate to Product Search screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of Product Search page
     */

    func loginAndNavigateToProductSearchScreen(with email: String, _ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> SearchProductsPage {
        return loginAndNavigateToUserProfileScreen(with: email, testActor, systemActor)
            .openSearchPage()
    }

    /**
     * Function to navigate to Home screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of Scan page
     */

    func loginAndNavigateToProductScanScreen(with email: String, _ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> ScanPage {
        return loginAndNavigateToUserProfileScreen(with: email, testActor, systemActor)
            .openScanPage()
    }

    /**
     * Function to navigate to Home screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of Scan page
     */

    func loginAndNavigateToListScreen(with email: String, _ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> MyListsPage {
        return loginAndNavigateToUserProfileScreen(with: email, testActor, systemActor)
            .openShoppingListPage()
    }

    /**
     * Function to navigate to User Profile screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of User Profile page
     */

    func loginAndNavigateToUserProfileScreen(with email: String, _ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> UserProfilePage {
        return navigateToSignInScreen(testActor, systemActor)
            .enterEmail(email)
            .enterPassword(DataMocker.existingEmailsPassword)
            .openUserProfilePage()
    }

    /**
     * Function to navigate to Home screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of Home page
     */

    func navigateToHomeScreen(_ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> HomePage {
        return navigateToSignInScreen(tester(), system())
            .enterEmail(DataMocker.existingEmails.random)
            .enterPassword(DataMocker.existingEmailsPassword)
            .openUserProfilePage()
            .getHomePage()
    }

    /**
     * Function to navigate to Scan screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of Scan page
     */

    func navigateToScanScreen(_ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> ScanPage {
        return navigateToHomeScreen(testActor, systemActor).openScanPage()
    }

    /**
     * Function to navigate to My Lists screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of My Lists page
     */

    func navigateToMyListsScreen(_ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> MyListsPage {
        return navigateToHomeScreen(testActor, systemActor).openShoppingListPage()
    }

    // MARK: - Navigation methods for Guest Flow

    /**
     * Function to navigate to Shopwell Home Page screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of Shopwell Home Page page
     */

    func navigateToShopwellHomePageForGuestUser(_ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> ShopwellHomePage {
        return ShopwellHomePage(testActor, systemActor)
    }

    /**
     * Function to navigate to Product Search Page screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of Product Search Page page
     */

    func navigateToProductSearchPageForGuestUser(_ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> SearchProductsPage {
        return ShopwellHomePage(testActor, systemActor)
            .getHomePage()
            .openSearchPage()
    }

    /**
     * Function to navigate to Product Scan screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of Product Scan page
     */

    func navigateToProductScanPageForGuestUser(_ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> ScanPage {
        return ShopwellHomePage(testActor, systemActor)
            .getHomePage()
            .openScanPage()
    }

    /**
     * Function to navigate to My Lists screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of My Lists page
     */

    func navigateToMyListsPageForGuestUser(_ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> MyListsPage {
        return ShopwellHomePage(testActor, systemActor)
            .getHomePage()
            .openMyListsPageInGuestFlow()
    }

    /**
     * Function to navigate to User Profile screen
     *
     * - parameter testActor: KIFUITestActor object
     * - parameter systemActor: KIFSystemTestActor object
     *
     * - returns: Returns page object of User Profile page
     */

    func navigateToUserProfilePageForGuestUser(_ testActor: KIFUITestActor, _ systemActor: KIFSystemTestActor) -> UserProfilePage {
        return ShopwellHomePage(testActor, systemActor)
            .getHomePage()
            .openProfilePage()
    }

    // MARK: - Logout navigation helper methods

    /**
     * Function to logout from HomePage and navigate to ShopwellHomePage
     *
     * - parameter homePage: HomePage object
     *
     */

    func logoutFromHomePage(_ homePage: HomePage) {
        homePage.openProfilePage()
            .openProfileSettings()
            .logout()
            .navigateToOnboardingProfilePage()
            .openHomePage()
    }

    /**
     * Function to logout from Product Detail page and navigate to ShopwellHomePage
     *
     * - parameter productDetailPage: Product Detail page object
     *
     */

    func logoutFromProductDetailPage(_ productDetailpage: ProductDetailPage) {
        productDetailpage.openShopwellHomePage()
            .getHomePage()
            .openProfilePage()
            .openProfileSettings()
            .logout()
            .navigateToOnboardingProfilePage()
            .openHomePage()
    }

    /**
     * Function to logout from Product Search page and navigate to ShopwellHomePage
     *
     * - parameter productSearchPage: Product Search Page object
     *
     */

    func logoutFromProductSearchPage(_ productSearchPage: SearchProductsPage) {
        productSearchPage.getHomePage()
            .openProfilePage()
            .openProfileSettings()
            .logout()
            .navigateToOnboardingProfilePage()
            .openHomePage()
    }

    /**
     * Function to logout from Product Scan page and navigate to ShopwellHomePage
     *
     * - parameter homePage: Scan object
     *
     */

    func logoutFromProductScanPage(_ productScanPage: ScanPage) {
        productScanPage.getHomePage()
            .openProfilePage()
            .openProfileSettings()
            .logout()
            .navigateToOnboardingProfilePage()
            .openHomePage()
    }

    /**
     * Function to logout from User Profile page and navigate to ShopwellHomePage
     *
     * - parameter userProfilePage: User Profile Page object
     *
     */

    func logoutFromMyListsPage(_ myListsPage: MyListsPage) {
        myListsPage.getHomePage()
            .openProfilePage()
            .openProfileSettings()
            .logout()
            .navigateToOnboardingProfilePage()
            .openHomePage()
    }

    /**
     * Function to logout from User Profile page and navigate to ShopwellHomePage
     *
     * - parameter userProfilePage: User Profile Page object
     *
     */

    func logoutFromUserProfilePage(_ userProfilePage: UserProfilePage) {
        userProfilePage.openProfileSettings()
            .logout()
            .navigateToOnboardingProfilePage()
            .openHomePage()
    }
    
    /**
     * Function to peform sign up and navigation to the User Profile screen
     *
     * - returns: Returns page object of User Profile Page
     */
    
    func signUpAndNavigateToUserProfilePage() -> UserProfilePage {
        
        let birthday = DataMocker.getRandomDate().0
        
        let userProfilePage = navigateToSignUpScreen(tester(), system()).enterPassword(password: DataMocker.existingEmailsPassword)
            .enterEmail(email: DataMocker.randomEmail())
            .openSignUpGenderPage()
            .selectRandomGender().1
            .selectBirthday(birthday: birthday)
            .getProfilePage()
        
        return userProfilePage
    }

    ///
    /// Returns true if any item from selected items is repeated
    ///
    /// - parameter selectedItems: [String]
    ///

    func isAnyItemRepeatedInSelectedItems(selectedItems: [String]) -> (isSelectedItemRepeated: Bool, selectedItem: String) {

        var selectedItemsCount: [String: Int] = [ : ]
        selectedItems.forEach { selectedItemsCount[$0, default: 0] += 1 }
        var numberOfTimesItemAppeared: Int = 0
        var isSelectedItemRepeated: Bool = false
        var item = String()

        for itemName in selectedItems {

            item = itemName
            numberOfTimesItemAppeared = selectedItemsCount[itemName] ?? 0

            if numberOfTimesItemAppeared > 1 {
                isSelectedItemRepeated = true
                return (isSelectedItemRepeated, item)
            }
        }
        return (isSelectedItemRepeated, item)
    }

}

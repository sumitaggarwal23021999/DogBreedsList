import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?
    
    // MARK: - Private Variables
    private var sbMain: UIStoryboard?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        navigateToLanguageCityCountrySelection()
        return true
    }
        
        // Method used to navigate user to Lanuguage, City, Country selection screen.
    private func navigateToLanguageCityCountrySelection() {
        if let dogBreedListVC = getStoryBoard().instantiateViewController(withIdentifier: "DogBreedListVC") as? DogBreedListVC {
            let navigationController = UINavigationController.init(rootViewController: dogBreedListVC)
            window?.rootViewController = navigationController
            window?.backgroundColor = .white
            window?.makeKeyAndVisible()
        }
    }
    
    func getStoryBoard() -> UIStoryboard {
        if sbMain == nil {
            sbMain = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        }
        return sbMain!
    }
}


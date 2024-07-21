import Foundation
import UIKit

extension UIViewController {
    func showAlertControllerWith(
        title: AlertTitle = .appName,
        message: AlertMessages,
        completionOnPresentationOfAlert: NullableCompletion = nil,
        buttons: AlertButton...
    ) {
        let alertController = UIAlertController(title: title.value, message: message.value,
                                                preferredStyle: UIAlertController.Style.alert)
        for button in buttons {
            let alertAction = UIAlertAction(title: button.name, style: button.style) { _ in
                if let actionToPerform = button.action {
                    actionToPerform()
                }
            }
            alertController.addAction(alertAction)
        }
        present(alertController, animated: true, completion: completionOnPresentationOfAlert)
    }
}

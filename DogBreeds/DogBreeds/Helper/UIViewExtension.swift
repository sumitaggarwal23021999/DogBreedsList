import Foundation
import UIKit

extension UIView {
    @objc func addConstaintsToSuperview(leading: CGFloat = 0.0, top: CGFloat = 0.0, bottom: CGFloat = 0.0, trailing: CGFloat = 0.0) {
        
        guard superview != nil else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: leading).isActive = true
        topAnchor.constraint(equalTo: superview!.topAnchor, constant: top).isActive = true
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: bottom).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: trailing).isActive = true
    }
}

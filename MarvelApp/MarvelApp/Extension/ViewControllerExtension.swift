//
//  ViewControllerExtension.swift
//  MarvelApp
//
//  Created by Tobi on 19/09/2023.
//

import UIKit

extension UIViewController {
    func showAlert(message: String, controller: UIViewController?) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        controller?.present(alert, animated: true, completion: nil)
    }
}

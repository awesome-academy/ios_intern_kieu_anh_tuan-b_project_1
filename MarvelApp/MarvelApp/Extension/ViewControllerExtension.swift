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

    func hideKeyboardWhenTappedAround() {
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                  action: #selector(UIViewController.dismissKeyboard))
         tap.cancelsTouchesInView = false
         view.addGestureRecognizer(tap)
     }

     @objc func dismissKeyboard() {
         view.endEditing(true)
     }
}

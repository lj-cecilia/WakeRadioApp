//
//  AdminPage.swift
//  WakeRadio
//
//  Created by Cecilia on 8/25/24.
//
import UIKit

import Foundation
class SecondViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginTouched(_ sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        // Perform your login logic here
        print("Username: \(username), Password: \(password)")
    }
}

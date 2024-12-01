//
//  AdminPage.swift
//  WakeRadio
//

import UIKit

class AdminPage: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginTouched(_ sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        // Simple authentication logic
        if username == "admin" && password == "password123" {
            print("Login successful")
            
            // Navigate to the ResetPage
            navigateToResetPage()
        } else {
            print("Invalid username or password")
            showAlert(title: "Login Failed", message: "Invalid username or password. Please try again.")
        }
    }
    
    private func navigateToResetPage() {
        // Assuming "ResetPage" is the storyboard ID for the ResetPage
        if let resetPageVC = storyboard?.instantiateViewController(withIdentifier: "ResetPage") as? ResetPage {
            navigationController?.pushViewController(resetPageVC, animated: true)
        }
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

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
        if username == "admin" && password == "123" {
            print("Login successful")
            
            // Navigate to the ResetPage
            navigateToResetPage()
        } else {
            print("Invalid username or password")
            showAlert(title: "Login Failed", message: "Invalid username or password. Please try again.")
        }
    }
    
    @IBAction func navigateToResetPage() {
        if let resetPageVC = storyboard?.instantiateViewController(withIdentifier: "ResetPage") as? ResetPage {
            // Check if StreamDetailsView exists in the navigation stack
            if let navigationStack = navigationController?.viewControllers {
                for viewController in navigationStack {
                    if let streamDetailsVC = viewController as? StreamDetailsView {
                        resetPageVC.streamDetailsView = streamDetailsVC
                        break
                    }
                }
            }
            
            // Verify if the streamDetailsView is set
            if resetPageVC.streamDetailsView == nil {
                print("StreamDetailsView not found in navigation stack.")
            } else {
                print("StreamDetailsView passed to ResetPage.")
            }
            
            // Navigate to ResetPage
            navigationController?.pushViewController(resetPageVC, animated: true)
        } else {
            print("Failed to instantiate ResetPage.")
        }
    }


    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

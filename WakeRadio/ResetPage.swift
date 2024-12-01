//
//  ResetPage.swift
//  WakeRadio
//

import UIKit

protocol ResetPageDelegate: AnyObject {
    func updateDJInfo(djName: String, djStyle: String)
}

class ResetPage: UIViewController {
    @IBOutlet weak var djNameTextField: UITextField!
    @IBOutlet weak var djStyleTextField: UITextField!
    
    weak var delegate: ResetPageDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func doneButtonTouched(_ sender: UIButton) {
        let updatedDJName = djNameTextField.text ?? ""
        let updatedDJStyle = djStyleTextField.text ?? ""

        // Pass the updated values to the StreamDetailsView
        delegate?.updateDJInfo(djName: updatedDJName, djStyle: updatedDJStyle)
        
        // Navigate back to the StreamDetailsView
        navigationController?.popViewController(animated: true)
    }
}

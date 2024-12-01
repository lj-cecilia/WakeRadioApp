import UIKit

class ResetPage: UIViewController {
    @IBOutlet weak var djNameTextField: UITextField!
    @IBOutlet weak var djStyleTextField: UITextField!

    var streamDetailsView: StreamDetailsView?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ResetPage loaded. StreamDetailsView is \(streamDetailsView == nil ? "nil" : "set").")
    }

    @IBAction func doneButtonTouched(_ sender: UIButton) {
        print("Updating DJ Info with Name: \(djNameTextField.text ?? ""), Style: \(djStyleTextField.text ?? "")")

        let updatedDJName = djNameTextField.text ?? ""
        let updatedDJStyle = djStyleTextField.text ?? ""

        // Update StreamDetailsView and save to UserDefaults
        streamDetailsView?.updateDJInfo(djName: updatedDJName, djStyle: updatedDJStyle)

        // Navigate back to StreamDetailsView
        navigationController?.popViewController(animated: true)
    }
}

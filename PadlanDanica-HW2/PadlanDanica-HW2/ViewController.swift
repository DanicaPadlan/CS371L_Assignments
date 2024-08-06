// Project: PadlanDanica-HW2
// EID: dmp3357
// Course: CS371L

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        userId.delegate = self
        password.delegate = self
    }

    //Called when 'Login' button is pressed
    @IBAction func buttonPressed(_ sender: Any) {
        let user = userId.text!
        
        //checks if userId and password text are not empty to display valid login text
        if(user != "" && password.text! != "") {
            loginStatusLabel.text = "\(user) logged in";
        } else {
            loginStatusLabel.text = "Invalid login";
        }
    }
    
    // Called when 'return' key pressed
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


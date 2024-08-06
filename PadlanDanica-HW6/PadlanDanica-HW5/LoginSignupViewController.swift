// Project: PadlanDanica-HW6
// EID: dmp3357
// Course: CS371L

import UIKit
import FirebaseAuth

class LoginSignupViewController: UIViewController {
    
    @IBOutlet weak var segCtrl: UISegmentedControl!
    
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var statusTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //intially hide the sign up view items
        //Default Login view
        confirmPasswordTextLabel.isHidden = true
        confirmPasswordTextField.isHidden = true
        loginButton.isHidden = false
        signupButton.isHidden = true
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    @IBAction func onSegmentedChange(_ sender: Any) {
        
        switch segCtrl.selectedSegmentIndex {
        case 0:
            
            //Login view
            confirmPasswordTextLabel.isHidden = true
            confirmPasswordTextField.isHidden = true
            loginButton.isHidden = false
            signupButton.isHidden = true
            
        case 1:
            
            //Sign up view
            confirmPasswordTextLabel.isHidden = false
            confirmPasswordTextField.isHidden = false
            loginButton.isHidden = true
            signupButton.isHidden = false
            
            
        default:
            print("No default action")
        }
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: userIdTextField.text!, password: passwordTextField.text!) {
            (authResult, error) in
            if let error = error as NSError? {
                self.statusTextLabel.text = "\(error.localizedDescription)"
            } else {
                self.statusTextLabel.text = ""
                
                //log user in
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        
        if(passwordTextField.text! != confirmPasswordTextField.text!){
            self.statusTextLabel.text = "Confirm password does not match password"
        } else {
            Auth.auth().createUser(withEmail: userIdTextField.text!, password: passwordTextField.text!) {
                (authResult, error) in
                if let error = error as NSError? {
                    self.statusTextLabel.text = "\(error.localizedDescription)"
                } else {
                    self.statusTextLabel.text = ""
                }
                
                //log in new user immediately
                if error == nil {
                    Auth.auth().signIn(withEmail: self.userIdTextField.text!, password: self.passwordTextField.text!)
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                 }
            }
        }
    }
    
}


// Project: PadlanDanica-HW7
// EID: dmp3357
// Course: CS371L

import UIKit

class AddTimerViewController: UIViewController {

    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var totalTimeTextField: UITextField!
    
    var delegate:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        //check if all fields are filled
        if(eventTextField.text == "" || locationTextField.text == "" || totalTimeTextField.text == ""){
            
            //create and display error alert
            let controller = UIAlertController(
                title: "Missing Fields",
                message: "Enter data in all fields to create a new timer",
                preferredStyle: .alert
            )
            
            controller.addAction(UIAlertAction(
                title: "OK",
                style: .default
            ))
            
            present(controller, animated: true)
            return
        }
        
        //create and add new Timer class to delegate's timer list
        let mainVC = delegate as? TimerManagement
        let newTime = Timer(
            event: eventTextField.text!,
            location: locationTextField.text!,
            remainingTime: Int(totalTimeTextField.text!)!
        )
        mainVC?.addTimer(newTimer: newTime)
    }
}

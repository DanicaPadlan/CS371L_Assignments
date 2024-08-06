// Project: PadlanDanica-HW3
// EID: dmp3357
// Course: CS371L

import UIKit

class TextChangeViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var delegate:UIViewController?
    var curText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.text = curText
    }
    

    //called when 'Save' button is pressed
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        //sets new String from text field to MainVC (delegate)
        let mainVC = delegate as? TextChanger
        mainVC?.changeText(newText: textField.text!)
    }
    
}

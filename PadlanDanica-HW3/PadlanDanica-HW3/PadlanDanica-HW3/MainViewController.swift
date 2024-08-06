// Project: PadlanDanica-HW3
// EID: dmp3357
// Course: CS371L

import UIKit

//protocol changes contents of text label
protocol TextChanger {
    func changeText(newText:String)
}

//protocol changes color of text label
protocol ColorChanger {
    func changeBackgroundColor(color:UIColor)
}

class MainViewController: UIViewController, TextChanger, ColorChanger {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        textLabel.text = "Text goes here"
    }

    //protocol function that sets new text in label
    func changeText(newText: String) {
        textLabel.text = newText
    }
    
    //protocol function that sets new color behind text label
    func changeBackgroundColor(color: UIColor) {
        textLabel.backgroundColor = color
    }
    
    // Sets up variable for segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Checks for certain segues
        if segue.identifier == "TextChangeSegueID",
            let nextVC = segue.destination as? TextChangeViewController
        {
            //sets next screen's delegate to this instantiated MainViewController
            nextVC.delegate = self
            
            //sets next screen's text field to current text in label
            nextVC.curText = textLabel.text!
        }
        
        else if segue.identifier == "ColorChangeSegueID",
            let nextVC = segue.destination as? ColorChangeViewController
        {
            //sets next screen's delegate to this instantiated MainViewController
            nextVC.delegate = self
        }
    }
    
}


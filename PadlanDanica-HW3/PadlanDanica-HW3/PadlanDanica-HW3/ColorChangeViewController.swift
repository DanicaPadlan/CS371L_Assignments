// Project: PadlanDanica-HW3
// EID: dmp3357
// Course: CS371L

import UIKit

class ColorChangeViewController: UIViewController {

    var delegate:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //called when 'Blue' button is pressed
    @IBAction func blueButtonPressed(_ sender: Any) {
        
        //changes background color of label to blue
        let mainVC = delegate as? ColorChanger
        mainVC?.changeBackgroundColor(color: UIColor.blue)
    }
    
    //called when 'Red' button is pressed
    @IBAction func redButtonPressed(_ sender: Any) {
        
        //changes background color of label to red
        let mainVC = delegate as? ColorChanger
        mainVC?.changeBackgroundColor(color: UIColor.red)
    }
    
}

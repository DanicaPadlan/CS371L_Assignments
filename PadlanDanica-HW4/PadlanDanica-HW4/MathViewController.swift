// Project: PadlanDanica-HW4
// EID: dmp3357
// Course: CS371L

import UIKit

class MathViewController: UIViewController {

    @IBOutlet weak var operand1: UITextField!
    @IBOutlet weak var operand2: UITextField!
    @IBOutlet weak var operatorSign: UILabel!
    @IBOutlet weak var result: UILabel!
    
    //variable that receives info from ViewController
    var operation = "Operator"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        //display appropriate sign according to operation
        if (operation == "Add") {
            operatorSign.text = "+"
        } else if (operation == "Subtract") {
            operatorSign.text = "-"
        } else if (operation == "Multiply") {
            operatorSign.text = "*"
        } else {
            operatorSign.text = "/"
        }
    }

    @IBAction func calculateButtonPressed(_ sender: Any) {
        
        //tests if values are either Int or Float
        let isValue1Valid = ((Int(operand1.text!) != nil) || (Float(operand1.text!) != nil)) ? true : false;
        let isValue2Valid = ((Int(operand2.text!) != nil) || (Float(operand2.text!) != nil)) ? true : false;
        
        //only performs math if all values are Ints or Floats
        if(isValue1Valid && isValue2Valid) {
            if ((Int(operand1.text!) != nil) && (Int(operand2.text!) != nil)) {
                
                //special case: checks if second operand is 0, otherwise display error
                if(Int(operand2.text!) == 0 && operation == "Divide"){
                    result.text = "Invalid operands, cannot divide by 0"
                } else {
                    let answer = calculateIntValue(value1: Int(operand1.text!)!, value2: Int(operand2.text!)!)
                    result.text = "\(answer)"
                }
                
            } else {
                
                //special case: checks if second operand is 0, otherwise display error
                if(Float(operand2.text!) == 0.0 && operation == "Divide"){
                    result.text = "Invalid operands, cannot divide by 0.0"
                } else {
                    let answer = calculateFloatValue(value1: Float(operand1.text!)!, value2: Float(operand2.text!)!)
                    result.text = "\(answer)"
                }
            }
        } else {
            
            //displayed if all values are not Ints or Floats
            result.text = "Invalid operands"
        }
    }
    
    //calculates Ints
    func calculateIntValue(value1:Int, value2:Int) -> Int {
        
        //checks what operation to do
        if (operation == "Add") {
            return value1 + value2
        } else if (operation == "Subtract") {
            return value1 - value2
        } else if (operation == "Multiply") {
            return value1 * value2
        }
        
        //assumes division operation
        return value1 / value2
    }
    
    //calculates Floats
    func calculateFloatValue(value1:Float, value2:Float) -> Float {
        
        //checks what operation to do
        if (operation == "Add") {
            return value1 + value2
        } else if (operation == "Subtract") {
            return value1 - value2
        } else if (operation == "Multiply") {
            return value1 * value2
        }
        
        //assumes division operation
        return value1 / value2
    }
}

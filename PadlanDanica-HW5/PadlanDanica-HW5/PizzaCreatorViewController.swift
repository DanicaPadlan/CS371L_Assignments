// Project: PadlanDanica-HW5
// EID: dmp3357
// Course: CS371L

import UIKit

class PizzaCreatorViewController: UIViewController {

    @IBOutlet weak var segCtrl: UISegmentedControl!
    @IBOutlet weak var orderSizeTextLabel: UILabel!
    @IBOutlet weak var orderCrustTextLabel: UILabel!
    @IBOutlet weak var orderCheeseTextLabel: UILabel!
    @IBOutlet weak var orderMeatTextLabel: UILabel!
    @IBOutlet weak var orderVeggiesTextLabel: UILabel!
    
    //saves users choice before instantiating Pizza object
    var delegate:UIViewController?
    var pSize:String = "small"
    var crust:String = ""
    var cheese:String = ""
    var meat:String = ""
    var veggies:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSegmentedChanged(_ sender: Any) {
        
        //checks which size index was chosen
        switch segCtrl.selectedSegmentIndex {
        case 0:
            self.pSize = "small"
            
        case 1:
            self.pSize = "medium"
            
        case 2:
            self.pSize = "large"
            
        default:
            self.pSize = "small"
        }
    }
    
    @IBAction func crustButtonPressed(_ sender: Any) {
        
        //creates and presents crust alert
        let controller = UIAlertController(
            title: "Select crust",
            message: "Choose a crust type:",
            preferredStyle: .alert
        )
        
        controller.addAction(UIAlertAction(
            title: "Thin Crust",
            style: .default,
            handler: {
                (action) in
                self.crust = "thin crust"
            }
        ))
        
        controller.addAction(UIAlertAction(
            title: "Thick Crust",
            style: .default,
            handler: {
                (action) in
                self.crust = "thick crust"
            }
        ))
        
        present(controller, animated: true)
    }
    
    @IBAction func cheeseButtonPressed(_ sender: Any) {
        
        //creates and presents cheese action sheet
        let controller = UIAlertController(
            title: "Select cheese",
            message: "Choose a cheese type:",
            preferredStyle: .actionSheet
        )
        
        controller.addAction(UIAlertAction(
            title: "Regular cheese",
            style: .default, 
            handler: {
                (action) in
                self.cheese = "regular cheese"
            }
        ))
        
        controller.addAction(UIAlertAction(
            title: "No cheese",
            style: .default, handler: {
                (action) in
                self.cheese = "no cheese"
            }
        ))
        
        controller.addAction(UIAlertAction(
            title: "Double cheese",
            style: .default, handler: {
                (action) in
                self.cheese = "double cheese"
            }
        ))
        
        present(controller, animated: true)
    }
    
    @IBAction func meatButtonPressed(_ sender: Any) {
        
        //creates and presents meat action sheet
        let controller  = UIAlertController(
            title: "Select meat",
            message: "Choose one meat:",
            preferredStyle: .actionSheet
        )
        
        controller.addAction(UIAlertAction(
            title: "Pepperoni",
            style: .default,
            handler: {
                (action) in
                self.meat = "pepperoni"
            }
        ))
        
        controller.addAction(UIAlertAction(
            title: "Sausage",
            style: .default,
            handler: {
                (action) in
                self.meat = "sausage"
            }
        ))
        
        controller.addAction(UIAlertAction(
            title: "Canadian Bacon",
            style: .default,
            handler: {
                (action) in
                self.meat = "canadian bacon"
            }
        ))
        
        present(controller, animated: true)
    }
    
    @IBAction func veggiesButtonPressed(_ sender: Any) {
        
        //creates and presents veggies action sheet
        let controller = UIAlertController(
            title: "Select veggies",
            message: "Choose your veggies:",
            preferredStyle: .actionSheet
        )
        
        controller.addAction(UIAlertAction(
            title: "Mushroom",
            style: .default,
            handler: {
                (action) in
                self.veggies = "mushroom"
            }
        ))
        
        controller.addAction(UIAlertAction(
            title: "Onion",
            style: .default,
            handler: {
                (action) in
                self.veggies = "onion"
            }
        ))
        
        controller.addAction(UIAlertAction(
            title: "Green Olive",
            style: .default,
            handler: {
                (action) in
                self.veggies = "green olive"
            }
        ))
        
        controller.addAction(UIAlertAction(
            title: "Black Olive",
            style: .default,
            handler: {
                (action) in
                self.veggies = "black olive"
            }
        ))
        
        controller.addAction(UIAlertAction(
            title: "None",
            style: .default,
            handler: {
                (action) in
                self.veggies = "none"
            }
        ))
        
        present(controller, animated: true)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        //check if any ingredients are missing
        var errorMessage:String = ""
        if (crust == "") {
            errorMessage = "Please select crust type."
        } else if (cheese == "") {
            errorMessage = "Please select cheese type."
        } else if (meat == "") {
            errorMessage = "Please select meat type."
        } else if (veggies == "") {
            errorMessage = "Please select veggies type."
        }
        
        //check if need to throw error alert
        if(errorMessage != ""){
            
            let controller = UIAlertController(
                title: "Missing ingredient",
                message: errorMessage,
                preferredStyle: .alert
            )
            
            controller.addAction(UIAlertAction(
                title: "OK",
                style: .default
            ))
            present(controller, animated: true)
    
        } else {
            
            //print order on PizzaCreatorViewController
            orderSizeTextLabel.text = "One \(pSize) pizza with:"
            orderCrustTextLabel.text = crust
            orderCheeseTextLabel.text = cheese
            orderMeatTextLabel.text = meat
            orderVeggiesTextLabel.text = veggies
            
            //create and add new Pizza class to delegate's pizza order list
            let mainVC = delegate as? PizzaOrder
            
            let newPizzaOrder =  Pizza(pSize: pSize, crust: crust, cheese: cheese, meat: meat, veggies: veggies)
            mainVC?.addPizzaOrder(newPizza: newPizzaOrder)
            
        }
    }
}

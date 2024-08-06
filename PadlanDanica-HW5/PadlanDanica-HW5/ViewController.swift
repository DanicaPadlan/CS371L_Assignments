// Project: PadlanDanica-HW5
// EID: dmp3357
// Course: CS371L

import UIKit

//list of pizza orders to display in table view
public var pizzaOrders = [Pizza]()

//protocol for adding Pizza order to list
protocol PizzaOrder {
    func addPizzaOrder(newPizza:Pizza)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PizzaOrder {

    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return size of pizzaOrder array
        return pizzaOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        //creates new cell for table view
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! PizzaTableViewCell
        
        //gets row from indexPath
        let row = indexPath.row
        let curPizza = pizzaOrders[row]
        
        //sets order text in text cell
        cell.pizzaSizeLabel?.text = curPizza.pSize
        cell.pizzaCrustLabel?.text = curPizza.crust
        cell.pizzaCheeseLabel?.text = curPizza.cheese
        cell.pizzaMeatLabel?.text = curPizza.meat
        cell.pizzaVeggieLabel?.text = curPizza.veggies
        
        return cell
    }
    
    //adds new Pizza class to list
    func addPizzaOrder(newPizza: Pizza) {
        pizzaOrders.append(newPizza)
        
        //reload table view to see new orders in main VC
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //check for certain segues
        if segue.identifier == "PizzaCreatorSegue",
           let nextVC = segue.destination as? PizzaCreatorViewController
        {
            
            //set next screen's delegate to this main view
            nextVC.delegate = self
            
        }
    }
}


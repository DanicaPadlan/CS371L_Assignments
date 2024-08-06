// Project: PadlanDanica-HW6
// EID: dmp3357
// Course: CS371L

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

//list of pizza orders to display in table view
public var pizzaOrders = [NSManagedObject]()

//protocol for adding Pizza order to list
protocol PizzaOrder {
    func addPizzaOrder(pSize:String, crust:String, cheese:String, meat:String, veggies:String)
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
    
    //reloads new pizzaOrder
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pizzaOrders = retrievePizza()
        tableView.reloadData()
    }

    //return size of pizzaOrder array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        //creates new cell for table view
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        
        //gets row from indexPath
        let row = indexPath.row
        let curPizza = pizzaOrders[row]
        
        var cellContent = "\(curPizza.value(forKey: "pSize")!)\n"
        cellContent += "\t\(curPizza.value(forKey: "crust")!)\n"
        cellContent += "\t\(curPizza.value(forKey: "cheese")!)\n"
        cellContent += "\t\(curPizza.value(forKey: "meat")!)\n"
        cellContent += "\t\(curPizza.value(forKey: "veggies")!)"
        
        //sets order text in text cell
        cell.textLabel?.text = cellContent

        return cell
    }
    
    //deletes Pizza from Core Data and table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("delete swipe function is being called")
        if editingStyle == .delete {
            let deletePizza = pizzaOrders[indexPath.row]
            pizzaOrders.remove(at: indexPath.row)
            context.delete(deletePizza)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveContext()
        }
    }
    
    //adds new Pizza class to list
    func addPizzaOrder(pSize:String, crust:String, cheese:String, meat:String, veggies:String) {

        //stores Pizza object into Core Data
        let pizza = NSEntityDescription.insertNewObject(
            forEntityName: "Pizza", into: context)
        
        pizza.setValue(pSize, forKey: "pSize")
        pizza.setValue(crust, forKey: "crust")
        pizza.setValue(cheese, forKey: "cheese")
        pizza.setValue(meat, forKey: "meat")
        pizza.setValue(veggies, forKey: "veggies")
        
        //save new pizza to CoreData
        saveContext()
    }
    
    //saves changes to CoreData
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //retrieves array of Pizzas
    func retrievePizza() -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Pizza")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
            
        } catch {
            print("Error occured while retrieving Pizza data")
            abort()
        }
        return fetchedResults!
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


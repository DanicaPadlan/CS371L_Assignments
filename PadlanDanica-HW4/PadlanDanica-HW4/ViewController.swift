// Project: PadlanDanica-HW4
// EID: dmp3357
// Course: CS371L

import UIKit

public let operations = ["Add", "Subtract", "Multiply", "Divide"]

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    let mathSegueIdentifier = "MathSegueIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //returns size of operations array
        return operations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //creates cell that will free itself if not in view
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        
        //extracts row from indexPath
        let row = indexPath.row
        
        //sets label
        cell.textLabel?.text = operations[row]
        return cell
    }
    
    //prepare function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //checks if mathSegueIdentifier
        if segue.identifier == mathSegueIdentifier,
           let destination = segue.destination as? MathViewController,
           let opIndex = tableView.indexPathForSelectedRow?.row
        {
            
            //send operation value based on row index
            destination.operation = operations[opIndex]
        }
    }
}


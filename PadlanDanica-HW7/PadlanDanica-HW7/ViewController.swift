// Project: PadlanDanica-HW7
// EID: dmp3357
// Course: CS371L

import UIKit

//list of Timers
public var timerList = [Timer]()

protocol TimerManagement {
    func addTimer(newTimer:Timer)
    func updateTime(newTime:Int)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TimerManagement {

    @IBOutlet weak var tableView: UITableView!
    var selectedIndex: IndexPath!
    
    let textCellIdentifier = "TextCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerList.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        performSegue(withIdentifier: "countDownSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! TimerTableViewCell
        
        //add information in cell
        let row = indexPath.row
        let curTimer = timerList[row]
        cell.eventTextLabel!.text = curTimer.event
        cell.locationTextLabel!.text = curTimer.location
        cell.timeTextLabel!.text = String(curTimer.remainingTime)
        
        return cell
    }
    
    func addTimer(newTimer: Timer) {
        //add timer to list
        timerList.append(newTimer)
        tableView.reloadData()
    }
    
    func updateTime(newTime: Int) {
        //update the selected timer and its cell
        timerList[selectedIndex.row].remainingTime = newTime
        let curCell = tableView.cellForRow(at: selectedIndex) as! TimerTableViewCell
        curCell.timeTextLabel.text = String(newTime)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check for certain segues
        if segue.identifier == "addTimerSegue",
           let nextVC = segue.destination as? AddTimerViewController
        {
            
            //set next screen's delegate to this main view
            nextVC.delegate = self
            
        } else if segue.identifier == "countDownSegue",
                  let nextVC = segue.destination as? CountdownViewController
        {

            //send selected timer's values
            let curTimer = timerList[selectedIndex.row]
            nextVC.curEvent = curTimer.event
            nextVC.curLocation = curTimer.location
            nextVC.curTime = curTimer.remainingTime
            
            //set next screen's delegate to this main view
            nextVC.delegate = self
        }
    }
}


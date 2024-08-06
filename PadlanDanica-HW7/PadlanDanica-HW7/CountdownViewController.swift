// Project: PadlanDanica-HW7
// EID: dmp3357
// Course: CS371L

import UIKit

class CountdownViewController: UIViewController {

    @IBOutlet weak var eventIDTextLabel: UILabel!
    @IBOutlet weak var locationIDTextLabel: UILabel!
    @IBOutlet weak var timeRemainingTextLabel: UILabel!
    
    var delegate:UIViewController!
    var curEvent: String = "eventTest"
    var curLocation: String = "locationTest"
    var curTime: Int = 0
    var queue: DispatchQueue!
    var isCountDownActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        eventIDTextLabel.text = curEvent
        locationIDTextLabel.text = curLocation
        timeRemainingTextLabel.text = String(curTime)
        
        //create new thread to update curTime
        queue = DispatchQueue(label: "countDown", qos:.utility)
        isCountDownActive = true
        
        queue.async {
            self.updateTimer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //stop updating the time
        isCountDownActive = false;
        
        //save new time and send to main VC to update remaining time in table view cell
        let mainVC = delegate as? TimerManagement
        mainVC?.updateTime(newTime: curTime)
    }
    
    func updateTimer(){
        while(isCountDownActive && curTime > 0) {
            
            //reduce time every second
            usleep(1000000)
            curTime-=1
            
            //update the text label on main thread
            DispatchQueue.main.async {
                self.timeRemainingTextLabel.text = String(self.curTime)
            }
        }
    }
}

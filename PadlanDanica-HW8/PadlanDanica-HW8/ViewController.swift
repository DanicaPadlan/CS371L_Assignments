// Project: PadlanDanica-HW8
// EID: dmp3357
// Course: CS371L

import UIKit
import UserNotificationsUI

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    var towerImage: Bool = true
    var buttonCount: Int8 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initially set button image to tower
        self.button.setImage(UIImage(named: "uttower"), for: .normal)
    }

    @IBAction func buttonPressed(_ sender: Any) {
        
        //switch what image will be shown and increase button counter
        towerImage = !towerImage
        buttonCount += 1
        
        //check what image will be changed to
        var newImage:UIImage!
        if(towerImage){
            newImage = UIImage(named: "uttower")
        } else {
            newImage = UIImage(named: "ut")
        }
        
        //fade out button with old image
        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            options: .curveEaseOut,
            animations: {
                self.button.alpha = 0.0
            },
            completion: {
                
                //switch image
                finished in
                    self.button.setImage(newImage, for: .normal)
                
                //fade in button with new image
                UIView.animate(
                    withDuration: 1.0,
                    delay: 0.0,
                    options: .curveEaseIn,
                    animations: {
                        self.button.alpha = 1.0
                    },
                    completion: {
                        finished in
                    }
                )
            }
        )
        
        //request notification access
        UNUserNotificationCenter.current().requestAuthorization(options: .badge) {
            (granted, error) in
            if granted {
                print("Notifications enabled")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        //check if need to send notification, only runs if notifcations are enabled
        if(buttonCount % 4 == 0) {
            print("creating notification")
            //create notifcation
            let notifContent = UNMutableNotificationContent()
            notifContent.title = "Click Count"
            notifContent.subtitle = "Incoming message from HW8: "
            notifContent.body = "You have clicked \(buttonCount) times"
            
            //create trigger for 8 seconds
            let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 8.0, repeats: false)
            
            //create and submit request
            let notifRequest = UNNotificationRequest(identifier: "myNotifiCation", content: notifContent, trigger: notifTrigger)
            UNUserNotificationCenter.current().add(notifRequest)
        }
    }
}


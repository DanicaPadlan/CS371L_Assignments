// Filename: PadlanDanica-HW10
// EID: dmp3357
// Course: CS371L

import UIKit

class DetailViewController: UIViewController {

    var incomingImage: UIImage?
    
    @IBOutlet weak var detailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        detailImage.image = incomingImage
    }


}

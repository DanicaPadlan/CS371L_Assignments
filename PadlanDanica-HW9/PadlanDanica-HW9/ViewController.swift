//
// Project: PadlanDanica-HW9
// EID: dmp3357
// Course: CS371L

import UIKit

class ViewController: UIViewController {

    var viewBox = UIView()
    var queue: DispatchQueue!
    
    var safeAreaMinX:CGFloat?
    var safeAreaMaxX:CGFloat?
    var safeAreaMinY:CGFloat?
    var safeAreaMaxY:CGFloat?
    
    var xGridPos = [CGFloat](repeating: 0, count: 9)
    var yGridPos = [CGFloat](repeating: 0, count: 19)
    
    var boxWidth:CGFloat?
    var boxHeight:CGFloat?
    
    //sets coordinate values to 4,9 as center
    var curXIndex = 4
    var curYIndex = 9
    
    //values to traverse the xGridPos and yGridPos will be -1, 0, 1
    var xDirection = 0
    var yDirection = 0
    
    var didStartTap = false
    var isBlockStopped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        
        //programatically add viewBox to view at the center
        safeAreaMinX = view.safeAreaLayoutGuide.layoutFrame.minX
        safeAreaMaxX = view.safeAreaLayoutGuide.layoutFrame.width
        safeAreaMinY = view.safeAreaLayoutGuide.layoutFrame.minY
        safeAreaMaxY = view.safeAreaLayoutGuide.layoutFrame.height

        boxWidth = safeAreaMaxX! / 9
        boxHeight = safeAreaMaxY! / 19

        calculatePositions()
        
        viewBox.frame = CGRect(
            x: xGridPos[curXIndex],
            y: yGridPos[curYIndex],
            width: boxWidth!,
            height: boxWidth!)
        viewBox.backgroundColor = .green
        view.addSubview(viewBox)
        
        //TODO: multithreading not working
        queue = DispatchQueue(label: "moveBox", qos:.utility)

        queue.async {
            self.updateBox()
        }
    }

    //fill xGridPos and yGridPos with all possible coordinates starting from safeAreaMin X and Y's
    func calculatePositions(){
        
        for xIndex in 0...8 {
            xGridPos[xIndex] = boxWidth! * CGFloat(xIndex) + safeAreaMinX!
        }
        
        for yIndex in 0...18 {
            yGridPos[yIndex] = boxHeight! * CGFloat(yIndex) + safeAreaMinY!
        }
    }
    
    //called asynchronously to update box movement
    func updateBox(){
        
        while(true){
            if(didStartTap){
                
                //update box every .3 seconds
                usleep(300000)
                
                let newXIndex = curXIndex + xDirection
                let newYIndex = curYIndex + yDirection
                
                //if in range, update new position
                if(newXIndex >= 0 && newXIndex < xGridPos.count && newYIndex >= 0 && newYIndex < yGridPos.count){
                    
                    //update position on main thread
                    DispatchQueue.main.async {
                        self.viewBox.frame.origin.x = self.xGridPos[newXIndex]
                        self.viewBox.frame.origin.y = self.yGridPos[newYIndex]
                    }
                    
                    curXIndex = newXIndex
                    curYIndex = newYIndex
                }
                
                //check when to change color
                //will go out of range, don't update the position but change the box color
                if(newXIndex >= xGridPos.count-1 || newXIndex <= 0 || newYIndex >= yGridPos.count-1 || newYIndex <= 0){
                    
                    //change to red to show its at the edge of the safe area and stop the game
                    DispatchQueue.main.async {
                        self.viewBox.backgroundColor = .red
                        self.isBlockStopped = true
                        self.didStartTap = false
                    }
                } else {
                    
                    //change back to green if within safe area but still red
                    DispatchQueue.main.async {
                        if self.viewBox.backgroundColor != .green {
                            self.viewBox.backgroundColor = .green
                        }
                    }
                }
            }
        }
    }
    

    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
        //trigger if haven't started yet
        if(!didStartTap){
            didStartTap = true
            
            //set direction to only go down the screen aka increase in yIndex
            xDirection = 0
            yDirection = 1
        }
        
        //tapping only works if block was stopped
        if(isBlockStopped){
            
            //turn swiping back on
            isBlockStopped = false
            
            //reset position to center (4, 9) and color to green
            curXIndex = 4
            curYIndex = 9
            
            DispatchQueue.main.async {
                self.viewBox.frame.origin.x = self.xGridPos[self.curXIndex]
                self.viewBox.frame.origin.y = self.yGridPos[self.curYIndex]
                self.viewBox.backgroundColor = .green
            }
        }
    }
    
    @IBAction func handleUpSwipe(_ sender: UISwipeGestureRecognizer) {
    
        //valid if block has not stopped
        if(!isBlockStopped){
            
            //set direction to only go up the screen aka decrease in yIndex
            xDirection = 0
            yDirection = -1
        } else {
            didStartTap = false
        }
    }
    
    @IBAction func handleDownSwipe(_ sender: UISwipeGestureRecognizer) {
        
        //valid if block has not stopped
        if(!isBlockStopped){
            
            //set direction to only go down the screen aka increase in yIndex
            xDirection = 0
            yDirection = 1
        } else {
            didStartTap = false
        }
    }
    
    
    @IBAction func handleLeftSwipe(_ sender: UISwipeGestureRecognizer) {
        
        //valid if block has not stopped
        if(!isBlockStopped){
            
            //set direction to only go to left of the screen aka decrease in xIndex
            xDirection = -1
            yDirection = 0
        } else {
            didStartTap = false
        }
    }
    
    @IBAction func handleRightSwipe(_ sender: Any) {
        
        //valid if block has not stopped
        if(!isBlockStopped){
            
            //set direction to only go to right of the screen aka increase in xIndex
            xDirection = 1
            yDirection = 0
        } else {
            didStartTap = false
        }
    }
}


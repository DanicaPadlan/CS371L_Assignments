// Project: PadlanDanica-HW7
// EID: dmp3357
// Course: CS371L

public class Timer {
    var event:String
    var location:String
    var remainingTime:Int
    
    init(event:String, location:String, remainingTime:Int) {
        self.event = event
        self.location = location
        self.remainingTime = remainingTime
    }
}

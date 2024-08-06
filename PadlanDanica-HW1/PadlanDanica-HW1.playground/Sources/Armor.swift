// Project: PadlanDanica-HW1
// EID: dmp3357
// Course: CS371L

public class Armor {
    let armorType:String
    let armorProtection:Int
    
    public init(armorType:String) {
        self.armorType = armorType
        
        //sets armor protection based on weapon type
        if (armorType == "plate") {
            armorProtection = 2
        } else if (armorType == "chain") {
            armorProtection = 5
        } else if (armorType == "leather") {
            armorProtection = 8
        } else {
            //assumes "none" case
            armorProtection = 10
        }
    }
}

// Project: PadlanDanica-HW1
// EID: dmp3357
// Course: CS371L

public class Weapon {
    let weaponType:String
    let weaponDamage:Int
    
    public init(weaponType:String) {
        self.weaponType = weaponType
        
        //sets weapon damage based on weapon type
        if (weaponType == "dagger") {
            weaponDamage = 4
        } else if (weaponType == "axe") {
            weaponDamage = 6
        } else if (weaponType == "staff") {
            weaponDamage = 6
        } else if (weaponType == "sword") {
            weaponDamage = 10
        } else {
            //assumes "none" case
            weaponDamage = 1
        }
    }
}

// Project: PadlanDanica-HW1
// EID: dmp3357
// Course: CS371L

public class Fighter:RPGCharacter {

    public convenience init(name:String) {
        self.init(name: name, health: 40, spellPoints: 0, weapon: Weapon(weaponType: "none"), armor: Armor(armorType: "none"))
    }
}

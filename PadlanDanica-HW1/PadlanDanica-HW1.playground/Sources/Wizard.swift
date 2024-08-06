// Project: PadlanDanica-HW1
// EID: dmp3357
// Course: CS371L

public class Wizard:RPGCharacter {

    public convenience init(name:String) {
        self.init(name: name, health: 16, spellPoints: 20, weapon: Weapon(weaponType: "none"), armor: Armor(armorType: "none"))
    }
    
    //overriden functions that set weapon and armor
    public override func wield(weaponObject:Weapon) {
        let weaponType:String = weaponObject.weaponType
        
        //checking for valid weapons
        if (weaponType == "dagger" || weaponType == "staff" || weaponType == "none") {
            self.weapon = weaponObject
            print("\(name) is now wielding a(n) \(self.weapon.weaponType)")
        } else {
            print("Weapon not allowed for this character class.")
        }
    }
    
    public override func putOnArmor(armorObject: Armor) {
        print("Armor not allowed for this character class.")
    }
    
    //only Wizards can cast spell on target character
    public func castSpell(spellName:String, target:RPGCharacter) {
        print("\(name) casts \(spellName) at \(target.name)")
        
        //check for valid spell names
        if (spellName == "Fireball") {
            checkSpell(spellName: "Fireball", spellCost: 3, spellEffect: 5, target: target)
        } else if (spellName == "Lightning Bolt") {
            checkSpell(spellName: "Lightning Bolt", spellCost: 10, spellEffect: 10, target: target)
        } else if (spellName == "Heal") {
            checkSpell(spellName: "Heal", spellCost: 6, spellEffect: -6, target: target)
        } else {
            print("Unknown spell name. Spell failed.")
        }
    }
    
    //helper function for castSpell()
    private func checkSpell(spellName:String, spellCost:Int, spellEffect:Int, target:RPGCharacter) {
        //checks if spellCost > spellPoints
        if (spellPoints < spellCost) {
            print("Insufficient spell points")
            return
        }
        
        //adjust opponent health and current spell points
        let prevHealth = target.health
        target.health -= spellEffect
        spellPoints -= spellCost
        
        //checks for "Heal" print case
        if (spellName == "Heal") {
            //checks if health goes past max health
            target.health = min(target.health, target.maxHealth)
            print("\(name) heals \(target.name) for \(target.health - prevHealth) health points")
            print("\(target.name) is now at \(target.health) health")
        } else {
            print("\(name) does \(spellEffect) damage to \(target.name)")
            print("\(target.name) is now down to \(target.health) health")
        }
        
        //checks for opponent's status
        checkForDefeat(character: target)
    }
}

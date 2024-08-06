// Project: PadlanDanica-HW1
// EID: dmp3357
// Course: CS371L

public class RPGCharacter {
    let name:String
    var health:Int
    var maxHealth:Int
    var spellPoints:Int
    var weapon:Weapon
    var armor:Armor
    
    init(name:String, health:Int, spellPoints:Int, weapon:Weapon, armor:Armor) {
        self.name = name
        self.health = health
        self.maxHealth = health
        self.spellPoints = spellPoints
        self.weapon = weapon
        self.armor = armor
    }
    
    //functions that set/unset weapons and armor
    public func wield(weaponObject:Weapon) {
        weapon = weaponObject
        print("\(name) is now wielding a(n) \(weapon.weaponType)")
    }
    
    public func unwield() {
        weapon = Weapon(weaponType: "none")
        print("\(name) is no longer wielding anything.")
    }
    
    public func putOnArmor(armorObject:Armor) {
        armor = armorObject
        print("\(name) is now wearing \(armor.armorType)")
    }
    
    public func takeOffArmor() {
        armor = Armor(armorType: "none")
        print("\(name) is no longer wearing any armor.")
    }
    
    //damages to opponent
    public func fight(opponent:RPGCharacter) {
        print("\(name) attacks \(opponent.name) with a(n) \(weapon.weaponType)")
        
        //adjust opponent health
        opponent.health -= weapon.weaponDamage
        print("\(name) does \(weapon.weaponDamage) damage to \(opponent.name)")
        
        //checks opponent's status
        print("\(opponent.name) is now down to \(opponent.health) health")
        checkForDefeat(character: opponent)
    }
    
    //shows character's status
    public func show() {
        print(name)
        print(" Current Health: \(health)")
        print(" Current Spell Points: \(spellPoints)")
        print(" Wielding: \(weapon.weaponType)")
        print(" Wearing: \(armor.armorType)")
        print(" Armor class: \(armor.armorProtection)")
    }
    
    //checks if player was defeated
    public func checkForDefeat(character:RPGCharacter) {
        if (character.health <= 0) {
            print("\(character.name) has been defeated!")
        }
    }
}

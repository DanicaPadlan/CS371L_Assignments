// Project: PadlanDanica-HW1
// EID: dmp3357
// Course: CS371L

// top level code

let plateMail = Armor(armorType: "plate")
let chainMail = Armor(armorType: "chain")
let sword = Weapon(weaponType: "sword")
let staff = Weapon(weaponType: "staff")
let axe = Weapon(weaponType: "axe")

let gandalf = Wizard(name: "Gandalf the Grey")
gandalf.wield(weaponObject: staff)

let aragorn = Fighter(name: "Aragorn")

aragorn.putOnArmor(armorObject: plateMail)
aragorn.wield(weaponObject: axe)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Fireball", target: aragorn)
aragorn.fight(opponent: gandalf)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Lightning Bolt", target: aragorn)
aragorn.wield(weaponObject: sword)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Heal", target: gandalf)
aragorn.fight(opponent: gandalf)

gandalf.fight(opponent: aragorn)
aragorn.fight(opponent: gandalf)

gandalf.show()
aragorn.show()

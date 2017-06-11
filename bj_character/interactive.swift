//
//  commands.swift
//  Characters
//
//  Created by Sydney Polk on 4/27/17.
//
//

import Foundation

var creaturesController: CreaturesController?

enum Commands: Hashable {
    case database_open
    case database_create
    case list_characters
    case display_character
    case create_character
    case edit_character
    case delete_character
    case help
    case quit
}

let option_strings: [String:Commands] = [
    "1": .list_characters,
    "2": .display_character,
    "3": .create_character,
    "4": .edit_character,
    "5": .delete_character,
    "6": .database_open,
    "0": .quit
]

let help_text: [Commands:String] = [
    .database_open : "open or create a given database file",
    .list_characters : "list the characters by name for the currently open databae file",
    .display_character : "display all of the attributes of the given character",
    .create_character : "start the character creation wizard",
    .edit_character : "edit a given character",
    .delete_character : "delete a given character",
    .help : "display help commands or help for a specific command",
    .quit: "quit the app after saving the database"
]

func database_open() -> Bool {
    print("database_open")

    print("Database name [default]: ", terminator:"")
    if let name = readLine() {
        print("name = " + name)
        creaturesController = CreaturesController.sharedCreaturesController(CharactersContext(forTest: false, name: name))
        guard let _ = creaturesController else {
            print("Database " + name + " not opened or created.")
            return true
        }
    }
    return true
}

func list_characters() -> Bool {
    print("list_characters")
    if let controller = creaturesController {
        controller.logAll()
    } else {
        print("No characters found.")
    }
    return true
}

func display_character() -> Bool {
    print("display_character")
    return true
}

func creatureWithAssignedAbilities() -> Creature? {

    var creature: Creature? = nil

    var str = 10, dex = 10, con = 10, int = 10, wis = 10, cha = 10

    print("Strength: ", terminator:"")
    if let strength = readLine() {
        if let value = Int(strength) {
            str = value
        }
    }

    print("Dexterity: ", terminator:"")
    if let dexterity = readLine() {
        if let value = Int(dexterity) {
            dex = value
        }
    }

    print("Constitution: ", terminator:"")
    if let constitution = readLine() {
        if let value = Int(constitution) {
            con = value
        }
    }

    print("Intelligence: ", terminator:"")
    if let intelligence = readLine() {
        if let value = Int(intelligence) {
            int = value
        }
    }

    print("Wisdom: ", terminator:"")
    if let wisdom = readLine() {
        if let value = Int(wisdom) {
            wis = value
        }
    }

    print("Charisma: ", terminator:"")
    if let charisma = readLine() {
        if let value = Int(charisma) {
            cha = value
        }
    }

    creature = Creature(system: "Pathfinder", strength: str, dexterity: dex, constitution: con, intelligence: int, wisdom: wis, charisma: cha)

    return creature
}

func generate4d6best3() -> Int {
    return Dice.roll(number: 4, dieType: 6, bonus: 0, best: 3)
}

func generate3d6() -> Int {
    return Dice.roll(number: 3, dieType: 6, bonus: 0)
}

func generate2d6plus6() -> Int {
    return Dice.roll(number: 2, dieType: 6, bonus: 6)
}

func creatureWithChosenRolls(rolls: [Int]) -> Creature? {
    var creature: Creature? = nil

    var _rolls = rolls

    var str = 10, dex = 10, con = 10, int = 10, wis = 10, cha = 10

    print("Choose which roll for the various abilities.")
    var i = 1
    for roll in _rolls {
        print("\(i). \(roll)")
        i += 1
    }
    print("Strength: ", terminator: "")
    if let choiceStr = readLine() {
        let choice = Int(choiceStr)! - 1
        str = _rolls[choice]
        _rolls.remove(at: choice)
    }

    i = 1
    for roll in _rolls {
        print("\(i).\(roll)")
        i += 1
    }
    print("Dexterity: ", terminator: "")
    if let choiceStr = readLine() {
        let choice = Int(choiceStr)! - 1
        dex = _rolls[choice]
        _rolls.remove(at: choice)
    }

    i = 1
    for roll in _rolls {
        print("\(i).\(roll)")
        i += 1
    }
    print("Constituion: ", terminator: "")
    if let choiceStr = readLine() {
        let choice = Int(choiceStr)! - 1
        con = _rolls[choice]
        _rolls.remove(at: choice)
    }

    i = 1
    for roll in _rolls {
        print("\(i).\(roll)")
        i += 1
    }
    print("Intelligence: ", terminator: "")
    if let choiceStr = readLine() {
        let choice = Int(choiceStr)! - 1
        int = _rolls[choice]
        _rolls.remove(at: choice)
    }

    i = 1
    for roll in _rolls {
        print("\(i).\(roll)")
        i += 1
    }
    print("Wisdom: ", terminator: "")
    if let choiceStr = readLine() {
        let choice = Int(choiceStr)! - 1
        wis = _rolls[choice]
        _rolls.remove(at: choice)
    }

    i = 1
    for roll in _rolls {
        print("\(i).\(roll)")
        i += 1
    }
    print("Charisma: ", terminator: "")
    if let choiceStr = readLine() {
        let choice = Int(choiceStr)! - 1
        cha = _rolls[choice]
        _rolls.remove(at: choice)
    }

    creature = Creature(system: "Pathfinder", strength: str, dexterity: dex, constitution: con, intelligence: int, wisdom: wis, charisma: cha)

    return creature
}

func creatureWithRoller(roller: ()->Int) -> Creature? {
    var rolls: [Int] = []

    var queue = PriorityQueue<Int>()
    for _ in 1...6 {
        let roll = roller()
        queue.push(roll)
    }

    for roll in queue {
        rolls.append(roll)
    }
    
    return creatureWithChosenRolls(rolls: rolls)
}

func chooseFromPool(rolls: [Int]) -> Int {
    var lines = 0
    var roll_number = -1
    while (roll_number == -1) {
        for i in 0...rolls.count-1 {
            if i < 9 {
                print(" ", terminator:"")
            }
            print("\(i + 1). \(rolls[i])", terminator:"")
            if lines == 5 {
                print("")
                lines = 0
            } else {
                print(" ", terminator:"")
                lines += 1
            }
        }
        if (lines != 0) {
            print("")
        }
        print("Roll number: ", terminator: "")
        if let choice_str = readLine() {
            if let choice = Int(choice_str) {
                roll_number = choice
            }
        }
    }
    return roll_number
}

func creatureWithDicePool(dice: Int) -> Creature? {
    var rolls: [Int] = []

    func pull_from_dice_pool(prompt: String) -> Int {
        print ("Choose 3 rolls for \(prompt): ")
        var total = 0
        for _ in 1...3 {
            let roll_number = chooseFromPool(rolls: rolls)
            let roll = rolls[roll_number - 1]
            rolls.remove(at: roll_number - 1)
            total += roll
        }
        return total
    }

    var queue = PriorityQueue<Int>()

    for _ in 1...dice {
        let roll = Dice.roll(number: 1, dieType: 6, bonus: 0)
        queue.push(roll)
    }

    for roll in queue {
        rolls.append(roll)
    }

    let str = pull_from_dice_pool(prompt: "Strength")
    let dex = pull_from_dice_pool(prompt: "Dexterity")
    let con = pull_from_dice_pool(prompt: "Constitution")
    let int = pull_from_dice_pool(prompt: "Intelligence")
    let wis = pull_from_dice_pool(prompt: "Wisdom")
    let cha = pull_from_dice_pool(prompt: "Charisma")

    return Creature(system: "Pathfinder", strength: str, dexterity: dex, constitution: con, intelligence: int, wisdom: wis, charisma: cha)

}

func create_character() -> Bool {
    print("create_character")

    print("Character name: ", terminator:"")
    if let name = readLine() {
        if let controller = creaturesController {
            print("Please select how you want to generate abilities.")
            print("1. Enter scores")
            print("2. Standard (4d6 best 3, choose which scores go with which abilities)")
            print("3. Classic (3d6, choose which scores go with which abilities")
            print("4. Heroic (2d6+6, choose which scores go with which abilities")
            print("5. Standard dice pool (24d6, make 6 abilities with 3 rolls")
            print("6. Heroic dice pool (28d6, make 6 abilities with 3 rolls")
            print("7. Use points")
            print("Choice: ", terminator:"")
            var creature: Creature? = nil
            while true {
                if let choice = readLine() {
                    if choice == "1" {
                        creature = creatureWithAssignedAbilities()
                        break
                    } else if choice == "2" {
                        creature = creatureWithRoller(roller: generate4d6best3)
                        break
                    } else if choice == "3" {
                        creature = creatureWithRoller(roller: generate3d6)
                        break
                    } else if choice == "4" {
                        creature = creatureWithRoller(roller: generate2d6plus6)
                        break
                    } else if choice == "5" {
                        creature = creatureWithDicePool(dice: 24)
                        break
                    } else if choice == "6" {
                        creature = creatureWithDicePool(dice: 28)
                        break
                    } else {
                        print("Not supported yet.")
                    }
                }
            }

            if let creat = creature {
                let model = try! controller.createCreature(name, withSystem: "Pathfinder", withCreature: creat)
                if let _ = model.creature {
                    print("\(name) created.")
                } else {
                    print("\(name) created by the creature structure is missing.")
                }
            } else {
                print("No creature created.")
            }
        } else {
            print("No creaturesController")
        }
    } else {
        print("Nothing created.")
    }

    return true
}

func edit_character() -> Bool {
    print("edit_character")
    return true
}

func delete_character() -> Bool {
    print("delete_character")
    return true
}

func help() -> Bool {
    return true
}

func quit() -> Bool {
    return false
}

let command_map : [Commands:()->Bool] = [
    .database_open : database_open,
    .list_characters : list_characters,
    .display_character : display_character,
    .create_character : create_character,
    .edit_character : edit_character,
    .delete_character : delete_character,
    .help : help,
    .quit: quit
]

func prompt() -> String {
    print("1. List existing characters")
    print("2. Display character")
    print("3. Create character")
    print("4. Edit character")
    print("5. Delete character")
    print("6. Open character database")
    print("0. Quit")

    print("")
    print("Command: ", terminator:"")

    if let command = readLine() {
        return command
    }
    return ""
}

func process_command(command_string: String) -> Bool {
    if let command = option_strings[command_string] {
        return command_map[command]!()
    } else {
        print("Unknown option " + command_string)
    }
    return true
}

func process_interactive() {
    print("Welcome to the Bone Jarring Creature Command Line Utility.")

    var executing = true;

    while (executing) {
        let command = prompt()
        if command != "" {
            executing = process_command(command_string: command)
        }
    }
}

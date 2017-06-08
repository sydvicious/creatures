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

func create_character() -> Bool {
    print("create_character")

    print("Character name: ", terminator:"")
    if let name = readLine() {
        if let controller = creaturesController {
            let model = try! controller.createCreature(name)
            if let _ = model.creature {
                print("\(name) created.")
            } else {
                print("\(name) created by the creature structure is missing.")
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

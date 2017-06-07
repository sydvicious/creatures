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
    "-o": .database_open,
    "--open": .database_open,
    "6": .database_open,
    "-l": .list_characters,
    "--list": .list_characters,
    "1": .list_characters,
    "-d": .display_character,
    "--display": .display_character,
    "2": .display_character,
    "-c": .create_character,
    "--create": .create_character,
    "3": .create_character,
    "-e": .edit_character,
    "--edit": .edit_character,
    "4": .edit_character,
    "-x": .delete_character,
    "--delete": .delete_character,
    "5": .delete_character,
    "-h": .help,
    "--help": .help,
    "-?": .help,
    "-q": .quit,
    "--exit": .quit,
    "--quit": .quit,
    "--bye": .quit,
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

    creaturesController = CreaturesController.sharedCreaturesController(CharactersContext(false))
    return true
}

func list_characters() -> Bool {
    return true
}

func display_character() -> Bool {
    return true
}

func create_character() -> Bool {
    return true
}

func edit_character() -> Bool {
    return true
}

func delete_character() -> Bool {
    return true
}

func help() -> Bool {
    return true
}

func quit() -> Bool {
    return false
}

// Generic commands

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

func usage() {
    let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
    
    print("usage:")
    print("\(executableName) (no option) - interactive mode")
    print("\(executableName) -h - display help")
    print("\(executableName) -i - enter interactive mode after other options processed")
}

func process_command(command_string: String) -> Bool {
    if let command = option_strings[command_string] {
        return command_map[command]!()
    } else {
        print("Unknown option " + command_string)
    }
    return true
}

//
//  commands.swift
//  Characters
//
//  Created by Sydney Polk on 4/27/17.
//
//

import Foundation

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

let single_dash_options: [String:Commands] = [
    "o": .database_open,
    "l": .list_characters,
    "d": .display_character,
    "c": .create_character,
    "e": .edit_character,
    "x": .delete_character,
    "h": .help,
    "q": .quit
]

let whole_word_options: [String:Commands] = [
    "open": .database_open,
    "list": .list_characters,
    "display": .display_character,
    "create": .create_character,
    "edit": .edit_character,
    "delete": .delete_character,
    "help": .help,
    "qquit": .quit

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

class CommandProcessor {
    
    class func usage() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        print("usage:")
        print("\(executableName) (no option) - interactive mode")
        print("\(executableName) -h - display help")
        print("\(executableName) -i - enter interactive mode after other options processed")
    }
}

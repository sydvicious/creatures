//
//  main.swift
//  bj_character
//
//  Created by Syd Polk on 4/20/17.
//
//

import Foundation

let arguments = CommandLine.arguments

if arguments.count > 1 {
    let args = Array(arguments[1..<arguments.count])
    for arg in args {
        _ = process_command(command_string: arg)
    }
} else {
    print("Welcome to the Bone Jarring Creature Command Line Utility.")
    print("1. List existing characters")
    print("2. Display character")
    print("3. Create character")
    print("4. Edit character")
    print("5. Delete character")
    print("6. Open character database")
    print("0. Quit")

    print("")

    var executing = true;

    while (executing) {
        print("Command: ", terminator:"")
        if let command = readLine() {
            executing = process_command(command_string: command)
        }
    }

}

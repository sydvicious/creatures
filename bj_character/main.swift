//
//  main.swift
//  bj_character
//
//  Created by Syd Polk on 4/20/17.
//
//

import Foundation


print("Welcome to the Bone Jarring Creature Command Line Utility.")

let creaturesController = CreaturesController.sharedCreaturesController(CharactersContext(false))


print("1. List existing characters")
print("2. Display character")
print("3. Create character")
print("4. Edit character")
print("5. Delete character")
print("6. Quit")
print("Command: ", terminator:"")

var raw_input : String?
var process_commands = true;

while (process_commands) {
    
}


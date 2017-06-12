//
//  batch.swift
//  Characters
//
//  Created by Sydney Polk on 4/27/17.
//  Copyright (c) 2017 Bone Jarring Games and Software, LLC. All rights reserved.
//
//

import Foundation

func usage() {
    let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent

    print("usage:")
    print("\(executableName) (no option) - interactive mode")
    print("\(executableName) -h - display help")
    print("\(executableName) -i - enter interactive mode after other options processed")
}


func process_batch_command(command_string: String) -> Bool {
    return false
}

func process_batch_commands(args: [String]) -> () {
    for arg in args {
        if !process_batch_command(command_string: arg) {
            break
        }
    }
}


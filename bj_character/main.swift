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
    process_batch_commands(args: args)
} else {
    process_interactive()
}

// Created by: MF-ROB
// Created on: Oct 2026
// This program reads a file (input.txt) with integers on each line,
// calculates the sum of each line using a loop, and writes the sums
// to output.txt. If a line is empty or contains something that is not
// an integer, an error message is written to output.txt instead.

import Foundation

do {
    let content = try String(contentsOfFile: "input.txt", encoding: .utf8)
    var lines = content.components(separatedBy: .newlines)
    if lines.last == "" { lines.removeLast() }  // ignore the empty piece after the final newline

    var output = ""
    var lineNumber = 0

    for rawLine in lines {
        lineNumber += 1
        let line = rawLine.trimmingCharacters(in: .whitespaces)

        if line.isEmpty {
            output += "Line \(lineNumber): Error - empty line\n"
            continue
        }

        let parts = line.split(separator: " ")
        var sum = 0
        var badValue: String? = nil

        for part in parts {
            if let number = Int(part) {
                sum += number
            } else {
                badValue = String(part)
                break
            }
        }

        if let bad = badValue {
            output += "Line \(lineNumber): Error - \"\(bad)\" is not an integer\n"
        } else {
            output += "Line \(lineNumber): Sum = \(sum)\n"
        }
    }

    try output.write(toFile: "output.txt", atomically: true, encoding: .utf8)
} catch {
    print("File error: \(error.localizedDescription)")
}
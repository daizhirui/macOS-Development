//: Playground - noun: a place where people can play

import Cocoa

let projectURL = URL(fileURLWithPath: "/Users/daizhirui/Documents/Developments/Camel-Micro/M2Example/Hello")

if let rootFileWrapper = try? FileWrapper(url: projectURL, options: .immediate) {
    print(rootFileWrapper.filename ?? "")
    if let libFileWrapper = rootFileWrapper.fileWrappers?["lib"] {
        print(libFileWrapper.filename!)
    }
    print(">>>>>>>>>>>>>>>>>>>>")
    if let firstLevelFileWrappers = rootFileWrapper.fileWrappers {
        for (name, fileWrapper) in firstLevelFileWrappers {
            print(name)
            print(fileWrapper.preferredFilename!)
        }
    }
    
}

func runCommand(run command: String, with arguments: [String]) -> (String?, String?) {
    // Create a Process instance
    let task = Process()
    // Set the process parameters
    task.launchPath = command
    task.arguments = arguments
    // Create a Pip and make the task
    // put all the output there
    let stdPipe = Pipe()
    let errorPipe = Pipe()
    task.standardOutput = stdPipe
    task.standardError = errorPipe
    // Launch the task
    task.launch()
    // Get the data
    let stdData = stdPipe.fileHandleForReading.readDataToEndOfFile()
    let stdOutput = String(data: stdData, encoding: String.Encoding.utf8)
    let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
    let errorOutput = String(data: errorData, encoding: String.Encoding.utf8)
    return (stdOutput, errorOutput)
}

FileManager.default.changeCurrentDirectoryPath(projectURL.relativePath)
let (stdOutput, errorOutput) = runCommand(run: "/usr/bin/make", with: [])
print(stdOutput!)
print(errorOutput!)

let joinedString = [""].joined(separator: " ").trimmingCharacters(in: .whitespaces)
let sepString = joinedString.components(separatedBy: .whitespaces)
print(sepString)

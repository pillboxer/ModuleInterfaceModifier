//
//  PatchHelper.swift
//  ModuleInterfaceModifier
//
//  Created by Henry Cooper on 11/04/2021.
//

import Diglet

enum PatchError: LocalizedError, Equatable {
    case couldNotDiscoverModuleName
    case disallowedFormat
    case couldNotReadFile
    case nothingToDo
    
    var localizedDescription: String {
        switch self {
        case .couldNotDiscoverModuleName:
            return "Could not find name of module"
        case .disallowedFormat:
            return "Unrecognized format. Allowed formats:\n\(PatchHelper.AcceptedPath.commaSeparatedCases)"
        case .couldNotReadFile:
            return "Unable to read file"
        case .nothingToDo:
            return "Looks like this file is already patched."        }
    }
}

class PatchHelper {
    
    enum AcceptedPath: String, CaseIterable {
        case xcframework
        case swiftinterface
        case swiftmodule
        case modules
        case framework
        
        static func isAcceptedPath(_ string: String) throws {
            let rawValues = allCases.map { $0.rawValue }
            if !rawValues.contains(string.lowercased()) {
                throw PatchError.disallowedFormat
            }
        }
        
        static var commaSeparatedCases: String {
            let cases = allCases.map { $0.rawValue }
            return cases.joined(separator: ",\n")
        }
        
    }
    
    @discardableResult func attemptPatch(on url: URL) throws -> String {
        
        try AcceptedPath.isAcceptedPath(url.pathExtension)
        
        if let folder = Diglet.folderAt(url: url) {
            return try attemptPatch(on: folder)
        }
        else if let file = Diglet.fileAt(url: url) {
            return try attemptPatch(on: file)
        }
        throw PatchError.couldNotReadFile
    }
    
    private func attemptPatch(on folder: Folder) throws -> String {
        #warning("Fix Me")
        print("Attempting patch on \(folder)")
        throw PatchError.nothingToDo
    }
    
    private func attemptPatch(on file: File) throws -> String {
        
        guard let fileContents = Diglet.read(file: file) else {
            throw PatchError.couldNotReadFile
        }
     
        do {
            let moduleName = try discoverModuleNameFrom(fileContents)
            let toReplace = moduleName + "."
            if !fileContents.contains(toReplace) {
                throw PatchError.nothingToDo
            }
            let newContents = fileContents.replacingOccurrences(of: toReplace, with: "")
            try Diglet.write(newContents, to: file)
            return file.name
        }
    }
    
    private func discoverModuleNameFrom(_ contents: String) throws -> String {
        
        guard let lastComponent = contents.components(separatedBy: "-module-name").last,
              let moduleName = lastComponent.components(separatedBy: "\n").first else {
            throw PatchError.couldNotDiscoverModuleName
        }
        return moduleName
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

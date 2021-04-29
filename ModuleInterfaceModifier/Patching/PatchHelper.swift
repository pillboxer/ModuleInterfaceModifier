//
//  PatchHelper.swift
//  ModuleInterfaceModifier
//
//  Created by Henry Cooper on 11/04/2021.
//

import Diglet

class PatchHelper {
    
    private enum AcceptedPath: String, CaseIterable {
        case xcframework
        case swiftinterface
        case swiftmodule
        case modules
        case framework
        
        static func isAcceptedPath(_ string: String) -> Bool {
            let rawValues = allCases.map { $0.rawValue }
            return rawValues.contains(string.lowercased())
        }
        
    }
    
    @discardableResult func attemptPatch(on url: URL) -> Bool {
        if let folder = Diglet.folderAt(url: url) {
            return attemptPatch(on: folder)
        }
        else if let file = Diglet.fileAt(url: url) {
            return attemptPatch(on: file)
        }
        return false
    }
    
    private func attemptPatch(on folder: Folder) -> Bool {
        print("Attempting patch on \(folder)")
        return false
    }
    
    private func attemptPatch(on file: File) -> Bool {
        guard AcceptedPath.isAcceptedPath(file.extension.rawValue),
              let fileContents = Diglet.read(file: file),
              let moduleName = discoverModuleNameFrom(fileContents) else {
            return false
        }
        let newContents = fileContents.replacingOccurrences(of: "\(moduleName).", with: "")
        do {
            try Diglet.write(newContents, to: file)
            return true
        }
        catch {
            return false
        }
    }
    
    private func discoverModuleNameFrom(_ contents: String) -> String? {
        contents.components(separatedBy: "-module-name").last?
            .components(separatedBy: "\n").first?
            .trimmingCharacters(in: .whitespacesAndNewlines)

    }
    
}

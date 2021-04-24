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
    
    func attemptPatch(on url: URL) -> Bool {
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
        guard AcceptedPath.isAcceptedPath(file.extension.rawValue) else {
            return false
        }
        // FIXME: - 
        // This must be a Swift Interface File
        return true
    }
    
    private func removeModuleNamesFollowedByPeriod() {
        
    }
    
}

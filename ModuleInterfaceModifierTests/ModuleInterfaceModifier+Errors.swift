//
//  ModuleInterfaceModifier+Errors.swift
//  ModuleInterfaceModifierTests
//
//  Created by Henry Cooper on 22/05/2021.
//

import XCTest
import Diglet
@testable import ModuleInterfaceModifier
extension ModuleInterfaceModifierTests {
    
    private func patchError(for url: URL) -> PatchError? {
        let patchHelper = PatchHelper()
        do {
            try patchHelper.attemptPatch(on: url)
            return nil
        }
        catch let error as PatchError {
            print(error.localizedDescription)
            return error
        }
        catch {
            return nil
        }
    }
    
    func testPatchHelperThrowsDisallowedFormatForUnrecognizedFormat() {
        XCTAssert(patchError(for: disallowedFormatFile) == .disallowedFormat)
    }
    
    func testPatchHelperThrowsCouldNotReadFileForUnreadableFile() {
        XCTAssert(patchError(for: unreadableFileURL) == .couldNotReadFile)
    }
    
    func testPatchHelperThrowsNothingToDoForCorrectlyPatchedFile() {
        XCTAssert(patchError(for: correctFileURL) == .nothingToDo)
    }
    
    func testPatchHelperThrowsCouldNotFindModuleNameForFileWithoutModuleName() {
        let correct = Diglet.fileAt(url: correctFileURL)!
        let contents = Diglet.read(file: correct)!
        let removingModuleSpecifier = contents.replacingOccurrences(of: "-module-name", with: "")
        try! Diglet.write(removingModuleSpecifier, to: correct)
        XCTAssert(patchError(for: correctFileURL) == .couldNotDiscoverModuleName)
    }

}

//
//  ModuleInterfaceModifierTests+PatchHelper.swift
//  ModuleInterfaceModifierTests
//
//  Created by Henry Cooper on 13/05/2021.
//

import XCTest
import Diglet
@testable import ModuleInterfaceModifier

extension ModuleInterfaceModifierTests {
    
    func testPatchHelperCanPatchSwiftInterfaceFile() throws {
        let patchHelper = PatchHelper()
        try patchHelper.attemptPatch(on: incorrectFileURL)
        let patched = Diglet.fileAt(url: incorrectFileURL)!
        let patchedContents = Diglet.read(file: patched)
        let correctFile = Diglet.fileAt(url: correctFileURL)!
        let correctFileContents = Diglet.read(file: correctFile)
        XCTAssertEqual(patchedContents, correctFileContents)
    }
    
}

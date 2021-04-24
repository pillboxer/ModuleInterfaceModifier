//
//  ModuleInterfaceModifierTests.swift
//  ModuleInterfaceModifierTests
//
//  Created by Henry Cooper on 07/04/2021.
//

import XCTest
import Diglet
@testable import ModuleInterfaceModifier

class ModuleInterfaceModifierTests: XCTestCase {
    
    var bundle: Bundle {
        Bundle(identifier: "com.sixeye.ModuleInterfaceModifier")!
    }
    
    private var testFile: URL { URL(string: "file:///Users/henrycooper/Documents/Test%20Interfaces/test.swiftinterface")! }
    private var incorrectFile: URL { URL(string: "file:///Users/henrycooper/Documents/Test%20Interfaces/incorrect.switinterface")! }
    private var correctFile: URL {  URL(string: "file:///Users/henrycooper/Documents/Test%20Interfaces/correct.swiftinterface")! }
    
    func loadIncorrectSwiftInterface() {
        // FIXME: -
        let incorrect = Diglet.fileAt(url: incorrectFile)!
        let test = Diglet.fileAt(url: testFile)!
        let string = Diglet.read(file: incorrect)
        try! Diglet.write(string!, to: test)
    }
 
    func testPatchHelperCanPatchSwiftInterfaceFile() {
        // FIXME: - 
        loadIncorrectSwiftInterface()
        let helper = PatchHelper()
        XCTAssertTrue(helper.attemptPatch(on: testFile))
    }

}

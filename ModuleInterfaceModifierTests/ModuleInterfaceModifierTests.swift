//
//  ModuleInterfaceModifierTests.swift
//  ModuleInterfaceModifierTests
//
//  Created by Henry Cooper on 07/04/2021.
//

import XCTest
@testable import ModuleInterfaceModifier

class ModuleInterfaceModifierTests: XCTestCase {
    
    var bundle: Bundle {
        Bundle(identifier: "com.sixeye.ModuleInterfaceModifier")!
    }
    
    private var testFile: URL { bundle.url(forResource: "test", withExtension: "swiftinterface")! }
 
    func testPatchHelperCanPatchSwiftInterfaceFile() {
        let helper = PatchHelper()
        helper.attemptPatch(on: testFile)
    }

}

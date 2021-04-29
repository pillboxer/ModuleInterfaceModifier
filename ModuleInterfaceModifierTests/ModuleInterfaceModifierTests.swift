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
    
    private static func documentsURL() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    override func setUp() {
        loadIncorrectSwiftInterface()
        loadCorrectSwiftInterface()
    }

    var bundle: Bundle {
        Bundle(identifier: "com.sixeye.ModuleInterfaceModifier")!
    }
    
    private var bundledIncorrectFile: URL { bundle.url(forResource: incorrectSwiftInterfaceFileName, withExtension: swiftInterfaceFileExtension)! }
    private var incorrectFileURL: URL { ModuleInterfaceModifierTests.documentsURL().appendingPathComponent(incorrectSwiftInterfaceFile) }
    
    private var bundledCorrectFile: URL { bundle.url(forResource: correctSwiftInterfaceFileName, withExtension: swiftInterfaceFileExtension)! }
    private var correctFileURL: URL { ModuleInterfaceModifierTests.documentsURL().appendingPathComponent(correctSwiftInterfaceFile) }
    
    private func loadIncorrectSwiftInterface() {
        let localIncorrect = Diglet.fileAt(url: bundledIncorrectFile)!
        let string = Diglet.read(file: localIncorrect)
        try! string?.write(to: incorrectFileURL, atomically: true, encoding: .utf8)
    }
    
    private func loadCorrectSwiftInterface() {
        let localCorrect = Diglet.fileAt(url: bundledCorrectFile)!
        let string = Diglet.read(file: localCorrect)
        try! string?.write(to: correctFileURL, atomically: true, encoding: .utf8)
    }
 
    func testPatchHelperCanPatchSwiftInterfaceFile() {
        // FIXME: - Working but needs fix
        let patchHelper = PatchHelper()
        patchHelper.attemptPatch(on: incorrectFileURL)
        let patched = Diglet.fileAt(url: incorrectFileURL)!
        let patchedContents = Diglet.read(file: patched)
        let correctFile = Diglet.fileAt(url: correctFileURL)!
        let correctFileContents = Diglet.read(file: correctFile)
        XCTAssertEqual(patchedContents, correctFileContents)
    }

}

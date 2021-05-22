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
        loadUnreadableFile()
    }

    var bundle: Bundle {
        Bundle(identifier: "com.sixeye.ModuleInterfaceModifier")!
    }
    
    var bundledIncorrectFile: URL { bundle.url(forResource: incorrectSwiftInterfaceFileName, withExtension: swiftInterfaceFileExtension)! }
    var incorrectFileURL: URL { ModuleInterfaceModifierTests.documentsURL().appendingPathComponent(incorrectSwiftInterfaceFile) }
    
    var bundledCorrectFile: URL { bundle.url(forResource: correctSwiftInterfaceFileName, withExtension: swiftInterfaceFileExtension)! }
    var correctFileURL: URL { ModuleInterfaceModifierTests.documentsURL().appendingPathComponent(correctSwiftInterfaceFile) }
    
    var disallowedFormatFile: URL { URL(string: "file://someurl.nope")! }
    var unreadableFileURL: URL { ModuleInterfaceModifierTests.documentsURL().appendingPathComponent(unreadableFile) }
    
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
    
    private func loadUnreadableFile() {
        let localCorrect = Diglet.fileAt(url: bundledCorrectFile)!
        let string = Diglet.read(file: localCorrect)
        try! string?.write(to: unreadableFileURL, atomically: true, encoding: .unicode)
    }

}

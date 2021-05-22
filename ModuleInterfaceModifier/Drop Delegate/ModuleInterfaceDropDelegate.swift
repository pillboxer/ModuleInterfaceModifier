//
//  DropDelegate.swift
//  ModuleInterfaceModifier
//
//  Created by Henry Cooper on 07/04/2021.
//

import SwiftUI
import Diglet

class ModuleInterfaceDropDelegate: DropDelegate, ObservableObject {
    
    @Published var patchError: PatchError?
    @Published var lastFilePatched: String?
    
    func performDrop(info: DropInfo) -> Bool {
        if let provider = info.itemProviders(for: [.fileURL]).first {
            provider.loadDataRepresentation(forTypeIdentifier: kUTTypeFileURL as String) { (data, error) in
                if let data = data,
                   let url = URL(dataRepresentation: data, relativeTo: nil) {
                    self.patch(url)
                }
            }
        }
        return true
    }
    
    private func patch(_ url: URL) {
        DispatchQueue.main.async {
            let patchHelper = PatchHelper()
            do {
                self.lastFilePatched = try patchHelper.attemptPatch(on: url)
            }
            catch let error {
                self.patchError = error as? PatchError
            }
        }
    }
    
}

//
//  DropDelegate.swift
//  ModuleInterfaceModifier
//
//  Created by Henry Cooper on 07/04/2021.
//

import SwiftUI
import Diglet

class ModuleInterfaceDropDelegate: DropDelegate, ObservableObject {
    
    @Published var disallowedFormatReceived = false
    
    func performDrop(info: DropInfo) -> Bool {
        if let provider = info.itemProviders(for: [.fileURL]).first {
            provider.loadDataRepresentation(forTypeIdentifier: kUTTypeFileURL as String) { (data, error) in
                if let data = data,
                   let url = URL(dataRepresentation: data, relativeTo: nil) {
                    let patchHelper = PatchHelper()
                    DispatchQueue.main.async {
                        self.disallowedFormatReceived = !patchHelper.attemptPatch(on: url)
                    }
                }
            }
        }
        return true
    }
    
}

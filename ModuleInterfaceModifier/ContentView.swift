//
//  ContentView.swift
//  ModuleInterfaceModifier
//
//  Created by Henry Cooper on 07/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var delegate = ModuleInterfaceDropDelegate()
    @State var showAlert = false
    
    var body: some View {
        VStack {
            Button("Drag to me") {}
                .frame(width: 100, height: 100)
                .onDrop(of: [.fileURL], delegate: delegate)
                .background(Color.red)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertText))
                }
        }
        .onChange(of: delegate.patchError) { newValue in
            showAlert = newValue != nil
        }
        .onChange(of: delegate.lastFilePatched) { newValue in
            showAlert = newValue != nil
        }
    }
    
    private var alertText: String {
        if let error = delegate.patchError {
            return error.localizedDescription
        }
        else if let fileName = delegate.lastFilePatched {
            return fileName
        }
        else {
            return "Unknown error"
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  ModuleInterfaceModifier
//
//  Created by Henry Cooper on 07/04/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var delegate = ModuleInterfaceDropDelegate()
    var body: some View {
        VStack {
            Button("Drag to me") {}
                .frame(width: 100, height: 100)
                .onDrop(of: [.fileURL], delegate: delegate)
                .background(Color.red)
                .alert(isPresented: $delegate.disallowedFormatReceived, content: {
                    Alert(title: Text("Sorry not allowed"))
                })
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Control Deck
//
//  Created by Alexander Emery on 21/07/2020.
//  Copyright © 2020 Alexander Emery. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var client = Client(host: "192.168.1.111",port: 65432)
    @State var message = ""
    var body: some View {
        VStack {
            if !self.client.running {
                Button(action: {
                               self.client.start()
                           }) {
                               Text("Start")
                           }
            } else {
                Text("Running")
            }
           
            TextField("Hello", text: $message)
            Button(action: {
                self.client.send(data: self.message.data(using: .utf8)!)
            }) {
                Text("send")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

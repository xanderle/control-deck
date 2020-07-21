//
//  Client.swift
//  Control Deck
//
//  Created by Alexander Emery on 21/07/2020.
//  Copyright © 2020 Alexander Emery. All rights reserved.
//

import Foundation
import Network

class Client: ObservableObject {
    let connection: ClientConnection
    let host: NWEndpoint.Host
    let port: NWEndpoint.Port
    @Published var running = false
    init(host: String, port: UInt16) {
        self.host = NWEndpoint.Host(host)
        self.port = NWEndpoint.Port(rawValue: port)!
        let nwConnection = NWConnection(host: self.host, port: self.port, using: .tcp)
        connection = ClientConnection(nwConnection: nwConnection)
    }

    func start() {
        print("Client started \(host) \(port)")
        connection.didStopCallback = didStopCallback(error:)
        connection.start()
        running = true
    }

    func stop() {
        connection.stop()
        running = false
    }

    func send(data: Data) {
        connection.send(data: data)
    }

    func didStopCallback(error: Error?) {
        if error == nil {
            exit(EXIT_SUCCESS)
        } else {
            exit(EXIT_FAILURE)
        }
    }
}

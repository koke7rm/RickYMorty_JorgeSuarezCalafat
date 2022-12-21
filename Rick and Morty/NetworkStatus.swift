//
//  NetworkStatus.swift
//  Rick and Morty
//
//  Created by Jorge Suárez on 21/12/22.
//

import Foundation
import Network

final class NetworkStatus: ObservableObject {
    enum Status {
        case offline, online, unknow
    }
    
    @Published var status: Status = .unknow
    
    var monitor: NWPathMonitor
    var queue = DispatchQueue(label: "MonitorNet")
    
    init() {
        monitor = NWPathMonitor()
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.status = path.status == .satisfied ? .online : .offline
            }
        }
        status = monitor.currentPath.status == .satisfied ? .online : .offline
    }
}

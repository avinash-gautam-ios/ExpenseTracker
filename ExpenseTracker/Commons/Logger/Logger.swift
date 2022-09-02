//
//  Logger.swift
//  ExpenseTracker
//
//  Created by Avinash on 30/08/22.
//

import Foundation

enum LogType: String {
    case critial
    case error
    case message
    
    var prefix: String {
        switch self {
        case .critial:
            return "(🚒 CRITICAL) => "
        case .error:
            return "(🔴 ERROR) => "
        case .message:
            return "(✉️ MESSAGE) => "
        }
    }
}

protocol Logger: Any {
    func log(type: LogType, _ message: Any)
}


final class DebugLogger: Logger {
    
    init() { }
    
    func log(type: LogType, _ message: Any) {
        #if DEBUG
        print(type.prefix + "\(message)")
        #endif
    }
}

final class ProdLogger: Logger {
    
    init() { }
    
    /// dont print anything in production
    func log(type: LogType, _ message: Any) { }
}

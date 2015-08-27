//
//  TwillioPhone.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/20/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import Parse

class TwillioPhone: NSObject {
    
    override init() {
        
        super.init()
    }
    
    func connect() {
        
//        PFCloud.callFunctionInBackground("get_capability", withParameters: nil) { (token, error) -> Void in
//            
//            if error == nil {
//                JEDump(token)
//                
//                self.device = TCDevice(capabilityToken: (token as! String), delegate: self)
//
//                self.device?.connect(nil, delegate: self)
//            }
//        }
        PFCloud.callFunctionInBackground("test_twillio", withParameters: ["to_number": "+818046066418", "message": "こんにちわ"]) { (result, error) -> Void in
            
            JEDump(result)
        }
    }
    
    func disconnect() {
        
    }
    
    private var device: TCDevice? = nil
    private var connection: TCConnection? = nil
}

extension TwillioPhone: TCDeviceDelegate {
    
    func device(device: TCDevice!, didReceiveIncomingConnection connection: TCConnection!) {
        
    }
    
    func device(device: TCDevice!, didReceivePresenceUpdate presenceEvent: TCPresenceEvent!) {
        
    }
    
    func device(device: TCDevice!, didStopListeningForIncomingConnections error: NSError!) {
        
    }
    
    func deviceDidStartListeningForIncomingConnections(device: TCDevice!) {
        
    }
}

extension TwillioPhone: TCConnectionDelegate {
    
    func connection(connection: TCConnection!, didFailWithError error: NSError!) {
        
    }
    
    func connectionDidConnect(connection: TCConnection!) {
        
    }
    
    func connectionDidDisconnect(connection: TCConnection!) {
        
    }
    
    func connectionDidStartConnecting(connection: TCConnection!) {
        
    }
}
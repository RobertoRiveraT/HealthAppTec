//
//  InterfaceController.swift
//  HealthAppAW WatchKit Extension
//
//  Created by user189674 on 11/29/21.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var mapaAW: WKInterfaceMap!
    
    var session = WCSession.default
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        session.delegate = self
        session.activate()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("test: Activation did complete")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("watch received app context: ", message)
        if let valueFromPhone = message["Phone"] as? String {
            print(valueFromPhone)
            print("test: mensaje recibido")
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("watch received app context: ", applicationContext)
    }
}

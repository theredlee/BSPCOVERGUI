//
//  TabBSPCOVERRun.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct TabBSPCOVERRun: View {
    @Binding var str: String
    
    var body: some View {
        VStack{
            Text("Hello, World!")
            Button("BSPCOVER RUN") {
                mySSH()
            }
            Text("Hello, World!")
        }
        .offset(x: 0, y: 50)
        .padding()
    }
    
    func mySSH() {
        let host: String = "csr30.comp.hkbu.edu.hk"
        // 158.182.9.60
        let user: String = "shiwenli"
        let password: String = "LIshiwen123@"
        let port: Int = 22
        
        let session = NMSSHSession(host: host, port: port, andUsername: user)
        
        let socketErorr = session.socket
        
        if session.isConnected {
            session.authenticate(byPassword: password)
        } else {
            NSLog("Faild to connect remote side -2:\nType: \(String(describing: socketErorr))\n\(String(describing: session.lastError))")
            str = "Faild to connect remote side -2:\nType: \(String(describing: socketErorr))\n\(String(describing: session.lastError))"
            return
        }
        
        if !session.connect() {
            NSLog("Faild to connect remote side -1:\nType: \(String(describing: socketErorr))\n\(String(describing: session.lastError))")
            str = "Faild to connect remote side -1:\nType: \(String(describing: socketErorr))\n\(String(describing: session.lastError))"
            return
        }
        
        if session.isAuthorized {
            NSLog("Authentication succeeded")
            str = "Authentication succeeded"
        }
        var error: NSError? = nil
        let cmd  = "exit"
        let response: NSString = session.channel.execute(cmd, error: &error) as NSString
        NSLog("List of my sites: %@", response)
        str = "Resonse: \(response)" as String
    }
}

struct TabBSPCOVERRun_Previews: PreviewProvider {
    static var previews: some View {
        TabBSPCOVERRun(str: .constant("This is BSPCOVER RUN."))
    }
}

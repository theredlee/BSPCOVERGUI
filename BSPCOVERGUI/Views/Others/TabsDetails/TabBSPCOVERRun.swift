//
//  TabBSPCOVERRun.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct TabBSPCOVERRun: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func mySSH() {
        let host = "csr30.comp.hkbu.edu.hk";
        let user = "shiwenli";
        let password = "LIshiwen123@";
        let port = 22;
        
        let session = NMSSHSession(host: host, port: port, andUsername: user)
        if session.isConnected {
            session.authenticate(byPassword: password)
        }
    }
}

struct TabBSPCOVERRun_Previews: PreviewProvider {
    static var previews: some View {
        TabBSPCOVERRun()
    }
}

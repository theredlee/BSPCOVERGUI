//
//  LoadShapelet.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/25/20.
//

import SwiftUI

struct LoadShapelet: View {
    @Binding var selectedShapelet: Shapelet?
    @Binding var str: String
    @Binding var selectedTimeseriesLabel: Label?
    
    var body: some View {
        Button("Load Shapelet", action: {
            selectFolderBtnClicked("Start to select shapelets.")
        })
    }
    
    /**
     We encourage the user to select a folder, like ~/Documents,
     showing their "intent" to grant our app access to that folder.
     That directory is OUTSIDE of this app's sandbox. We do this
     in preparation for allowing us to reach out of our container.
     */
    func selectFolderBtnClicked(_ sender: Any) {
        
        let folderSelectionDialog = NSOpenPanel() // a modal dialog
        
        folderSelectionDialog.prompt = "Select"
        folderSelectionDialog.message = "Please select a folder"
        
        folderSelectionDialog.canChooseFiles = false
        folderSelectionDialog.allowedFileTypes = ["N/A"]
        folderSelectionDialog.allowsOtherFileTypes = false
        
        folderSelectionDialog.allowsMultipleSelection = false
        
        folderSelectionDialog.canChooseDirectories = true
        
        // open the MODAL folder selection panel/dialog
        let dialogButtonPressed = folderSelectionDialog.runModal()
        
        // if the user pressed the "Select" (affirmative or "OK")
        // button, then they've probably chosen a folder
        if dialogButtonPressed == NSApplication.ModalResponse.OK {
            
            if folderSelectionDialog.urls.count == 1 {
                
                if let url = folderSelectionDialog.urls.first {
                    
                    // if the user doesn't select anything, then
                    // the URL "file:///" is returned, which we ignore
                    if url.absoluteString != "file:///" {
                        
                        // save the user's selection so that we can
                        // access the folder they specified (in Part II)
                        let userSelectedFolderURL = url
                        
                        // load time series
                        let aStr = DatabaseManager.shared.readLocalShapeletDirectory(fileDirectory: userSelectedFolderURL.absoluteURL)
                        // After loading new data, update the binding value
                        selectedShapelet = Database.shared.defaultShapelet
                        selectedTimeseriesLabel = Database.shared.defaultShapeletLabel
                        
                        print("User selected folder: \(url)")
                        str = "User selected folder: \n\(aStr)"
//                        str = selectedTimeseriesLabel?.name ?? "Non-label-filter"
                        
                    } else {
                        print("User did not select a folder: file:///")
                        str = "User did not select a folder: file:///"
                    }
                    
                } // end if let url = folderSelectionDialog.urls.first {
                
            } else {
                
                print("User did not select a folder")
                str = "User did not select a folder"
                
            } // end if folderSelectionDialog.urls.count
            
        } else { // user clicked on "Cancel"
            
            print("User cancelled folder selection panel")
            str = "User cancelled folder selection panel"
            
        } // end if dialogButtonPressed == NSApplication.ModalResponse.OK
        
    }
}

struct LoadShapelet_Previews: PreviewProvider {
    static var previews: some View {
        LoadShapelet(selectedShapelet: .constant(Database.shared.defaultShapelet), str: .constant("Load shapelet started"), selectedTimeseriesLabel: .constant(Database.shared.defaultShapeletLabel))
    }
}

//
//  ViewController.swift
//  DragAndDrop_OtherToTable
//
//  Created by TATSUYA YAMAGUCHI on 2020/02/09.
//  Copyright © 2020 TATSUYA YAMAGUCHI. All rights reserved.
//

import Cocoa
import AVFoundation


protocol DestinationViewDelegate: class {
    func addImageNames(_ imageName: String)
}


class ViewController: NSViewController, NSTableViewDataSource, DestinationViewDelegate {

    @IBOutlet private weak var destinationView: DestinationView!
    
    @objc dynamic var imageNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        destinationView.delegate2 = self
    }
    
    //MARK: - NSTableViewDataSource methods

    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        
        tableView.setDropRow(-1, dropOperation: .on)//to heighlight the table

        let allow = destinationView.shouldAllowDrag(info)
        return allow ? .copy : NSDragOperation()
    }
    
    //MARK: - DestinationViewDelegate
    
    func addImageNames(_ imageName: String) {
        
        imageNames.append(imageName)
    }
}

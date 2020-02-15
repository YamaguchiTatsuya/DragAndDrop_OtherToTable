//
//  DestinationView.swift
//  DragAndDrop_OtherToTable
//
//  Created by TATSUYA YAMAGUCHI on 2020/02/09.
//  Copyright © 2020 TATSUYA YAMAGUCHI. All rights reserved.
//

import Cocoa
import AVFoundation

class DestinationView: NSTableView {

    weak var delegate2: DestinationViewDelegate?
    
    let filteringOptions = [NSPasteboard.ReadingOptionKey.urlReadingContentsConformToTypes:
    [NSPasteboard.PasteboardType.png, AVFileType.jpg]]
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {

        registerForDraggedTypes([.fileURL])
    }
    
    func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
        
        var canAccept = false
        let pasteBoard = draggingInfo.draggingPasteboard
        
        if pasteBoard.canReadObject(forClasses: [NSURL.self], options: filteringOptions) {
            canAccept = true
        }
        return canAccept
    }
    
    //MARK: - NSDraggingDestination protocol
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {

        let allow = shouldAllowDrag(sender)
        return allow ? .copy : NSDragOperation()
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {

        return shouldAllowDrag(sender)
    }
    
    override func performDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool {

        let pasteBoard = draggingInfo.draggingPasteboard
        
        if let urls = pasteBoard.readObjects(forClasses: [NSURL.self], options: filteringOptions) as? [URL] {
            processURLs(urls)
        }
        
        return true
    }
    
    private func processURLs(_ urls: [URL]) {
        
        for url in urls {
            let fileName = url.path.components(separatedBy: "/").last
            delegate2?.addImageNames(fileName!)
        }
        reloadData()
    }
}

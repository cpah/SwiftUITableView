//
//  TableViewController.swift
//  SwiftUITableView
//
//  Created by cpahull on 15/11/2020.
//

import Foundation
import Cocoa
//import Combine
//import SwiftUI

let newPayeeNodeSelected = NotificationCenter.default // Notification to prompt SwiftUI to update selectedRow
    .publisher(for: Notification.Name("newPayeeNodeSelected"))
    .map { notification in
        return notification.userInfo
    }
let payeeNodeEdited = NotificationCenter.default // Notification to prompt SwiftUI to update selectedRow
    .publisher(for: Notification.Name("payeeNodeEdited"))
    .map { notification in
        return notification.userInfo
    }

class TableViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @objc dynamic var contents: [PayeeNode] = []

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet var arrayController: NSArrayController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func nameCellEdited(_ sender: Any) {
        if let newPayeeNode = arrayController.selectedObjects[0] as? PayeeNode {
            contents[arrayController.selectionIndex].name = newPayeeNode.name
            NotificationCenter.default.post(name: Notification.Name("payeeNodeEdited"), object: self, userInfo: [arrayController.selectionIndex:newPayeeNode.name])
        }
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        var newSelectedPayeeNode: [AnyHashable : Any?]
        if tableView.selectedRow >= 0 {
            newSelectedPayeeNode = [tableView.selectedRow:arrayController.selectedObjects[0]]
        } else {
            newSelectedPayeeNode = [tableView.selectedRow:nil]
        }
        NotificationCenter.default.post(name: Notification.Name("newPayeeNodeSelected"), object: self, userInfo: newSelectedPayeeNode as [AnyHashable : Any])
    }

    func setContents(payeeNodes: [PayeeNode]) -> Void {
        contents = payeeNodes
        arrayController.removeSelectionIndexes([0])
        let newSelectedPayeeNode = [-1:nil] as [Int : Any?]
        NotificationCenter.default.post(name: Notification.Name("newPayeeNodeSelected"), object: self, userInfo: newSelectedPayeeNode as [AnyHashable : Any])
    }
    
    func setSelectionIndex(selectedIndex: Int) -> Void {
        if selectedIndex < 0 {
            arrayController.removeSelectionIndexes([0])
            return
        }
        arrayController.setSelectionIndex(selectedIndex)
    }
    
}


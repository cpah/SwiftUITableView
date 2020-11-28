//
//  TableViewController.swift
//  SwiftUITableView
//
//  Created by cpahull on 15/11/2020.
//

import Cocoa
//import Combine
//import SwiftUI

let newPayeeNodeSelected = NotificationCenter.default // Notification to prompt SwiftUI to update selectedRow
    .publisher(for: Notification.Name("newPayeeNodeSelected"))
    .map { notification in
        return notification.userInfo as [String: PayeeNode?]
    }
let payeeNodeEdited = NotificationCenter.default // Notification to prompt SwiftUI to update selectedRow
    .publisher(for: Notification.Name("payeeNodeEdited"))
    .map { notification in
        return notification.userInfo as [String: String]
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
            NotificationCenter.default.post(name: Notification.Name("payeeNodeEdited"), object: self, userInfo: ["":newPayeeNode.name])
        }
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        var newSelectedPayeeNode: [String:PayeeNode?]
        if arrayController.selectionIndexes.count > 0 {
            newSelectedPayeeNode = ["":arrayController.selectedObjects[0] as? PayeeNode]
        } else {
            newSelectedPayeeNode = ["":nil]
        }
        NotificationCenter.default.post(name: Notification.Name("newPayeeNodeSelected"), object: self, userInfo: newSelectedPayeeNode as [AnyHashable : Any])
    }

    func setContents(payeeNodes: [PayeeNode]) -> Void {
        if payeeNodes.count == 0 {
            arrayController.removeSelectionIndexes([0])
            let newSelectedPayeeNode = ["":nil] as [String : Any?]
            NotificationCenter.default.post(name: Notification.Name("newPayeeNodeSelected"), object: self, userInfo: newSelectedPayeeNode as [AnyHashable : Any])
        } else {
            arrayController.setSelectionIndex(payeeNodes.count - 1)
            tableView.selectRowIndexes([payeeNodes.count - 1], byExtendingSelection: false)
            tableView.scrollRowToVisible(tableView.selectedRow)
        }
        contents = payeeNodes
        tableView.reloadData()
    }
    
    func setSelectionIndex(selectedIndex: Int) -> Void {
        if selectedIndex < 0 {
            arrayController.removeSelectionIndexes([0])
            return
        }
        arrayController.setSelectionIndex(selectedIndex)
    }
    
}


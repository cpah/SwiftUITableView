//
//  TableViewController.swift
//  SwiftUITableView
//
//  Created by cpahull on 15/11/2020.
//

import Cocoa
import SwiftUI

let newRowSelected = NotificationCenter.default
    .publisher(for: Notification.Name("newRowSelected"))
//var newSelectedRow = 0

class TableViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var names: [[String]]?

    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        // Do view setup here.
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return names?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result: NSTableCellView
        result = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        result.textField?.stringValue = names?[row][Int((tableColumn?.identifier.rawValue)!)!] ?? "None"
        return result
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        newSelectedRow = tableView.selectedRow
        NotificationCenter.default.post(name: Notification.Name("newRowSelected"), object: nil)
    }

    func setNames(myNames: [[String]]) -> Void {
        names = myNames
        tableView.reloadData()
        if myNames.count == 0 && newSelectedRow >= 0 {
            newSelectedRow = tableView.selectedRow
            NotificationCenter.default.post(name: Notification.Name("newRowSelected"), object: nil)
        }
    }
    
    func setSelectedRow(selectedRow: Int) -> Void {
        tableView.selectRowIndexes([selectedRow], byExtendingSelection: false)
    }
}


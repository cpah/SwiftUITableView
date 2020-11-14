//
//  TableViewController.swift
//  SwiftUITableView
//
//  Created by cpahull on 14/11/2020.
//

import Cocoa

var names: [[String]] = [
                        ["Chris", "Hull"],
                        ["Lynn", "Harris"],
                        ["Kirsty", "Chambers"],
                        ["Caroline", "Whatman"]
                        ]

class TableViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self as NSTableViewDelegate
        self.tableView.dataSource = self
        // Do view setup here.
    }
    
}

extension TableViewController:NSTableViewDataSource, NSTableViewDelegate{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return names.count
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result: NSTableCellView
        result = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        result.textField?.stringValue = names[row][Int((tableColumn?.identifier.rawValue)!)!]
        return result
    }
}


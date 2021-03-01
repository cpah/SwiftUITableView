//
//  ContentView.swift
//  SwiftUITableView
//
//  Created by cpahull on 14/11/2020.
//

import Foundation
import SwiftUI
import AppKit

class Item: NSObject, Identifiable {
    @objc var id = UUID()
    @objc var name: String
    @objc var cleared: Bool
    
    init(name: String, cleared: Bool) {
        self.name = name
        self.cleared = cleared
    }
}

struct ContentView: View {
        
    @State private var items = [Item]()
    @State private var rowSelected = -1
    @State private var selectedName = ""
    @State private var selectedRef: UUID? = nil
    @State private var selectedCleared = false
    
    var body: some View {
        HSplitView { // Placing top level view inside a SplitView prevents this runtime warning: SwiftUITableView[9921:321879] [General] ERROR: Setting <_TtC7SwiftUIP33_9FEBA96B0BC70E1682E82D239F242E7319SwiftUIAppKitButton: 0x7fd4bd919d60> as the first responder for window <NSWindow: 0x7fd4bd904db0>, but it is in a different window ((null))! This would eventually crash when the view is freed. The first responder will be set to nil.
            VStack {
                HStack {
                    Button("Clear") {
                        items.removeAll()
                        rowSelected = -1
                    }
                    .disabled(items.count == 0)
                    Button("Populate") { // reloads items and preselects last item
                        items = getitems()
                        rowSelected = items.count - 1
                        selectedRef = items[rowSelected].id
                        selectedName = items[rowSelected].name
                        selectedCleared = items[rowSelected].cleared
                    }
                    .disabled(items.count > 0)
                    Button("Delete") {
                        items.remove(at: rowSelected)
                        rowSelected = -1
                    }
                    .disabled(rowSelected == -1)
                }
                TableVC(items: $items, rowSelected: $rowSelected, selectedName: $selectedName, selectedCleared: $selectedCleared)
                    .frame(minWidth: 450, minHeight: 200)
                    .onAppear(perform: {
                        items = getitems()
                    })
                HStack {
                    if rowSelected >= 0 {
                        Text(selectedName)
                        Text(items[rowSelected].id.uuidString)
                        Text(selectedCleared == true ? "True":"False")
                    }
                    else {
                        Text("None")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct TableVC: NSViewControllerRepresentable {
    
    @Binding var items: [Item]
    @Binding var rowSelected: Int
    @Binding var selectedName: String
    @Binding var selectedCleared: Bool
    
    func makeNSViewController(context: Context) -> NSViewController {
        let tableVC = TableViewController()
        return tableVC
    }
        
    func updateNSViewController(_ nsViewController: NSViewController, context: Context) {
        guard let tableVC = nsViewController as? TableViewController else {return}
        tableVC.setContents(items: items)
        tableVC.tableView?.delegate = context.coordinator
        guard rowSelected >= 0 else {
            tableVC.arrayController.removeSelectionIndexes([0])
            return
        }
        tableVC.arrayController.setSelectionIndex(rowSelected)
        tableVC.tableView.scrollRowToVisible(rowSelected)
    }
    
    class Coordinator: NSObject, NSTableViewDelegate {
        
        var parent: TableVC
        
        init(_ parent: TableVC) {
            self.parent = parent
        }
        
        func tableViewSelectionDidChange(_ notification: Notification) {
            guard let tableView = notification.object as? NSTableView else {return}
            guard self.parent.items.count > 0 else {return}
            guard tableView.selectedRow >= 0 else {
                self.parent.rowSelected = -1
                return
            }
            self.parent.rowSelected = tableView.selectedRow
            self.parent.selectedName = self.parent.items[tableView.selectedRow].name
            self.parent.selectedCleared = self.parent.items[tableView.selectedRow].cleared
        }

        @IBAction func nameCellEdited(_ sender: Any) {
            guard let textView = sender as? NSTextField else {return}
            self.parent.selectedName = textView.stringValue
        }
        
        @IBAction func clearedCellToggled(_ sender: Any) {
            guard self.parent.rowSelected >= 0 else {return}
            self.parent.selectedCleared = self.parent.items[self.parent.rowSelected].cleared
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

func getitems() -> [Item] {
    return [
        Item(name: "Alpha", cleared: false),
        Item(name: "Bravo", cleared: false),
        Item(name: "Charlie", cleared: false),
        Item(name: "Delta", cleared: false),
        Item(name: "Echo", cleared: false),
        Item(name: "Foxtrot", cleared: false),
        Item(name: "Golf", cleared: false),
        Item(name: "Hotel", cleared: false),
        Item(name: "India", cleared: false),
        Item(name: "Juliet", cleared: false),
        Item(name: "Kilo", cleared: false),
        Item(name: "Lima", cleared: false),
        Item(name: "Mike", cleared: true),
        Item(name: "November", cleared: false),
        Item(name: "Oscar", cleared: false),
        Item(name: "Papa", cleared: false),
        Item(name: "Quebec", cleared: false),
        Item(name: "Romeo", cleared: false),
        Item(name: "Sierra", cleared: false),
        Item(name: "Tango", cleared: false),
        Item(name: "Uniform", cleared: false),
        Item(name: "Victor", cleared: false),
        Item(name: "Whiskey", cleared: false),
        Item(name: "X-Ray", cleared: false),
        Item(name: "Yankee", cleared: false),
        Item(name: "Zulu", cleared: false)
    ]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

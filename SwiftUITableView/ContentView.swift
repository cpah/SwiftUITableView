//
//  ContentView.swift
//  SwiftUITableView
//
//  Created by cpahull on 14/11/2020.
//

import Foundation
import SwiftUI
import AppKit

var newSelectedRow = -1

struct ContentView: View {
    
    @State private var myNames = [[String]]()
    @State private var selectedRow: Int = -1
    
    var body: some View {
        VStack {
            HStack {
                Button("Refresh") {
                    myNames = getMyNames()
                    selectedRow = 0
                }
                Button("Clear") {
                    myNames.removeAll()
                }
            }
            TableVC(myNames: $myNames, selectedRow: $selectedRow)
                .frame(minWidth: 450, minHeight: 200)
            HStack {
                Text("Selection:")
                if myNames.count > 0 && selectedRow >= 0 {
                    Text(myNames[selectedRow][0] + " " + myNames[selectedRow][1])
                } else {
                    Text("None")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .onAppear(perform: {
            myNames = getMyNames()
            selectedRow = 0
        })
        .onReceive(newRowSelected, perform: {_ in
            selectedRow = newSelectedRow
        })
    }
}

struct TableVC: NSViewControllerRepresentable {
    
    @Binding var myNames: [[String]]
    @Binding var selectedRow: Int

    typealias NSViewControllerType = TableViewController
    
    func makeNSViewController(context: NSViewControllerRepresentableContext<TableVC>) -> TableViewController {
        let tableVC = TableViewController()
        return tableVC
    }
        
    func updateNSViewController(_ nsViewController: TableViewController, context: NSViewControllerRepresentableContext<TableVC>) {
        nsViewController.setNames(myNames: myNames)
        nsViewController.setSelectedRow(selectedRow: selectedRow)
        return
    }
}

func getMyNames() -> [[String]] {
    return [
        ["Alpha", "Bravo"],
        ["Charlie", "Delta"],
        ["Echo", "Foxtrot"],
        ["Golf", "Hotel"],
        ["India", "Juliet"],
        ["Kilo", "Lima"],
        ["Mike", "November"],
        ["Oscar","Papa"],
        ["Romeo","Sierra"],
        ["Tango","Uniform"],
        ["Victor", "Whiskey"],
        ["XRay", "Yankee"]
        ]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
                    myNames = [
                        ["Chris", "Hull"],
                        ["Lynn", "Harris"],
                        ["Kirsty", "Chambers"],
                        ["Caroline", "Whatman"]
                        ]
                    selectedRow = 0
                }
                Button("Clear") {
                    myNames.removeAll()
                }
            }
            TableVC(myNames: $myNames, selectedRow: $selectedRow)
                .frame(width: 450, height: 300)
            HStack {
                Text("Selected Row")
                Text("\(selectedRow)")
            }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: {
            myNames = [
                ["Chris", "Hull"],
                ["Lynn", "Harris"],
                ["Kirsty", "Chambers"],
                ["Caroline", "Whatman"]
                ]
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

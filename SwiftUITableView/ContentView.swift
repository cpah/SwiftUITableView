//
//  ContentView.swift
//  SwiftUITableView
//
//  Created by cpahull on 14/11/2020.
//

import Foundation
import SwiftUI
import AppKit

struct ContentView: View {
    
    @State private var myNames = [[String]]()

    
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
                }
                Button("Clear") {
                    myNames.removeAll()
                }
            }
            TableView(myNames: $myNames)
                .frame(width: 450, height: 300)
        }
        
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TableView: NSViewControllerRepresentable {
    
    @Binding var myNames: [[String]]
    
    typealias NSViewControllerType = TableViewController
    
    func makeNSViewController(context: NSViewControllerRepresentableContext<TableView>) -> TableViewController {
        return TableViewController()
    }
    
    func updateNSViewController(_ nsViewController: TableViewController, context: NSViewControllerRepresentableContext<TableView>) {
        nsViewController.getNames(myNames: myNames)
        return
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

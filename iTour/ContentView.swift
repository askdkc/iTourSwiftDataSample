//
//  ContentView.swift
//  iTour
//
//  Created by dkc on 2026/01/17.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    @State private var onlyFuture: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText, onlyFuture: onlyFuture)
                .navigationTitle("iTour")
                .navigationDestination(for: Destination.self) { destination in
                    EditDestinationView(destination: destination)
                }
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Destination", action: addDestination)
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))
                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority, order: .reverse))
                            Text("Date")
                                .tag(SortDescriptor(\Destination.date))
                        }
                        .pickerStyle(.inline)
                    }
                    Menu("Future", systemImage: "clock") {
                        Picker("Sort", selection: $onlyFuture) {
                            Text("Future")
                                .tag(true)
                            Text("All")
                                .tag(false)
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}

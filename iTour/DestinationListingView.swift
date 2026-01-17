//
//  DestinationListingView.swift
//  iTour
//
//  Created by dkc on 2026/01/17.
//

import SwiftData
import SwiftUI

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Destination.priority, order: .reverse) var destinations: [Destination]
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        }
    }
    
    init(sort: SortDescriptor<Destination>, searchString: String, onlyFuture: Bool) {
        let now = Date()
        _destinations = Query(
            filter: #Predicate<Destination> { destination in
                (searchString.isEmpty || destination.name.localizedStandardContains(searchString)) && (!onlyFuture || destination.date > now)
            },
            sort: [sort]
        )
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
    
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "", onlyFuture: false)
}

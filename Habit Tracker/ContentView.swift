//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Octavius Bowman on 1/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var activities = Activities()
    
    @State private var showingActivity = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    NavigationLink(destination: DetailView(activities: self.activities, activity: item)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.description)
                            }
                            Spacer()
                            Text("\(item.times)")
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Habit Tracker"))
            .navigationBarItems(trailing: Button(action: {
                self.showingActivity = true
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showingActivity) {
                AddActivity(activities: self.activities)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

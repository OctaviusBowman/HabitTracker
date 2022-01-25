//
//  DetailView.swift
//  Habit Tracker
//
//  Created by Octavius Bowman on 1/21/22.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var activities: Activities
    
    @State private var times = 0
    var activity: Activity
    
    var body: some View {
        Form {
            Section(header: Text("Description for activity")) {
                Text("\(self.activity.description)")
            }
            
            Section(header: Text("Change Times:")) {
                Stepper(value: $times, in: 0...Int.max, step: 1) {
                    Text("Completed times: \(self.times)")
                }
            }
        }
        .navigationBarTitle(Text("\(self.activity.name)"))
        .navigationBarItems(trailing: Button(action: {
            self.saveActivity()
        }, label: {
            Text("Save")
        }))
        .onAppear{
            self.times = self.activity.times
        }
    }
    
        func saveActivity() {
            if let indexItem = self.activities.items.firstIndex(where: { (item) -> Bool in
                item == self.activity
            }) {
                let tempActivity = Activity(name: self.activity.name, description: self.activity.description, times: self.times)
                self.activities.items.remove(at: indexItem)
                self.activities.items.insert(tempActivity, at: indexItem)
                self.activities.saveActivites()
            }
        }
    }
    
    
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            DetailView(activities: Activities(), activity: Activity(name: "Name", description: "Description", times: 0))
        }
    }

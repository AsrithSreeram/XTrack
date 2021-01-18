//
//  ContentView.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 12/17/20.
//  Copyright © 2020 Software Development HS_902. All rights reserved.
//

import SwiftUI
import Foundation

@available(iOS 14.0, *)
struct ContentView: View{
    @State var selected = 0
    var body: some View{
        TabView(selection: $selected) {
            TracerView().tabItem{
                NavigationLink(destination: TracerView(), label: {
                    Image(systemName: "globe")
                    Text("Tracer")
                })
            }.tag(0)

            NewsView().tabItem{
                NavigationLink(destination: NewsView(), label: {
                    Image(systemName: "newspaper")
                    Text("News")
                })
            }.tag(1)

            UpdatesView().tabItem{
                NavigationLink(destination: UpdatesView(), label: {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Updates")
                })
            }.tag(2)

            SettingsView().tabItem{
                NavigationLink(destination: SettingsView(), label: {
                    Image(systemName: "gear")
                    Text("Settings")
                })
            }.tag(3)
        }.edgesIgnoringSafeArea(.all)
        }
}

@available(iOS 14.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  SettingsView.swift
//  Pods
//
//  Created by Software Development HS_902 on 12/17/20.
//

import SwiftUI

@available(iOS 14.0, *)
struct SettingsView: View {
    
    var body: some View {
        NavigationView{
        List{
            NavigationLink(
                destination: PermissionsView()){
            Text("Usage of Permissions")
            }
            NavigationLink(
                destination: /*@START_MENU_TOKEN@*/ContractsView()/*@END_MENU_TOKEN@*/){
            Text("Contracts")
            }
            NavigationLink(
                destination: TermsAndConditionsView()){
            Text("Terms and Conditions")
            }
        }.navigationBarTitle("Settings")
        }
        
    }
}

@available(iOS 14.0, *)
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

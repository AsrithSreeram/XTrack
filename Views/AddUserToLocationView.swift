//
//  AddUserToLocationView.swift
//  CovidTracker
//

//

import SwiftUI

@available(iOS 14.0, *)
struct AddUserToLocationView: View {
    @ObservedObject var location: Location
    @ObservedObject var user: User
    
    init(_ location: Location, _ user: User, _ entered: Bool){
        self.location=location
        self.user=user
        if entered{
            print("Add Location is executing.")
            print("This is the user variable from add view: " , user.locationsVisited)
            self.user.enterLocation(self.location)
        }
    }
    
    var body: some View {
        NavigationLink(
            destination: NewsView(),
            isActive: .constant(true),
            label: {})
        LoadingSpinner(animate: .constant(true))
    }
}

@available(iOS 14.0, *)
struct AddUserToLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserToLocationView(Location("3467 Lincoln Hwy E, Thorndale, PA 19372"), User(), true)
    }
}

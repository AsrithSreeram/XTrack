//
//  LocationPreview.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 12/22/20.
//  Copyright © 2020 Software Development HS_902. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct LocationPreview: View {
    init(_ address: String){
        self.location=Location(address)
    }
    var user: User = User()
    @ObservedObject var location: Location
    @State var alertRedirect: Bool = false
    @State var alertStatus: Bool = false
    @State var enter: Bool = false
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30){
            HStack{
                Text(self.location.name)
                    .font(.largeTitle)
                Spacer()
                NavigationLink(destination: TracerView()){
                    Image(systemName: "xmark")
                }
            }.padding(30)
            VStack(alignment: .leading){
                Text("Stats:")
                    .font(.title2)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                Text("Number of People today: "+String(location.numOfPeopleToday.count))
                    .font(.title3)
                    .foregroundColor(.black)
                
                Text("Number of Cases this week: "+String(location.numOfCasesThisWeek.count))
                    .font(.title3)
                    .foregroundColor(.black)
                
                HStack{
                    Text("Risk Assessment: ")
                        .font(.title3)
                        .foregroundColor(.black)
                    Text(location.evaluateLocation() == RiskValues.green ? "Green":  (location.evaluateLocation() == RiskValues.yellow ? "Yellow": "Red"))
                        .font(.title3)
                        .foregroundColor(location.evaluateLocation() == RiskValues.green ? Color.green: (location.evaluateLocation() == RiskValues.yellow ? Color.yellow: Color.red))
                }
                
            }
            .padding()
            .background(Color.init(red: 242/255, green: 242/255, blue: 247/255))
            .cornerRadius(20)
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30){
                NavigationLink(
                    destination: TracerView()) {
                    HStack {
                        Text("Cancel")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(30)
                }
                .alert(isPresented: $alertStatus){
                    let yesButton = Alert.Button.default(Text("Quarantine")) {
                        print("quarantine button pressed")
                    }
                    let noButton = Alert.Button.default(Text("Enter")) {
                        print("enter button pressed")
                        self.enter.toggle()
                    }
                    return Alert(title: Text("Quarantine Recommended"), message: Text("We highly recommend quarantining to prevent spread of Covid-19."), primaryButton: noButton, secondaryButton: yesButton)
                }
                NavigationLink(
                    destination: AddUserToLocationView(location, user, self.enter), isActive: self.$enter){EmptyView()}
                Button(action: {
                    print("Curently entered", user.enterLocation)
                    if self.user.enterLocation{
                        self.alertRedirect=true
                        print("Current Value", self.alertRedirect)
                    }else if self.user.status == InfectionStatus.positive{
                        print("Current Status", self.user.status)
                        self.alertStatus.toggle()
                    }else{
                        self.enter.toggle()
                    }
                }) {
                    Text("Enter")
                        .fontWeight(.semibold)
                        .font(.title3)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(30)
                .alert(isPresented: $alertRedirect){
                    return Alert(title: Text("Must Exit Location First"), message: Text("Please exit previous location before entering new one"), dismissButton: .default(Text("Ok")))
                }
            }
            Spacer()
        }
    }
}

@available(iOS 14.0, *)
struct LocationPreview_Previews: PreviewProvider {
    static var previews: some View {
        LocationPreview("3467 Lincoln Hwy E, Thorndale, PA 19372")
    }
}

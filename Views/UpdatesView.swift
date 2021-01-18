//
//  UpdatesView.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 12/17/20.
//  Copyright © 2020 Software Development HS_902. All rights reserved.
//
import Firebase
import FirebaseFirestore
import SwiftUI

@available(iOS 14.0, *)
struct UpdatesView: View {
    @State var lessQuarantine: Bool = false
    @State var moreQuarantine: Bool = false
    @State var noQuarantine: Bool = false
    @State var alertMessage: String = "different"
    @ObservedObject var user: User = User()
    
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "MMM d"
        return formatter
    }

    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 20){
                    if user.enterLocation==true{
                        Text("Exits")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        HStack{
                            Spacer()
                        ExitsView(Location(user.endLocationRequests["address"]!), User())
                            Spacer()
                        }
                    }
                    Text("Status")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .navigationBarTitle("Updates")
                    VStack(alignment: .leading){
                        HStack{
                            Text("Risk Assesment:")
                                .font(.title3)
                            Text(user.evaluateRisk() == RiskValues.green ? "Green": (user.evaluateRisk() == RiskValues.yellow ? "Yellow": "Red"))
                                .font(.title3)
                                .foregroundColor(user.evaluateRisk() == RiskValues.green ? .green: (user.evaluateRisk() == RiskValues.yellow ? .yellow: .red))
                                .fontWeight(.bold)
                            
                        }
                        HStack{
                            
                            Text("Status:")
                                .font(.title3)
                            Text(user.status == InfectionStatus.positive ? "Positive": "Negative")
                                .font(.title3)
                                .foregroundColor(user.status == InfectionStatus.positive ? .red: .green)
                                .fontWeight(.bold)
                        }
                        if user.status == InfectionStatus.positive{
                            HStack{
                            
                            Text("Quarantine End Date:")
                                .font(.title3)
                            Text(dateFormatter.string(from: user.quarantineDate.dateValue()))
                                .font(.title3)
                                .foregroundColor(user.status == InfectionStatus.positive ? .red: .green)
                                .fontWeight(.bold)
                        }
                        }
                    }.padding([.trailing, .leading], 20)
                    if user.status != .positive{
                        NavigationLink(destination: QuestionnaireCovid()) {
                            HStack{
                                Spacer()
                                HStack {
                                    Text("Feel Sick?")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }
                                .padding(10)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(40)
                                Spacer()
                            }
                        }
                    }
                    Text("Notifications")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    ForEach(user.notifications.reversed()){notification in
                        NotificationsView(notification: notification)
                    }
                }
            }.padding()
        }
    }
}

@available(iOS 14.0, *)
struct NotificationsView: View{
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "MM-dd-yy h:mm a"
        return formatter
    }
    var notification: Notification=Notification("Default Notification", "Random Message", Timestamp())
    var body: some View{
        VStack(alignment: .leading) {
            Text(self.notification.title)
                .font(.title3)
            Text(dateFormatter.string(from: self.notification.date.dateValue()))
                .font(.subheadline)
            Text(self.notification.body)
                .font(.caption)
        }
        .padding()
        .background(Color(red: 0.8, green: 0.80, blue: 0.80, opacity: 1.0))
        .cornerRadius(20)
        
        
        
    }
}

@available(iOS 14.0, *)
struct ExitsView: View{
    init(_ location: Location, _ user: User){
        self.location=location
        self.user=user
    }
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    @ObservedObject var location: Location
    @ObservedObject var user: User
    @State var alerted: Bool = false
    @State var updateTime: Bool = false
    
    var body: some View{
        VStack{
            Text(self.location.name)
                .font(.title2)
            Text(dateFormatter.string(from: self.user.timeStart.dateValue()))
            NavigationLink(destination: DatePickerView(location, User()), isActive: $updateTime){}
            Button(action: {alerted.toggle()}, label: {
                Text("Exit Location")
            })
            .padding(10)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(40)
        }
        .padding()
        .background(Color(red: 0.8, green: 0.80, blue: 0.80, opacity: 1.0))
        .cornerRadius(20)
        .alert(isPresented: $alerted){
            let yesButton = Alert.Button.default(Text("Yes")) {
                print("yes button pressed")
                user.exitLocation(location)
            }
            let noButton = Alert.Button.default(Text("No")) {
                print("no button pressed")
                updateTime.toggle()
            }
            return Alert(title: Text("Exit Location"), message: Text("Is the current time now when you left the location?"), primaryButton: yesButton, secondaryButton: noButton)
        }
    }
}

@available(iOS 14.0, *)
struct UpdatesView_Previews: PreviewProvider {
    @State var alwaysTrue = true
    static var previews: some View {
        UpdatesView()
    }
}

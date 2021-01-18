//
//  DatePickerView.swift
//  Pods
//
//  Created by Software Development HS_902 on 12/17/20.
//

import SwiftUI

@available(iOS 14.0, *)
struct DatePickerView: View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    @State var submit: Bool = false
    @State var alert: Bool = false
    @State private var exitDate = Date()
    @ObservedObject var location: Location
    @ObservedObject var user: User

    init(_ location: Location, _ user: User){
        self.location=location
        self.user=user
    }

    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 20) {
            Text("What time did you leave the location?")
            DatePicker(selection: $exitDate, in: User().checkEndTime()..., displayedComponents: [.date, .hourAndMinute]) {
            }.labelsHidden()

                NavigationLink(destination: UpdatesView(), isActive: $submit){}
            Button(action: {
                if user.checkEndTime() < exitDate{
                    user.exitLocation(location, exitDate)
                    submit = true
                }else{
                    alert = true
                    //alert.toggle()
                }
            }, label: {
                Text("Submit")
            })
            .padding(10)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(40)
            Spacer()
        }.alert(isPresented: $alert){
            return Alert(title: Text("Invalid Time"), message: Text("Time entered was earlier than time of entry. Please try again."), dismissButton: .default(Text("Ok")))
        }.navigationBarTitle("Pick Date")
            .padding(.all, 30)
        }
    }
}

@available(iOS 14.0, *)
struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(Location("3467 Lincoln Highway"), User())
        
    }
}

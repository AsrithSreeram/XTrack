//
//  SubmitSymptomsFormView.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 12/27/20.
//  Copyright © 2020 Software Development HS_902. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct SubmitSymptomsFormView: View {
    @State var message = "Default"
    var results: SurveyQuestions?
    @ObservedObject var user = User()
    init(_ results: SurveyQuestions, _ submitted: Bool){
        if submitted{
            self.results=results
            self.user.checkInfection(results)
            print("Evaluation Results", self.user.performEvaluation(results))
            self.message=self.user.performEvaluation(results)
            print("Message 2", self.message)
            print("Form Submitted???")
        }
    }
    var body: some View {
        NavigationLink(
            destination: UpdatesView(),
            isActive: .constant(true),
            label: {})
        LoadingSpinner(animate: .constant(true))
    }
}

@available(iOS 14.0, *)
struct SubmitSymptomsFormView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitSymptomsFormView(SurveyQuestions(), false)
    }
}


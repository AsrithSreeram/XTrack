////  Question.swift//  CovidTracker////  Created by Software Development HS_902 on 12/20/20.//  Copyright  2020 Software Development HS_902. All rights reserved.//
import Foundation
@available(iOS 14.0, *)
class Question: Identifiable, ObservableObject {
    let id=UUID().uuidString
    @Published var question: String
    @Published var answer: Bool
    init(_ question: String, _ answer: Bool = false){
        self.question=question
        self.answer=answer
    }
}

@available(iOS 14.0, *)
class SurveyQuestions: ObservableObject{
    @Published var arrOfQuestions: [Question] = [Question("Do you have a sore throat, cough, chills, body aches for unknown reasons, shortness of breath for unknown reasons, loss of smell or taste, fever at or greater than 100 degrees Fahrenheit?"),
                                                 Question("Have you or anyone in your household been tested positive for COVID-19?"),
                                                 Question("Have you or anyone in your household visited or received treatment in a hospital, nursing home, long-term care, or other health care facility in the past 30 days?"),
                                                 Question("Have you or anyone in your household traveled abroad in the past 21 days?"),
                                                 Question("To the best of your knowledge have you been in close proximity to any individual who tested positive for COVID-19?"),
                                                 Question("If you were tested for COVID-19, was your result positive?")]
    init(){}
}

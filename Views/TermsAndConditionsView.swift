//
//  TermsAndConditionsView.swift
//  Pods
//
//  Created by Software Development HS_902 on 12/17/20.
//

import SwiftUI

@available(iOS 14.0, *)
struct TermsAndConditionsView: View {
    var titles=["END USER LICENSE AGREEMENT",
                "1. THE APPLICATION",
                "2. SCOPE OF LICENSE",
                "3. TECHNICAL REQUIREMENTS",
                "4. MAINTENANCE AND SUPPORT",
                "5. USER GENERATED CONTRIBUTIONS",
                "6. CONTRIBUTION LICENSE",
                "7. LIABILITY",
                "8. WARRANTY",
                "9. PRODUCT CLAIMS",
                "10. LEGAL COMPLIANCE",
                "11. CONTACT INFORMATION",
                "12. TERMINATION",
                "13. THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY",
                "14. INTELLECTUAL PROPERTY RIGHTS",
                "15. APPLICABLE LAW",
                "16. MISCELLANEOUS"
                
                ]
    
    var bodies=[
        
        """
Covid-19 Tracker is licensed to You by COVID-19 Tracker, located in the United States for use only under the terms of this License Agreement.\nBy downloading the Application from the Apple AppStore, and any update thereto (as permitted by this License Agreement), You indicate that You agree to be bound by all of the terms and conditions of this License Agreement, and that You accept this License Agreement.\nThe parties of this License Agreement acknowledge that Apple is not a Party to this License Agreement and is not bound by any provisions or obligations with regard to the Application, such as warranty, liability, maintenance and support thereof. COVID-19 Tracker, not Apple, is solely responsible for the licensed Application and the content thereof.\nThis License Agreement may not provide for usage rules for the Application that are in conflict with the latest App Store Terms of Service. COVID-19 Tracker acknowledges that it had the opportunity to review said terms and this License Agreement is not conflicting with them.\nAll rights not expressly granted to You are reserved.
""",
        """
Covid-19 Tracker is a piece of software created to educate the user regarding the status of Covid-19 in distinct locations around their area. - and customized for Apple mobile devices. It is used to view the possible risk associated with entering a certain location by using a QR scan to assess the danger of it.\nThe Application is not tailored to comply with industry-specific regulations (Health Insurance Portability and Accountability Act (HIPAA), Federal Information Security Management Act (FISMA), etc.), so if your interactions would be subjected to such laws, you may not use this Application. You may not use the Application in a way that would violate the Gramm-Leach-Bliley Act (GLBA).
""",
        """
2.1  You are given a non-transferable, non-exclusive, non-sublicensable license to install and use the Licensed Application on any Apple-branded Products that You (End-User) own or control and as permitted by the Usage Rules set forth in this section and the App Store Terms of Service, with the exception that such licensed Application may be accessed and used by other accounts associated with You (End-User, The Purchaser) via Family Sharing or volume purchasing.\n2.2  This license will also govern any updates of the Application provided by Licensor that replace, repair, and/or supplement the first Application, unless a separate license is provided for such update in which case the terms of that new license will govern.\n2.3  You may not share or make the Application available to third parties (unless to the degree allowed by the Apple Terms and Conditions, and with COVID-19 Tracker's prior written consent), sell, rent, lend, lease or otherwise redistribute the Application.\n2.4  You may not reverse engineer, translate, disassemble, integrate, decompile, integrate, remove, modify, combine, create derivative works or updates of, adapt, or attempt to derive the source code of the Application, or any part thereof (except with COVID-19 Tracker's prior written consent).\n2.5  You may not copy (excluding when expressly authorized by this license and the Usage Rules) or alter the Application or portions thereof. You may create and store copies only on devices that You own or control for backup keeping under the terms of this license, the App Store Terms of Service, and any other terms and conditions that apply to the device or software used. You may not remove any intellectual property notices. You acknowledge that no unauthorized third parties may gain access to these copies at any time.\n2.6  Violations of the obligations mentioned above, as well as the attempt of such infringement, may be subject to prosecution and damages.\n2.7  Licensor reserves the right to modify the terms and conditions of licensing.\n2.8  Nothing in this license should be interpreted to restrict third-party terms. When using the Application, You must ensure that You comply with applicable third-party terms and conditions.
""",
        """
3.1  Licensor attempts to keep the Application updated so that it complies with modified/new versions of the firmware and new hardware. You are not granted rights to claim such an update.\n3.2  Licensor reserves the right to modify the technical specifications as it sees appropriate at any time.
""",
        """
4.1  The Licensor is solely responsible for providing any maintenance and support services for this licensed Application. You can reach the Licensor at the email address listed in the App Store Overview for this licensed Application.\n4.2  COVID-19 Tracker and the End-User acknowledge that Apple has no obligation whatsoever to furnish any maintenance and support services with respect to the licensed Application.
""",
        """
The Application may invite you to chat, contribute to, or participate in blogs, message boards, online forums, and other functionality, and may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or in the Application, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, 'Contributions'). Contributions may be viewable by other users of the Application and through third-party websites or applications. As such, any Contributions you transmit may be treated as non-confidential and non-proprietary. When you create or make available any Contributions, you thereby represent and warrant that:\n1. The creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your Contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party.\n2. You are the creator and owner of or have the necessary licenses, rights, consents, releases, and permissions to use and to authorize us, the Application, and other users of the Application to use your Contributions in any manner contemplated by the Application and these Terms of Use.\n3. You have the written consent, release, and/or permission of each and every identifiable individual person in your Contributions to use the name or likeness or each and every such identifiable individual person to enable inclusion and use of your Contributions in any manner contemplated by the Application and these Terms of Use.\n4. Your Contributions are not false, inaccurate, or misleading.\n5. Your Contributions are not unsolicited or unauthorized advertising, promotional materials, pyramid schemes, chain letters, spam, mass mailings, or other forms of solicitation.\n6. Your Contributions are not obscene, lewd, lascivious, filthy, violent, harassing, libelous, slanderous, or otherwise objectionable (as determined by us).\n7. Your Contributions do not ridicule, mock, disparage, intimidate, or abuse anyone.\n8. Your Contributions are not used to harass or threaten (in the legal sense of those terms) any other person and to promote violence against a specific person or class of people.\n9. Your Contributions do not violate any applicable law, regulation, or rule.\n10. Your Contributions do not violate the privacy or publicity rights of any third party.\n11. Your Contributions do not contain any material that solicits personal information from anyone under the age of 18 or exploits people under the age of 18 in a sexual or violent manner.\n12. Your Contributions do not violate any applicable law concerning child pornography, or otherwise intended to protect the health or well-being of minors.\n13. Your Contributions do not include any offensive comments that are connected to race, national origin, gender, sexual preference, or physical handicap.\n14. Your Contributions do not otherwise violate, or link to material that violates, any provision of these Terms of Use, or any applicable law or regulation.\nAny use of the Application in violation of the foregoing violates these Terms of Use and may result in, among other things, termination or suspension of your rights to use the Application.
""",
        """
By posting your Contributions to any part of the Application or making Contributions accessible to the Application by linking your account from the Application to any of your social networking accounts, you automatically grant, and you represent and warrant that you have the right to grant, to us an unrestricted, unlimited, irrevocable, perpetual, non-exclusive, transferable, royalty-free, fully-paid, worldwide right, and license to host, use copy, reproduce, disclose, sell, resell, publish, broad cast, retitle, archive, store, cache, publicly display, reformat, translate, transmit, excerpt (in whole or in part), and distribute such Contributions (including, without limitation, your image and voice) for any purpose, commercial advertising, or otherwise, and to prepare derivative works of, or incorporate in other works, such as Contributions, and grant and authorize sublicenses of the foregoing. The use and distribution may occur in any media formats and through any media channels.\nThis license will apply to any form, media, or technology now known or hereafter developed, and includes our use of your name, company name, and franchise name, as applicable, and any of the trademarks, service marks, trade names, logos, and personal and commercial images you provide. You waive all moral rights in your Contributions, and you warrant that moral rights have not otherwise been asserted in your Contributions.\nWe do not assert any ownership over your Contributions. You retain full ownership of all of your Contributions and any intellectual property rights or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your Contributions provided by you in any area in the Application. You are solely responsible for your Contributions to the Application and you expressly agree to exonerate us from any and all responsibility and to refrain from any legal action against us regarding your Contributions.\nWe have the right, in our sole and absolute discretion, (1) to edit, redact, or otherwise change any Contributions; (2) to re-categorize any Contributions to place them in more appropriate locations in the Application; and (3) to pre-screen or delete any Contributions at any time and for any reason, without notice. We have no obligation to monitor your Contributions.
""",
        """
7.1  Licensor's responsibility in the case of violation of obligations and tort shall be limited to intent and gross negligence. Only in case of a breach of essential contractual duties (cardinal obligations), Licensor shall also be liable in case of slight negligence. In any case, liability shall be limited to the foreseeable, contractually typical damages. The limitation mentioned above does not apply to injuries to life, limb, or health.
""",
        """
8.1  Licensor warrants that the Application is free of spyware, trojan horses, viruses, or any other malware at the time of Your download. Licensor warrants that the Application works as described in the user documentation.\n8.2  No warranty is provided for the Application that is not executable on the device, that has been unauthorizedly modified, handled inappropriately or culpably, combined or installed with inappropriate hardware or software, used with inappropriate accessories, regardless if by Yourself or by third parties, or if there are any other reasons outside of COVID-19 Tracker's sphere of influence that affect the executability of the Application.\n8.3  You are required to inspect the Application immediately after installing it and notify COVID-19 Tracker about issues discovered without delay by e-mail provided in Product Claims. The defect report will be taken into consideration and further investigated if it has been mailed within a period of ninety (90) days after discovery.\n8.4  If we confirm that the Application is defective, COVID-19 Tracker reserves a choice to remedy the situation either by means of solving the defect or substitute delivery.\n8.5  In the event of any failure of the Application to conform to any applicable warranty, You may notify the App-Store-Operator, and Your Application purchase price will be refunded to You. To the maximum extent permitted by applicable law, the App-Store-Operator will have no other warranty obligation whatsoever with respect to the App, and any other losses, claims, damages, liabilities, expenses and costs attributable to any negligence to adhere to any warranty.\n8.6  If the user is an entrepreneur, any claim based on faults expires after a statutory period of limitation amounting to twelve (12) months after the Application was made available to the user. The statutory periods of limitation given by law apply for users who are consumers.
""",
        """
COVID-19 Tracker and the End-User acknowledge that COVID-19 Tracker, and not Apple, is responsible for addressing any claims of the End-User or any third party relating to the licensed Application or the End-Userís possession and/or use of that licensed Application, including, but not limited to:\n(i) product liability claims;\n(ii) any claim that the licensed Application fails to conform to any applicable legal or regulatory requirement; and\n(iii) claims arising under consumer protection, privacy, or similar legislation, including in connection with Your Licensed Applicationís use of the HealthKit and HomeKit.
""",
        """
You represent and warrant that You are not located in a country that is subject to a U.S. Government embargo, or that has been designated by the U.S. Government as a 'terrorist supporting' country; and that You are not listed on any U.S. Government list of prohibited or restricted parties.
""",
        """
For general inquiries, complaints, questions or claims concerning the licensed Application, please write a review.
""",
        """
The license is valid until terminated by COVID-19 Tracker or by You. Your rights under this license will terminate automatically and without notice from COVID-19 Tracker if You fail to adhere to any term(s) of this license. Upon License termination, You shall stop all use of the Application, and destroy all copies, full or partial, of the Application.
""",
        """
COVID-19 Tracker represents and warrants that COVID-19 Tracker will comply with applicable third-party terms of agreement when using licensed Application.\nIn Accordance with Section 9 of the 'Instructions for Minimum Terms of Developer's End-User License Agreement,' Apple and Apple's subsidiaries shall be third-party beneficiaries of this End User License Agreement and - upon Your acceptance of the terms and conditions of this license agreement, Apple will have the right (and will be deemed to have accepted the right) to enforce this End User License Agreement against You as a third-party beneficiary thereof.
""",
        """
COVID-19 Tracker and the End-User acknowledge that, in the event of any third-party claim that the licensed Application or the End-User's possession and use of that licensed Application infringes on the third party's intellectual property rights, COVID-19 Tracker, and not Apple, will be solely responsible for the investigation, defense, settlement and discharge or any such intellectual property infringement claims.
""",
        """

This license agreement is governed by the laws of the Commonwealth of Pennsylvania excluding its conflicts of law rules.
""",
        """
16.1  If any of the terms of this agreement should be or become invalid, the validity of the remaining provisions shall not be affected. Invalid terms will be replaced by valid ones formulated in a way that will achieve the primary purpose.\n16.2  Collateral agreements, changes and amendments are only valid if laid down in writing. The preceding clause can only be waived in writing.
"""
 
                ]
    

    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20){
                ForEach(0..<titles.count){i in
                    Text(titles[i])
                        .fontWeight(.bold)
                    VStack(alignment: .leading){
                        ForEach(0..<bodies[i].split(separator: "\n").count){j in
                            Text(bodies[i].split(separator: "\n")[j])
                                .font(.caption)
                        }
                    }.padding(.leading, 20)
                }
            }.padding()
        }.navigationBarTitle("Terms and Conditions", displayMode: .inline)
    }
}

@available(iOS 14.0, *)
struct TermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionsView()
    }
}



//
//  ErrorView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 18/07/21.
//

import SwiftUI

enum ErrorType {
    case generic
    case offline
    case tooManyRequests
}

struct ErrorView: View {
    
    private var retryAction: () -> Void
    
    @State
    private var errorData: (icon: String, message: String)
    
    init(_ errorType: ErrorType, retryAction: @escaping () -> Void) {
        switch errorType {
            case .offline:
                errorData = (icon: "ErrorOfflineIcon", "Opps...Your internet connection seems off. Please try again.")
            case .tooManyRequests:
                errorData = (icon: "TooManyRequestsIcon", "Opps...It seems you exceeded the maximum API requests allowed. \n\nPlease try again in a couple of minutes.")
            case .generic:
                errorData = (icon: "ErrorIcon", "Opps...An error ocurred. \nPlease try again.")
        }
        self.retryAction = retryAction
    }
    
    var body: some View {
        
        VStack {
            Spacer()
            Image(errorData.icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(ColorPalette.secondaryColor)
                .frame(width: 150, height: 150)
                .padding(.bottom, 40)
            
            Text(errorData.message)
                .font(.body)
                .bold()
                .foregroundColor(ColorPalette.tertiaryColor)
                .multilineTextAlignment(.center)
            
            Spacer()
            Button("Try again") {
                retryAction()
            }
            .foregroundColor(ColorPalette.primaryColor)
            .padding(.vertical, 12)
            .padding(.horizontal, 30)
            .font(.subheadline.weight(.bold))
            .background(ColorPalette.ascentContrastColor)
            .cornerRadius(35)
            .padding(.bottom, 20)
        }
        
        .frame(width: 350, alignment: .center)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(.tooManyRequests, retryAction: {})
//            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
    }
}

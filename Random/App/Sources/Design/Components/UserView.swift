//
//  UserView.swift
//  Random
//
//  Created by Shayan Ali on 01.02.23.
//

import SwiftUI

struct UserView: View {
    var state: UserState
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignConstants.defaultSpacing) {
            HStack(spacing: DesignConstants.defaultSpacing) {
                Text(state.firstName)
                Text(state.lastName)
                Spacer()
            }
            .font(.title)
            Text(state.email)
                .bold()
        }
        .padding()
    }
}

#if DEBUG
struct UserView_Previews: PreviewProvider {
    static let state = UserState(firstName: "Shayan", lastName: "Ali", email: "syed.shayan18@gmail.com")
    
    static var previews: some View {
        UserView(state: state)
    }
}
#endif






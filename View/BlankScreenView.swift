//
//  BlankScreenView.swift
//  Devote
//
//  Created by Yogesh Raut on 07/01/25.
//

import SwiftUI

struct BlankScreenView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.black)
        .opacity(0.5)
    }
}

struct BlankScreenView_Previews: PreviewProvider {
    static var previews: some View {
        BlankScreenView()
    }
}

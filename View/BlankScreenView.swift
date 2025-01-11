//
//  BlankScreenView.swift
//  Devote
//
//  Created by Yogesh Raut on 07/01/25.
//

import SwiftUI

struct BlankScreenView: View {
    //MARK: - PROPERTIES
    var backgroundColor : Color
    var backgroundOpacity : Double
    
    //MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}
    //MARK: - PREVIEWS
struct BlankScreenView_Previews: PreviewProvider {
    static var previews: some View {
        BlankScreenView(backgroundColor: Color.black, backgroundOpacity: 0.35)
            .background(BackgroundImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
    }
}

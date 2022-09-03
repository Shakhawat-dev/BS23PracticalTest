//
//  NoDataView.swift
//  BS23PracticalTest
//
//  Created by Shakhawat Hossain Shahin on 4/9/22.
//

import SwiftUI

struct NoDataView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray.2")
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            
            Text("No Data")
                .font(.title)
        }
    }

}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView()
    }
}

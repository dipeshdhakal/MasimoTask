//
//  DevicesView.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import SwiftUI

struct DevicesView: View {
    
    @StateObject var viewModel: DevicesViewModel
    
    init(viewModel: DevicesViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.devices, id:\.id) { device in
                    HStack {
                        AsyncImage(url: URL(string: device.artwork)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 60, height: 60)
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 60, maxHeight: 60)
                                    .cornerRadius(10)
                            default:
                                Image(systemName: "photo")
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(device.deviceTitle)
                                .font(.title2)
                            HStack {
                                Image(systemName: "waveform")
                                Text(device.trackTitle)
                                Text(device.artistTitle)
                            }
                        }
                        .foregroundStyle(device.foregroundColor)
                        Spacer()
                    }
                    .padding()
                    .background(device.backgroundColor.clipShape(RoundedRectangle(cornerRadius:10)))
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        viewModel.didTapOnDevice(deviceID: device.deviceID)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Devices")
        }
    }
}


#Preview {
    DevicesView(viewModel: DevicesViewModel(masimoManager: MockMasimoManager()))
}


extension DeviceDisplayable {
    
    var foregroundColor: Color {
        return isPlaying ? Color.white : Color.black
    }
    
    var backgroundColor: Color {
        return isPlaying ? Color.black : Color.bgColor
    }
}

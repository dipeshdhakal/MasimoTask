//
//  DevicesView.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import SwiftUI

struct DevicesView: View {
    
    @ObservedObject var viewModel: DevicesViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch viewModel.deviceState {
                case .loading:
                    ProgressView()
                case .failure(let error):
                    ContentUnavailableView {
                        Label("Failed to load data", systemImage: "bookmark")
                    } description: {
                        Text(error)
                    }
                case .empty:
                    ContentUnavailableView {
                        Label("No devices available", systemImage: "bookmark")
                    } description: {
                        Text("Please try again at a later time")
                    }
                case .success:
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
                                            .frame(width: 60, height: 60)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Text(device.deviceTitle)
                                        .font(.title2)
                                    HStack {
                                        Image(systemName: device.isPlaying ? "waveform" : "pause.fill")
                                        Text(device.trackTitle)
                                            .lineLimit(1)
                                        Text(device.artistTitle)
                                            .lineLimit(1)
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
                }
            }
            .navigationTitle("Devices")
        }
    }
}


#Preview {
    DevicesView(viewModel: DevicesViewModel(masimoManager: MockMasimoManager()))
}


extension DeviceData {
    
    var foregroundColor: Color {
        return isSelected ? Color.white : Color.black
    }
    
    var backgroundColor: Color {
        return isSelected ? Color.black : Color.bgColor
    }
}

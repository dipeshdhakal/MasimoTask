//
//  NowPlayingView.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import SwiftUI

struct NowPlayingView: View {
    
    @StateObject var viewModel: NowPlayingViewModel
    @State private var volume: Double = 0.5
    @State private var time: Double = 0.2
    @State private var isMuted: Bool = false
    @State private var isPlaying: Bool = true
    @State private var musicLength: TimeInterval = 240
    
    init(viewModel: NowPlayingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let currentDevice = viewModel.currentDevice {
                Text(currentDevice.deviceTitle)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 20)
                AsyncImage(url: URL(string: currentDevice.largeArtwork)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 200, height: 200)
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 200, maxHeight: 200)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    default:
                        Image(systemName: "photo")
                    }
                    Slider(value: $time)
                        .accentColor(.black)
                        .padding(.bottom, -10)
                    HStack {
                        Text((musicLength * time).toMMSS)
                        Spacer()
                        Text(musicLength.toMMSS)
                    }
                    .padding(.bottom, 20)
                    HStack {
                        Text(currentDevice.trackTitle)
                            .font(.title2)
                        Spacer()
                    }
                    HStack {
                        Text(currentDevice.artistTitle)
                            .font(.title3)
                        Spacer()
                    }
                    .frame(width: .infinity)
                    .padding(.bottom, 20)
                    HStack(spacing: 30) {
                        Image(systemName: "repeat")
                            .font(.title2)
                        Image(systemName: "backward.fill")
                            .font(.title2)
                        Image(isPlaying ? "now_playing_controls_play" : "now_playing_controls_pause")
                            .font(.title2)
                            .onTapGesture {
                                isPlaying.toggle()
                            }
                        Image(systemName: "forward.fill")
                            .font(.title2)
                        Image(systemName: "shuffle")
                            .font(.title2)
                    }
                    .padding(.bottom, 40)
                    HStack {
                        Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.1.fill")
                            .onTapGesture {
                                isMuted.toggle()
                            }
                        Slider(value: $volume)
                            .accentColor(.black)
                    }
                    Text(currentDevice.deviceTitle)
                    Spacer()
                }
            } else {
                ContentUnavailableView("", systemImage: "photo")
            }
            
        }
        .padding()
    }
}

#Preview {
    NowPlayingView(viewModel: NowPlayingViewModel(masimoManager: MockMasimoManager()))
}

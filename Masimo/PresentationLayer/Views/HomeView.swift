//
//  HomeView.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        TabView {
            ForEach(viewModel.tabs, id: \.id) { tab in
                getTabView(tab: tab)
                    .tabItem {
                        Label {
                            Text(tab.title)
                        } icon: {
                            Image(tab.iconName)
                        }

                    }
            }
        }
        .accentColor(.red)
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.bgColor
            UITabBar.appearance().unselectedItemTintColor = .black
        }
    }
    
    @ViewBuilder
    func getTabView(tab: HomeTab) -> some View {
        switch tab {
        case .devices:
            DevicesView(viewModel: DevicesViewModel(masimoManager: viewModel.masimoManager))
        case .nowPlaying:
            NowPlayingView(viewModel: NowPlayingViewModel(masimoManager: viewModel.masimoManager))
        case .settings:
            SettingsView(showMockData: $viewModel.isMockData)
        }
    }
    
}

#Preview {
    HomeView()
}

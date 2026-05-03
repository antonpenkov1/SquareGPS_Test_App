//
//  SquareGPS_Test_AppApp.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import SwiftUI
import CoreData

@main
struct SquareGPS_Test_taskApp: App {
    let coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            TrackersListView(
                viewModel: TrackersListViewModel(
                    getTrackersUseCase: GetTrackersUseCase(
                        repository: TrackerRepositoryImpl(
                            apiService: ApiService(),
                            trackerDao: TrackerDao(coreDataStack: coreDataStack)
                        )
                    )
                )
            )
            .environment(\.managedObjectContext, coreDataStack.managedContext)
        }
    }
}

//
//  ToDoApp.swift
//  ToDo
//
//  Created by 付铭 on 2022/7/12.
//

import SwiftUI

@main
struct ToDoApp: App {

    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()

    var body: some Scene {
        WindowGroup {
                ContentView3()
            //.environmentObject(taskViewModel)
        }
    }
}

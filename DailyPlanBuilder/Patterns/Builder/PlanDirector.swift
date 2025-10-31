import Foundation

/// Director controls the construction order using the Builder.
/// Clients choose the builder; director tells when to build each part.
struct PlanDirector {
    func makeDeepFocusDay(with builder: DailyPlanBuilder) -> DailyPlan {
        builder.reset(title: "Deep Focus Day")
        builder.addFocus(minutes: 90, note: "Pomodoro blocks")
        builder.addBreak(minutes: 15, note: "Walk + water")
        builder.addFocus(minutes: 90, note: "Mute notifications")
        builder.addStudy(minutes: 45, note: "Read & notes")
        builder.addWorkout(minutes: 30, note: "Quick HIIT")
        return builder.build()
    }

    func makeBalancedDay(with builder: DailyPlanBuilder) -> DailyPlan {
        builder.reset(title: "Balanced Day")
        builder.addStudy(minutes: 60, note: "Course module")
        builder.addBreak(minutes: 15, note: "Stretching")
        builder.addFocus(minutes: 60, note: "Project task")
        builder.addWorkout(minutes: 45, note: "Gym")
        builder.addBreak(minutes: 20, note: "Coffee + rest")
        return builder.build()
    }
}

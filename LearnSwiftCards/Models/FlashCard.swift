import Foundation

struct FlashCard: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
    
    // Sample data
    static let sampleData = [
        FlashCard(question: "What is SwiftUI?", answer: "A declarative framework for building user interfaces across Apple platforms"),
        FlashCard(question: "What is MVVM?", answer: "Model-View-ViewModel: an architectural pattern that separates UI from business logic"),
        FlashCard(question: "What is a closure in Swift?", answer: "A self-contained block of functionality that can be passed around and used in your code"),
        FlashCard(question: "What does optionals mean in Swift?", answer: "A type that represents either a wrapped value or nil (the absence of a value)"),
        FlashCard(question: "What is a property wrapper?", answer: "A type that adds behavior or validation to a properpropertypropertypropertypropertypropertypropertypropertypropertypropertypropertypropertypropertypropertypropertypropertyty"),
        FlashCard(question: "What is the difference between struct and class?", answer: "Structs are value types, classes are reference types"),
        FlashCard(question: "What is a protocol?", answer: "A blueprint of methods, properties, and requirements"),
        FlashCard(question: "What is an extension?", answer: "A way to add new functionality to an existing class, structure, enumeration, or protocol")
    ]
} 

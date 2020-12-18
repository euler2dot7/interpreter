# Software architecture of interpreter in Dart (Flutter)

This project is a part of my tech talk about OOP design of interpreters. 

## Arithmetic expressions interpreter. 
The software accept arithmetic expression in input and provide 3 interpretation: 
* Result of evaluation
* Abstract Syntax Tree structure
* Stack machine assembler representation

### Demo Application 
  * The web app is available here ->  [demo](https://euler2dot7.github.io/interpreter/#/)

### Example: 
  ![Example](/presentation/demo.png?raw=true "") 

## Software Architecture in UML

  ### Domain model
 ![Domain model of expression evaluator](/presentation/domain_model.png?raw=true "") 
  ### Structure
 ![Package diagram](/presentation/structure.png?raw=true "") 
  ### Interaction
 ![Interaction diagram](/presentation/interaction.png?raw=true "") 
  ### AST evaluator (Visitor Pattern) 
 ![Visitor Pattern](/presentation/visitor.png?raw=true "") 

 
## Build

I used Android Studio in order to build: 
* Web App 
* Mobile App 
* Desktop App 

## Presentation
* Link to presentation -> [presentation](/presentation/interpreter.pdf)

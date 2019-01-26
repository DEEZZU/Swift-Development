//: [Previous](@previous)
// fundamental types : Int, Double, Float, Bool, String
// Collection types : Array, Set, Dictionary
// Variables : to store data , refered to identify values
// Constants : variables whose values cannot be changed , more powerful >??
// makes code safer and clearer in intent
// Advanced Types : Tuples , enables to create and pass arounf groupings of values : multiple value return as a single compound
// Optionals : handle the absence of the value  : value or nil : can work for any type not just classes like in obj-C : more expressive, safer
// TYPE-SAFE Language : helps you to be clear of type of value the code can use . helps within the development process


// CONSTANTS AND VARIABLES
// value and particular type are associated
let anotherConstant = 10
var anotherVariable = 0
// multiple declaration
 var x=10.0, y=19.4, z=0.0

// TYPE ANNOTATIONS
// annotate a type to indicate the type of the value variable can store : String
var welcomeMesage: String = "I am here."
welcomeMesage = "Hello World"
// Multiple Declarations: annotated type
var red:Double = 4.5 , blue:Double = 6.7 , green:Double = 9.4 //<=== This requires attention
// green = 5.6
// blue = 7.6

// NAMING CONSTANTS AND VARIABLES
// name can contain any character
var 🍔: String = "This burger contains AT"
// naming converntion : unicode character + no spacing + any character + no ( mathematical symbols + arrows+ private use unicode scalar values (??) + line- or box- drawing characters ) + cannot begin with numbers , though they may occur anywhere
// redeclaration of variables not allowed , var of certain types cant change value just like constants
// var -> const or vice versa conversion not possible
// NOTE : giving a keywors or constant same name as a reserved keyword, surround it by (`) <- backticks
//var (')var(') = 45

// PRINTING
print(welcomeMesage)
// print function has two parameters : separators , terminators : terminate at line break (default)
print(welcomeMesage, terminator: "!!!!")
// string interpolation : \() <-  to surpass datatype and print the content in the string
print ("Here is an example : \(red)")

// COMMENTS
// use comments to include non executable text in code , ignored by compiler
// single line : //  or multi line : /*....*/ : nested comments are possible

// SEMICOLON
// semicolons can be written after each statement
let broco = "🥦" ; print(broco)


// INTEGER
// no fractional component , can be signed or unsigned
// UInt8 : 8 bit unsigned integer
// Int32 : 32 bit signed
// 2 properties :  min and max
let minValue = UInt8.min
let maxValue = UInt8.max // + 1 <-  overflow

// Int : Int32, Int64
// print(Int.max)
// UInt : UInt32, UInt64


// FLOATING-POINT NUMBERS


//: [Next](@next)

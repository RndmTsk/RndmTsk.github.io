# Swift Basics: Constants and Variables

An intro to the Swift programming language with a tour through basic concepts including [_variable_](#Glossary) and _constant_ _declarations_.

#### _Constants_ and _Variables_

Using the `var` or `let` _keyword_ tells your program: “Please set aside some space, I’d like to remember something for later”. If you use `var` you’re saying: “This space will be used for a few different values as my program changes”, also known as a _variable_. Using `let` says: “This space will only ever have one specific value, it will not change”, another name for this is a _constant_.


#### Naming

Whether you’re using a _constant_ or a _variable_, you need to give it a _name_ if you want to use the value later in your program. Names have a few rules, like “You can’t have a _constant_ or _variable_ start with a number” but are otherwise pretty flexible, remember: if you don’t give it a name, why _declare_ it in the first place?


#### _Types_

Now that you’ve decided on a _constant_ or _variable_ and given it a _name_, it’s time to decide exactly what will be stored inside.

Swift has many different _types_ included to get you started, here are some of the more common ones:

- String: A collection of letters, numbers, punctuation, and more all stuffed between two quotation marks (“)
- Int: Any number you can think of that’s bigger than -9223372036854775808 and smaller than 922337203685477580. While that may be a lot, notice that you can’t add a decimal place, not a very good choice for handling your loose change!
- Double: Any number you can think of that’s bigger than 0.0... (continue typing “0” 306 times!)…2 and smaller than 1… (continue typing numbers 306 more times!)…0, wow!

#### _Assignment_

Simply saying that you have a `String` or an `Int` doesn't tell Swift which value you're actually storing. Setting or updating a value in your _variable_ is also known as _assignment_.


#### _Declarations_

Putting it all together, it looks like this:

```
let myString: String = "Hello World"
// A CONSTANT of TYPE String, with the VALUE 'Hello World'

var myInt: Int = 42
// A VARIABLE of TYPE Int, with the value '42'

let myDouble: Double = 2.71828
// A CONSTANT of TYPE Double, with the VALUE '2.71828'
```


## Glossary

- **keyword**: A word that is recognized as having special meaning to Swift. Examples include: `for`, `let`, `in`, and `if`.
- **variable**: TODO
- **constant**: TODO
- **name**: TODO
- **declare**: TODO
- **type**: TODO
- **declaration**: TODO
- **assignment**: TODO

### References

1. [A Swift Tour](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html)
2. [Intro to App Development with Swift](https://books.apple.com/us/book/intro-to-app-development-with-swift/id1118575552)
3. [Develop in Swift Fundamentals](https://books.apple.com/us/book/develop-in-swift-fundamentals/id1511184145)

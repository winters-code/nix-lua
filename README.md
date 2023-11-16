# nix-lua
Anyone can use this software how they please as long as this README file stays in the same place and isn't edited.

## About
Nix is a coding language that aims to be simple to learn yet powerful for advanced users.

## Examples
### "Hello, world!" program
```
fun main() {
    print("Hello, world!")
}
```

### Variables
```
fun main() {
    let x = 10
    let y = 20
    print(x)
    print(y)
    print(x + y)
}
```

### Functions
```
fun hello() {
    print("Hello, world!")
}

fun main() {
    hello()
}
```

### Variable passing
```
fun main() {
    let ref x = 10 // x will be passed by reference
    let val y = 10 // y will be passed by value
}
```

# Credits
 - [winterscode](http://www.winterscode.io/): Programming
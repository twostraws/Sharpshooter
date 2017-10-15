# Sharpshooter

Sharpshooter is an Xcode extension for Swift developers who like to debug code by inserting `print()` statements everywhere, which is totally not *you*, right?

The name comes from a joke about a Texan sharpshooter who fires  gunshots at the door of a barn, then draws a target around the biggest cluster of hits and claims to be a sharpshooter – a pretty accurate analogy for finding bugs using `print()`, I think.

It has only two features: Add Comments places `print()` calls at the start of all your methods, and Remove Comments removes the `print()` calls that were inserted.

Here’s an example of code before adding comments:

    class BrokenStuff {
        func broken() {
            print("<Silent screaming>")
        }
    
        private func reallyBroken() {
            print("<Tears>")
        }
    
        static private func superBroken() {
            print("<Silent screaming *and* tears>")
        }
    }

And after:

    class BrokenStuff {
        func broken() {
            print("# Sharpshooter: Entering broken()")
            print("<Silent screaming>")
        }
    
        private func reallyBroken() {
            print("# Sharpshooter: Entering reallyBroken()")
            print("<Tears>")
        }
    
        static private func superBroken() {
            print("# Sharpshooter: Entering superBroken()")
            print("<Silent screaming and tears>")
        }
    }

## Installation

Xcode extensions are compiled as part of a basically useless macOS app. I've built the extension for you and in theory it should work:

1. Go to [the latest release](https://github.com/twostraws/Sharpshooter/releases/latest)
2. Download and extract the zip.
3. Move Sharpshooter.app to your Mac's Applications directory. You may need to launch the app at least once to register its extension.
4. Relaunch Xcode.

To build the extension from scratch you need to:

1. Clone this repository.
2. Activate your team for signing both the macOS app and the extension.
3. Build the macOS app.
4. Move the built macOS app to your Mac’s Applications folder. You may need to launch the app at least once to register its extension.
5. Relaunch Xcode.

You can check that the extension is installed by going to your Mac's system preferences, choosing Extensions > Xcode Source Editor, and verifying that there's a check next to Sharpshooter.

## Contributing

Contributions are welcome as pull requests. You can file issues if you want, but realistically it’s probably better for everyone if you just fix the issue and open a pull request – the code is really simple.

## License

MIT, natch.

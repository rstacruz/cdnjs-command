# cdnjs-command
#### Command line helper for cdnjs.com.

This makes including JS files in your project easy-peasy. To add a JS libary
to your project:

    $ cdnjs jquery
    Created jquery-1.5.1.js.

You probably want to link the online version as well:

    $ cdnjs html jquery
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js'></script>

Or you may want just the URL:

    $ cdnjs url underscore
    http://ajax.cdnjs.com/ajax/libs/underscore.js/1.1.4/underscore-min.js

## Installation

Copy `bin/cdnjs` into your PATH somewhere, or use `gem install cdnjs-command`.

## Usage

    Usage:
      cdnjs NAME       - Download specific package

    Other commands:
      cdnjs list       - List available packages
      cdnjs info NAME  - Show package info
      cdnjs html NAME  - Show HTML snippet to include given package
      cdnjs url NAME   - Show the URL for the given package
      cdnjs update     - Updates the package cache

    You may also use the first letters of each command; e.g., `cdnjs i jquery`.
    Here are some common examples:

      $ cdnjs jquery
      $ echo `cdnjs h underscore` >> index.html

## Acknowledgements

 * [www.cdnjs.com](http://cdnjs.com)

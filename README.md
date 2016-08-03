# fetch-meshblu-public-key

[![Dependency status](http://img.shields.io/david/octoblu/fetch-meshblu-public-key.svg?style=flat)](https://david-dm.org/octoblu/fetch-meshblu-public-key)
[![devDependency Status](http://img.shields.io/david/dev/octoblu/fetch-meshblu-public-key.svg?style=flat)](https://david-dm.org/octoblu/fetch-meshblu-public-key#info=devDependencies)
[![Build Status](http://img.shields.io/travis/octoblu/fetch-meshblu-public-key.svg?style=flat)](https://travis-ci.org/octoblu/fetch-meshblu-public-key)

[![NPM](https://nodei.co/npm/fetch-meshblu-public-key.svg?style=flat)](https://npmjs.org/package/fetch-meshblu-public-key)

## Installing in a Project

```bash
npm install fetch-meshblu-public-key --save
```

Add the following to your `package.json`

```js
{
  // ...
  "scripts": {
    // ...
    "start": "fetch-meshblu-public-key && ...",
    // ...
  }
  // ...
}
```

## Installing Globally

```bash
npm install fetch-meshblu-public-key --global
```

### Usage

```bash
fetch-meshblu-public-key --meshblu-public-key-uri 'https://meshblu.octoblu.com/publickey'
```

or

```bash
fetch-meshblu-public-key -m 'https://meshblu.octoblu.com/publickey'
```

or

```bash
env MESHBLU_PUBLIC_KEY_URI='https://meshblu.octoblu.com/publickey' fetch-meshblu-public-key
```

or, use the default uri of `https://meshblu.octoblu.com/publickey`

```bash
fetch-meshblu-public-key
```

## License

The MIT License (MIT)

Copyright 2016 Octoblu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

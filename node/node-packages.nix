# This file has been generated by node2nix 1.5.1. Do not edit!

{nodeEnv, fetchurl, fetchgit, globalBuildInputs ? []}:

let
  sources = {
    "@flowjs/ng-flow-2.7.8" = {
      name = "_at_flowjs_slash_ng-flow";
      packageName = "@flowjs/ng-flow";
      version = "2.7.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/@flowjs/ng-flow/-/ng-flow-2.7.8.tgz";
        sha512 = "051wms4pyyzmvak80w923i3psp0a9dpnf1s3fc9xv4pfjd5r52g5x9q0cs4fl0j023dn2jv5fv34g9dmzgx8ziz4q787mpqzhva7vnc";
      };
    };
    "align-text-0.1.4" = {
      name = "align-text";
      packageName = "align-text";
      version = "0.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/align-text/-/align-text-0.1.4.tgz";
        sha1 = "0cd90a561093f35d0a99256c22b7069433fad117";
      };
    };
    "amdefine-1.0.1" = {
      name = "amdefine";
      packageName = "amdefine";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/amdefine/-/amdefine-1.0.1.tgz";
        sha1 = "4a5282ac164729e93619bcfd3ad151f817ce91f5";
      };
    };
    "angular-1.5.11" = {
      name = "angular";
      packageName = "angular";
      version = "1.5.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/angular/-/angular-1.5.11.tgz";
        sha1 = "8c5ba7386f15965c9acf3429f6881553aada30d6";
      };
    };
    "angular-route-1.5.11" = {
      name = "angular-route";
      packageName = "angular-route";
      version = "1.5.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/angular-route/-/angular-route-1.5.11.tgz";
        sha1 = "49614f3a167f54291e449fe8ba05d39c58924b83";
      };
    };
    "angular-ui-slider-0.4.0" = {
      name = "angular-ui-slider";
      packageName = "angular-ui-slider";
      version = "0.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/angular-ui-slider/-/angular-ui-slider-0.4.0.tgz";
        sha1 = "d76c0a54648d0d18d59c87e6c8338fae74135c75";
      };
    };
    "ansi-regex-2.1.1" = {
      name = "ansi-regex";
      packageName = "ansi-regex";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-2.1.1.tgz";
        sha1 = "c3b33ab5ee360d86e0e628f0468ae7ef27d654df";
      };
    };
    "ansi-styles-2.2.1" = {
      name = "ansi-styles";
      packageName = "ansi-styles";
      version = "2.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ansi-styles/-/ansi-styles-2.2.1.tgz";
        sha1 = "b432dd3358b634cf75e1e4664368240533c1ddbe";
      };
    };
    "autoprefixer-7.1.0" = {
      name = "autoprefixer";
      packageName = "autoprefixer";
      version = "7.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/autoprefixer/-/autoprefixer-7.1.0.tgz";
        sha1 = "ae4913adc221fa6ca5ad3a6f8039f6a5c06b3877";
      };
    };
    "autoprefixer-stylus-0.14.0" = {
      name = "autoprefixer-stylus";
      packageName = "autoprefixer-stylus";
      version = "0.14.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/autoprefixer-stylus/-/autoprefixer-stylus-0.14.0.tgz";
        sha1 = "1ce93bc4c1d8c8f29b3a564cfbba3242042efce0";
      };
    };
    "balanced-match-1.0.0" = {
      name = "balanced-match";
      packageName = "balanced-match";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.0.tgz";
        sha1 = "89b4d199ab2bee49de164ea02b89ce462d71b767";
      };
    };
    "big.js-3.2.0" = {
      name = "big.js";
      packageName = "big.js";
      version = "3.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/big.js/-/big.js-3.2.0.tgz";
        sha512 = "3qicqys1bg16slzbzjn3f0fir82r4d1h6lvy5y0cqqwzbs2iaxf93xgi6x47m7l87i102ifjn4qvjbf764gyncsxcqw7lw33mk7y4zs";
      };
    };
    "brace-expansion-1.1.11" = {
      name = "brace-expansion";
      packageName = "brace-expansion";
      version = "1.1.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.11.tgz";
        sha512 = "248cnpbbf0p32h53rd3g8wzpgrkaj4p078ra1g6l16f82i6bzkvmhwqan5rk88apbll9ly1476kngd7f7z27i3b3zxpbb3064f8yaw8";
      };
    };
    "browserslist-2.11.3" = {
      name = "browserslist";
      packageName = "browserslist";
      version = "2.11.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/browserslist/-/browserslist-2.11.3.tgz";
        sha512 = "2c52470l3xpcqvzj8qpkwpb73gx4mq30wsk08n90waahj8g8qwd8cjmvf625f4836p39jiigrd0g4xh9k4p7mhcaykgw0pvfiqvjsy9";
      };
    };
    "camelcase-1.2.1" = {
      name = "camelcase";
      packageName = "camelcase";
      version = "1.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/camelcase/-/camelcase-1.2.1.tgz";
        sha1 = "9bb5304d2e0b56698b2c758b08a3eaa9daa58a39";
      };
    };
    "caniuse-lite-1.0.30000820" = {
      name = "caniuse-lite";
      packageName = "caniuse-lite";
      version = "1.0.30000820";
      src = fetchurl {
        url = "https://registry.npmjs.org/caniuse-lite/-/caniuse-lite-1.0.30000820.tgz";
        sha512 = "1nnr7yva91fnlwccl62brrjs8xilkjr2k48anqq4v5h9wxfwkk6xxwqrg1r7w79fhzgn9zb90blxyvvkbc82ik9k76p9mgd75b6jiqk";
      };
    };
    "center-align-0.1.3" = {
      name = "center-align";
      packageName = "center-align";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/center-align/-/center-align-0.1.3.tgz";
        sha1 = "aa0d32629b6ee972200411cbd4461c907bc2b7ad";
      };
    };
    "chalk-1.1.3" = {
      name = "chalk";
      packageName = "chalk";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/chalk/-/chalk-1.1.3.tgz";
        sha1 = "a8115c55e4a702fe4d150abd3872822a7e09fc98";
      };
    };
    "cli-0.6.6" = {
      name = "cli";
      packageName = "cli";
      version = "0.6.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/cli/-/cli-0.6.6.tgz";
        sha1 = "02ad44a380abf27adac5e6f0cdd7b043d74c53e3";
      };
    };
    "cliui-2.1.0" = {
      name = "cliui";
      packageName = "cliui";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/cliui/-/cliui-2.1.0.tgz";
        sha1 = "4b475760ff80264c762c3a1719032e91c7fea0d1";
      };
    };
    "coffee-script-1.12.7" = {
      name = "coffee-script";
      packageName = "coffee-script";
      version = "1.12.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/coffee-script/-/coffee-script-1.12.7.tgz";
        sha512 = "29mq40padyvizg4f141b00p0p74hx9v06d7gxk84ggsiyw6rf5bb65gnfwk1i02r276jwqybmi5hx98s943slyazjnqd69jmj389dvw";
      };
    };
    "concat-map-0.0.1" = {
      name = "concat-map";
      packageName = "concat-map";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz";
        sha1 = "d8a96bd77fd68df7793a73036a3ba0d5405d477b";
      };
    };
    "console-browserify-1.1.0" = {
      name = "console-browserify";
      packageName = "console-browserify";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/console-browserify/-/console-browserify-1.1.0.tgz";
        sha1 = "f0241c45730a9fc6323b206dbf38edc741d0bb10";
      };
    };
    "core-util-is-1.0.2" = {
      name = "core-util-is";
      packageName = "core-util-is";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/core-util-is/-/core-util-is-1.0.2.tgz";
        sha1 = "b5fd54220aa2bc5ab57aab7140c940754503c1a7";
      };
    };
    "css-parse-1.7.0" = {
      name = "css-parse";
      packageName = "css-parse";
      version = "1.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/css-parse/-/css-parse-1.7.0.tgz";
        sha1 = "321f6cf73782a6ff751111390fc05e2c657d8c9b";
      };
    };
    "date-now-0.1.4" = {
      name = "date-now";
      packageName = "date-now";
      version = "0.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/date-now/-/date-now-0.1.4.tgz";
        sha1 = "eaf439fd4d4848ad74e5cc7dbef200672b9e345b";
      };
    };
    "debug-3.1.0" = {
      name = "debug";
      packageName = "debug";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/debug/-/debug-3.1.0.tgz";
        sha512 = "3g1hqsahr1ks2kpvdxrwzr57fj90nnr0hvwwrw8yyyzcv3i11sym8zwibxx67bl1mln0acddrzpkkdjjxnc6n2cm9fazmgzzsl1fzrr";
      };
    };
    "decamelize-1.2.0" = {
      name = "decamelize";
      packageName = "decamelize";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/decamelize/-/decamelize-1.2.0.tgz";
        sha1 = "f6534d15148269b20352e7bee26f501f9a191290";
      };
    };
    "dom-serializer-0.1.0" = {
      name = "dom-serializer";
      packageName = "dom-serializer";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/dom-serializer/-/dom-serializer-0.1.0.tgz";
        sha1 = "073c697546ce0780ce23be4a28e293e40bc30c82";
      };
    };
    "domelementtype-1.1.3" = {
      name = "domelementtype";
      packageName = "domelementtype";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/domelementtype/-/domelementtype-1.1.3.tgz";
        sha1 = "bd28773e2642881aec51544924299c5cd822185b";
      };
    };
    "domelementtype-1.3.0" = {
      name = "domelementtype";
      packageName = "domelementtype";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/domelementtype/-/domelementtype-1.3.0.tgz";
        sha1 = "b17aed82e8ab59e52dd9c19b1756e0fc187204c2";
      };
    };
    "domhandler-2.3.0" = {
      name = "domhandler";
      packageName = "domhandler";
      version = "2.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/domhandler/-/domhandler-2.3.0.tgz";
        sha1 = "2de59a0822d5027fabff6f032c2b25a2a8abe738";
      };
    };
    "domutils-1.5.1" = {
      name = "domutils";
      packageName = "domutils";
      version = "1.5.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/domutils/-/domutils-1.5.1.tgz";
        sha1 = "dcd8488a26f563d61079e48c9f7b7e32373682cf";
      };
    };
    "electron-to-chromium-1.3.40" = {
      name = "electron-to-chromium";
      packageName = "electron-to-chromium";
      version = "1.3.40";
      src = fetchurl {
        url = "https://registry.npmjs.org/electron-to-chromium/-/electron-to-chromium-1.3.40.tgz";
        sha1 = "1fbd6d97befd72b8a6f921dc38d22413d2f6fddf";
      };
    };
    "emojis-list-2.1.0" = {
      name = "emojis-list";
      packageName = "emojis-list";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/emojis-list/-/emojis-list-2.1.0.tgz";
        sha1 = "4daa4d9db00f9819880c79fa457ae5b09a1fd389";
      };
    };
    "entities-1.0.0" = {
      name = "entities";
      packageName = "entities";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/entities/-/entities-1.0.0.tgz";
        sha1 = "b2987aa3821347fcde642b24fdfc9e4fb712bf26";
      };
    };
    "entities-1.1.1" = {
      name = "entities";
      packageName = "entities";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/entities/-/entities-1.1.1.tgz";
        sha1 = "6e5c2d0a5621b5dadaecef80b90edfb5cd7772f0";
      };
    };
    "escape-string-regexp-1.0.5" = {
      name = "escape-string-regexp";
      packageName = "escape-string-regexp";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/escape-string-regexp/-/escape-string-regexp-1.0.5.tgz";
        sha1 = "1b61c0562190a8dff6ae3bb2cf0200ca130b86d4";
      };
    };
    "exit-0.1.2" = {
      name = "exit";
      packageName = "exit";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/exit/-/exit-0.1.2.tgz";
        sha1 = "0632638f8d877cc82107d30a0fff1a17cba1cd0c";
      };
    };
    "fs.realpath-1.0.0" = {
      name = "fs.realpath";
      packageName = "fs.realpath";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz";
        sha1 = "1504ad2523158caa40db4a2787cb01411994ea4f";
      };
    };
    "glob-3.2.11" = {
      name = "glob";
      packageName = "glob";
      version = "3.2.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob/-/glob-3.2.11.tgz";
        sha1 = "4a973f635b9190f715d10987d5c00fd2815ebe3d";
      };
    };
    "glob-7.0.6" = {
      name = "glob";
      packageName = "glob";
      version = "7.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob/-/glob-7.0.6.tgz";
        sha1 = "211bafaf49e525b8cd93260d14ab136152b3f57a";
      };
    };
    "has-ansi-2.0.0" = {
      name = "has-ansi";
      packageName = "has-ansi";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-ansi/-/has-ansi-2.0.0.tgz";
        sha1 = "34f5049ce1ecdf2b0649af3ef24e45ed35416d91";
      };
    };
    "has-flag-1.0.0" = {
      name = "has-flag";
      packageName = "has-flag";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-flag/-/has-flag-1.0.0.tgz";
        sha1 = "9d9e793165ce017a00f00418c43f942a7b1d11fa";
      };
    };
    "htmlparser2-3.8.3" = {
      name = "htmlparser2";
      packageName = "htmlparser2";
      version = "3.8.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/htmlparser2/-/htmlparser2-3.8.3.tgz";
        sha1 = "996c28b191516a8be86501a7d79757e5c70c1068";
      };
    };
    "inflight-1.0.6" = {
      name = "inflight";
      packageName = "inflight";
      version = "1.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/inflight/-/inflight-1.0.6.tgz";
        sha1 = "49bd6331d7d02d0c09bc910a1075ba8165b56df9";
      };
    };
    "inherits-2.0.3" = {
      name = "inherits";
      packageName = "inherits";
      version = "2.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/inherits/-/inherits-2.0.3.tgz";
        sha1 = "633c2c83e3da42a502f52466022480f4208261de";
      };
    };
    "is-buffer-1.1.6" = {
      name = "is-buffer";
      packageName = "is-buffer";
      version = "1.1.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-buffer/-/is-buffer-1.1.6.tgz";
        sha512 = "3kr8dm9qyklmm2xyiz75s8db90bfilfals4x0g276kncihrrrz0ar4y6dqpvc7pwy7h43jay1bayi1r62x97nzvcswkk4ap18pl1irm";
      };
    };
    "isarray-0.0.1" = {
      name = "isarray";
      packageName = "isarray";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/isarray/-/isarray-0.0.1.tgz";
        sha1 = "8a18acfca9a8f4177e09abfc6038939b05d1eedf";
      };
    };
    "jquery-1.12.4" = {
      name = "jquery";
      packageName = "jquery";
      version = "1.12.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/jquery/-/jquery-1.12.4.tgz";
        sha1 = "01e1dfba290fe73deba77ceeacb0f9ba2fec9e0c";
      };
    };
    "jquery-ui-dist-1.12.1" = {
      name = "jquery-ui-dist";
      packageName = "jquery-ui-dist";
      version = "1.12.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/jquery-ui-dist/-/jquery-ui-dist-1.12.1.tgz";
        sha1 = "5c0815d3cc6f90ff5faaf5b268a6e23b4ca904fa";
      };
    };
    "jshint-2.8.0" = {
      name = "jshint";
      packageName = "jshint";
      version = "2.8.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/jshint/-/jshint-2.8.0.tgz";
        sha1 = "1d09a3bd913c4cadfa81bf18d582bd85bffe0d44";
      };
    };
    "json5-0.5.1" = {
      name = "json5";
      packageName = "json5";
      version = "0.5.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/json5/-/json5-0.5.1.tgz";
        sha1 = "1eade7acc012034ad84e2396767ead9fa5495821";
      };
    };
    "kind-of-3.2.2" = {
      name = "kind-of";
      packageName = "kind-of";
      version = "3.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/kind-of/-/kind-of-3.2.2.tgz";
        sha1 = "31ea21a734bab9bbb0f32466d893aea51e4a3c64";
      };
    };
    "lazy-cache-1.0.4" = {
      name = "lazy-cache";
      packageName = "lazy-cache";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/lazy-cache/-/lazy-cache-1.0.4.tgz";
        sha1 = "a1d78fc3a50474cb80845d3b3b6e1da49a446e8e";
      };
    };
    "loader-utils-1.1.0" = {
      name = "loader-utils";
      packageName = "loader-utils";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/loader-utils/-/loader-utils-1.1.0.tgz";
        sha1 = "c98aef488bcceda2ffb5e2de646d6a754429f5cd";
      };
    };
    "lodash-3.10.1" = {
      name = "lodash";
      packageName = "lodash";
      version = "3.10.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash/-/lodash-3.10.1.tgz";
        sha1 = "5bf45e8e49ba4189e17d482789dfd15bd140b7b6";
      };
    };
    "lodash-3.7.0" = {
      name = "lodash";
      packageName = "lodash";
      version = "3.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash/-/lodash-3.7.0.tgz";
        sha1 = "3678bd8ab995057c07ade836ed2ef087da811d45";
      };
    };
    "lodash.clonedeep-4.5.0" = {
      name = "lodash.clonedeep";
      packageName = "lodash.clonedeep";
      version = "4.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.clonedeep/-/lodash.clonedeep-4.5.0.tgz";
        sha1 = "e23f3f9c4f8fbdde872529c1071857a086e5ccef";
      };
    };
    "longest-1.0.1" = {
      name = "longest";
      packageName = "longest";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/longest/-/longest-1.0.1.tgz";
        sha1 = "30a0b2da38f73770e8294a0d22e6625ed77d0097";
      };
    };
    "lru-cache-2.7.3" = {
      name = "lru-cache";
      packageName = "lru-cache";
      version = "2.7.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/lru-cache/-/lru-cache-2.7.3.tgz";
        sha1 = "6d4524e8b955f95d4f5b58851ce21dd72fb4e952";
      };
    };
    "minimatch-0.3.0" = {
      name = "minimatch";
      packageName = "minimatch";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimatch/-/minimatch-0.3.0.tgz";
        sha1 = "275d8edaac4f1bb3326472089e7949c8394699dd";
      };
    };
    "minimatch-2.0.10" = {
      name = "minimatch";
      packageName = "minimatch";
      version = "2.0.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimatch/-/minimatch-2.0.10.tgz";
        sha1 = "8d087c39c6b38c001b97fca7ce6d0e1e80afbac7";
      };
    };
    "minimatch-3.0.4" = {
      name = "minimatch";
      packageName = "minimatch";
      version = "3.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimatch/-/minimatch-3.0.4.tgz";
        sha512 = "1879a3j85h92ypvb7lpv1dqpcxl49rqnbgs5la18zmj1yqhwl60c2m74254wbr5pp3znckqpkg9dvjyrz6hfz8b9vag5a3j910db4f8";
      };
    };
    "minimist-0.0.8" = {
      name = "minimist";
      packageName = "minimist";
      version = "0.0.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimist/-/minimist-0.0.8.tgz";
        sha1 = "857fcabfc3397d2625b8228262e86aa7a011b05d";
      };
    };
    "mkdirp-0.5.1" = {
      name = "mkdirp";
      packageName = "mkdirp";
      version = "0.5.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/mkdirp/-/mkdirp-0.5.1.tgz";
        sha1 = "30057438eac6cf7f8c4767f38648d6697d75c903";
      };
    };
    "ms-2.0.0" = {
      name = "ms";
      packageName = "ms";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ms/-/ms-2.0.0.tgz";
        sha1 = "5608aeadfc00be6c2901df5f9861788de0d597c8";
      };
    };
    "multi-stage-sourcemap-0.2.1" = {
      name = "multi-stage-sourcemap";
      packageName = "multi-stage-sourcemap";
      version = "0.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/multi-stage-sourcemap/-/multi-stage-sourcemap-0.2.1.tgz";
        sha1 = "b09fc8586eaa17f81d575c4ad02e0f7a3f6b1105";
      };
    };
    "nib-1.1.2" = {
      name = "nib";
      packageName = "nib";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/nib/-/nib-1.1.2.tgz";
        sha1 = "6a69ede4081b95c0def8be024a4c8ae0c2cbb6c7";
      };
    };
    "normalize-range-0.1.2" = {
      name = "normalize-range";
      packageName = "normalize-range";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/normalize-range/-/normalize-range-0.1.2.tgz";
        sha1 = "2d10c06bdfd312ea9777695a4d28439456b75942";
      };
    };
    "normalize.styl-3.0.3" = {
      name = "normalize.styl";
      packageName = "normalize.styl";
      version = "3.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/normalize.styl/-/normalize.styl-3.0.3.tgz";
        sha1 = "1a2fbc02b37e6980572e469464005260d6aa53e4";
      };
    };
    "num2fraction-1.2.2" = {
      name = "num2fraction";
      packageName = "num2fraction";
      version = "1.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/num2fraction/-/num2fraction-1.2.2.tgz";
        sha1 = "6f682b6a027a4e9ddfa4564cd2589d1d4e669ede";
      };
    };
    "once-1.4.0" = {
      name = "once";
      packageName = "once";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/once/-/once-1.4.0.tgz";
        sha1 = "583b1aa775961d4b113ac17d9c50baef9dd76bd1";
      };
    };
    "path-is-absolute-1.0.1" = {
      name = "path-is-absolute";
      packageName = "path-is-absolute";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-is-absolute/-/path-is-absolute-1.0.1.tgz";
        sha1 = "174b9268735534ffbc7ace6bf53a5a9e1b5c5f5f";
      };
    };
    "pivottable-2.20.0" = {
      name = "pivottable";
      packageName = "pivottable";
      version = "2.20.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pivottable/-/pivottable-2.20.0.tgz";
        sha1 = "f04f85fc6e12b62a1be2e3cb7e086eb3c9bcad73";
      };
    };
    "postcss-6.0.1" = {
      name = "postcss";
      packageName = "postcss";
      version = "6.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss/-/postcss-6.0.1.tgz";
        sha1 = "000dbd1f8eef217aa368b9a212c5fc40b2a8f3f2";
      };
    };
    "postcss-value-parser-3.3.0" = {
      name = "postcss-value-parser";
      packageName = "postcss-value-parser";
      version = "3.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-value-parser/-/postcss-value-parser-3.3.0.tgz";
        sha1 = "87f38f9f18f774a4ab4c8a232f5c5ce8872a9d15";
      };
    };
    "readable-stream-1.1.14" = {
      name = "readable-stream";
      packageName = "readable-stream";
      version = "1.1.14";
      src = fetchurl {
        url = "https://registry.npmjs.org/readable-stream/-/readable-stream-1.1.14.tgz";
        sha1 = "7cf4c54ef648e3813084c636dd2079e166c081d9";
      };
    };
    "repeat-string-1.6.1" = {
      name = "repeat-string";
      packageName = "repeat-string";
      version = "1.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/repeat-string/-/repeat-string-1.6.1.tgz";
        sha1 = "8dcae470e1c88abc2d600fff4a776286da75e637";
      };
    };
    "right-align-0.1.3" = {
      name = "right-align";
      packageName = "right-align";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/right-align/-/right-align-0.1.3.tgz";
        sha1 = "61339b722fe6a3515689210d24e14c96148613ef";
      };
    };
    "sax-0.5.8" = {
      name = "sax";
      packageName = "sax";
      version = "0.5.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/sax/-/sax-0.5.8.tgz";
        sha1 = "d472db228eb331c2506b0e8c15524adb939d12c1";
      };
    };
    "shelljs-0.3.0" = {
      name = "shelljs";
      packageName = "shelljs";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/shelljs/-/shelljs-0.3.0.tgz";
        sha1 = "3596e6307a781544f591f37da618360f31db57b1";
      };
    };
    "sigmund-1.0.1" = {
      name = "sigmund";
      packageName = "sigmund";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/sigmund/-/sigmund-1.0.1.tgz";
        sha1 = "3ff21f198cad2175f9f3b781853fd94d0d19b590";
      };
    };
    "source-map-0.1.43" = {
      name = "source-map";
      packageName = "source-map";
      version = "0.1.43";
      src = fetchurl {
        url = "https://registry.npmjs.org/source-map/-/source-map-0.1.43.tgz";
        sha1 = "c24bc146ca517c1471f5dacbe2571b2b7f9e3346";
      };
    };
    "source-map-0.5.7" = {
      name = "source-map";
      packageName = "source-map";
      version = "0.5.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/source-map/-/source-map-0.5.7.tgz";
        sha1 = "8a039d2d1021d22d1ea14c80d8ea468ba2ef3fcc";
      };
    };
    "string_decoder-0.10.31" = {
      name = "string_decoder";
      packageName = "string_decoder";
      version = "0.10.31";
      src = fetchurl {
        url = "https://registry.npmjs.org/string_decoder/-/string_decoder-0.10.31.tgz";
        sha1 = "62e203bc41766c6c28c9fc84301dab1c5310fa94";
      };
    };
    "strip-ansi-3.0.1" = {
      name = "strip-ansi";
      packageName = "strip-ansi";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-3.0.1.tgz";
        sha1 = "6a385fb8853d952d5ff05d0e8aaf94278dc63dcf";
      };
    };
    "strip-json-comments-1.0.4" = {
      name = "strip-json-comments";
      packageName = "strip-json-comments";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/strip-json-comments/-/strip-json-comments-1.0.4.tgz";
        sha1 = "1e15fbcac97d3ee99bf2d73b4c656b082bbafb91";
      };
    };
    "stylus-0.54.5" = {
      name = "stylus";
      packageName = "stylus";
      version = "0.54.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/stylus/-/stylus-0.54.5.tgz";
        sha1 = "42b9560931ca7090ce8515a798ba9e6aa3d6dc79";
      };
    };
    "stylus-loader-3.0.2" = {
      name = "stylus-loader";
      packageName = "stylus-loader";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/stylus-loader/-/stylus-loader-3.0.2.tgz";
        sha512 = "18d4pn9iy3x6hkfkhy2lc5dj524cga321gylryisxc7i1g4inb37q96cig5079bg5izjd9nkj19jp7bmdw8mczzrkd4lsvssqyjcnpr";
      };
    };
    "supports-color-2.0.0" = {
      name = "supports-color";
      packageName = "supports-color";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/supports-color/-/supports-color-2.0.0.tgz";
        sha1 = "535d045ce6b6363fa40117084629995e9df324c7";
      };
    };
    "supports-color-3.2.3" = {
      name = "supports-color";
      packageName = "supports-color";
      version = "3.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/supports-color/-/supports-color-3.2.3.tgz";
        sha1 = "65ac0504b3954171d8a64946b2ae3cbb8a5f54f6";
      };
    };
    "uglify-js-2.8.29" = {
      name = "uglify-js";
      packageName = "uglify-js";
      version = "2.8.29";
      src = fetchurl {
        url = "https://registry.npmjs.org/uglify-js/-/uglify-js-2.8.29.tgz";
        sha1 = "29c5733148057bb4e1f75df35b7a9cb72e6a59dd";
      };
    };
    "uglify-to-browserify-1.0.2" = {
      name = "uglify-to-browserify";
      packageName = "uglify-to-browserify";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/uglify-to-browserify/-/uglify-to-browserify-1.0.2.tgz";
        sha1 = "6e0924d6bda6b5afe349e39a6d632850a0f882b7";
      };
    };
    "when-3.6.4" = {
      name = "when";
      packageName = "when";
      version = "3.6.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/when/-/when-3.6.4.tgz";
        sha1 = "473b517ec159e2b85005497a13983f095412e34e";
      };
    };
    "window-size-0.1.0" = {
      name = "window-size";
      packageName = "window-size";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/window-size/-/window-size-0.1.0.tgz";
        sha1 = "5438cd2ea93b202efa3a19fe8887aee7c94f9c9d";
      };
    };
    "wordwrap-0.0.2" = {
      name = "wordwrap";
      packageName = "wordwrap";
      version = "0.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/wordwrap/-/wordwrap-0.0.2.tgz";
        sha1 = "b79669bb42ecb409f83d583cad52ca17eaa1643f";
      };
    };
    "wrappy-1.0.2" = {
      name = "wrappy";
      packageName = "wrappy";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz";
        sha1 = "b5243d8f3ec1aa35f1364605bc0d1036e30ab69f";
      };
    };
    "yargs-3.10.0" = {
      name = "yargs";
      packageName = "yargs";
      version = "3.10.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/yargs/-/yargs-3.10.0.tgz";
        sha1 = "f7ee7bd857dd7c1d2d38c0e74efbd681d1431fd1";
      };
    };
  };
  args = {
    name = "databrary";
    packageName = "databrary";
    version = "0.0.0";
    src = ./.;
    dependencies = [
      sources."@flowjs/ng-flow-2.7.8"
      sources."angular-1.5.11"
      sources."angular-route-1.5.11"
      sources."angular-ui-slider-0.4.0"
      (sources."autoprefixer-stylus-0.14.0" // {
        dependencies = [
          (sources."autoprefixer-7.1.0" // {
            dependencies = [
              (sources."browserslist-2.11.3" // {
                dependencies = [
                  sources."electron-to-chromium-1.3.40"
                ];
              })
              sources."caniuse-lite-1.0.30000820"
              sources."normalize-range-0.1.2"
              sources."num2fraction-1.2.2"
              sources."postcss-value-parser-3.3.0"
            ];
          })
          (sources."multi-stage-sourcemap-0.2.1" // {
            dependencies = [
              (sources."source-map-0.1.43" // {
                dependencies = [
                  sources."amdefine-1.0.1"
                ];
              })
            ];
          })
          (sources."postcss-6.0.1" // {
            dependencies = [
              (sources."chalk-1.1.3" // {
                dependencies = [
                  sources."ansi-styles-2.2.1"
                  sources."escape-string-regexp-1.0.5"
                  (sources."has-ansi-2.0.0" // {
                    dependencies = [
                      sources."ansi-regex-2.1.1"
                    ];
                  })
                  (sources."strip-ansi-3.0.1" // {
                    dependencies = [
                      sources."ansi-regex-2.1.1"
                    ];
                  })
                  sources."supports-color-2.0.0"
                ];
              })
              sources."source-map-0.5.7"
              (sources."supports-color-3.2.3" // {
                dependencies = [
                  sources."has-flag-1.0.0"
                ];
              })
            ];
          })
        ];
      })
      sources."coffee-script-1.12.7"
      sources."jquery-1.12.4"
      sources."jquery-ui-dist-1.12.1"
      (sources."jshint-2.8.0" // {
        dependencies = [
          (sources."cli-0.6.6" // {
            dependencies = [
              (sources."glob-3.2.11" // {
                dependencies = [
                  sources."inherits-2.0.3"
                  (sources."minimatch-0.3.0" // {
                    dependencies = [
                      sources."lru-cache-2.7.3"
                      sources."sigmund-1.0.1"
                    ];
                  })
                ];
              })
            ];
          })
          (sources."console-browserify-1.1.0" // {
            dependencies = [
              sources."date-now-0.1.4"
            ];
          })
          sources."exit-0.1.2"
          (sources."htmlparser2-3.8.3" // {
            dependencies = [
              sources."domelementtype-1.3.0"
              sources."domhandler-2.3.0"
              (sources."domutils-1.5.1" // {
                dependencies = [
                  (sources."dom-serializer-0.1.0" // {
                    dependencies = [
                      sources."domelementtype-1.1.3"
                      sources."entities-1.1.1"
                    ];
                  })
                ];
              })
              sources."entities-1.0.0"
              (sources."readable-stream-1.1.14" // {
                dependencies = [
                  sources."core-util-is-1.0.2"
                  sources."inherits-2.0.3"
                  sources."isarray-0.0.1"
                  sources."string_decoder-0.10.31"
                ];
              })
            ];
          })
          sources."lodash-3.7.0"
          (sources."minimatch-2.0.10" // {
            dependencies = [
              (sources."brace-expansion-1.1.11" // {
                dependencies = [
                  sources."balanced-match-1.0.0"
                  sources."concat-map-0.0.1"
                ];
              })
            ];
          })
          sources."shelljs-0.3.0"
          sources."strip-json-comments-1.0.4"
        ];
      })
      sources."lodash-3.10.1"
      sources."nib-1.1.2"
      sources."normalize.styl-3.0.3"
      sources."pivottable-2.20.0"
      (sources."stylus-0.54.5" // {
        dependencies = [
          sources."css-parse-1.7.0"
          (sources."debug-3.1.0" // {
            dependencies = [
              sources."ms-2.0.0"
            ];
          })
          (sources."glob-7.0.6" // {
            dependencies = [
              sources."fs.realpath-1.0.0"
              (sources."inflight-1.0.6" // {
                dependencies = [
                  sources."wrappy-1.0.2"
                ];
              })
              sources."inherits-2.0.3"
              (sources."minimatch-3.0.4" // {
                dependencies = [
                  (sources."brace-expansion-1.1.11" // {
                    dependencies = [
                      sources."balanced-match-1.0.0"
                      sources."concat-map-0.0.1"
                    ];
                  })
                ];
              })
              (sources."once-1.4.0" // {
                dependencies = [
                  sources."wrappy-1.0.2"
                ];
              })
              sources."path-is-absolute-1.0.1"
            ];
          })
          (sources."mkdirp-0.5.1" // {
            dependencies = [
              sources."minimist-0.0.8"
            ];
          })
          sources."sax-0.5.8"
          (sources."source-map-0.1.43" // {
            dependencies = [
              sources."amdefine-1.0.1"
            ];
          })
        ];
      })
      (sources."stylus-loader-3.0.2" // {
        dependencies = [
          (sources."loader-utils-1.1.0" // {
            dependencies = [
              sources."big.js-3.2.0"
              sources."emojis-list-2.1.0"
              sources."json5-0.5.1"
            ];
          })
          sources."lodash.clonedeep-4.5.0"
          sources."when-3.6.4"
        ];
      })
      (sources."uglify-js-2.8.29" // {
        dependencies = [
          sources."source-map-0.5.7"
          sources."uglify-to-browserify-1.0.2"
          (sources."yargs-3.10.0" // {
            dependencies = [
              sources."camelcase-1.2.1"
              (sources."cliui-2.1.0" // {
                dependencies = [
                  (sources."center-align-0.1.3" // {
                    dependencies = [
                      (sources."align-text-0.1.4" // {
                        dependencies = [
                          (sources."kind-of-3.2.2" // {
                            dependencies = [
                              sources."is-buffer-1.1.6"
                            ];
                          })
                          sources."longest-1.0.1"
                          sources."repeat-string-1.6.1"
                        ];
                      })
                      sources."lazy-cache-1.0.4"
                    ];
                  })
                  (sources."right-align-0.1.3" // {
                    dependencies = [
                      (sources."align-text-0.1.4" // {
                        dependencies = [
                          (sources."kind-of-3.2.2" // {
                            dependencies = [
                              sources."is-buffer-1.1.6"
                            ];
                          })
                          sources."longest-1.0.1"
                          sources."repeat-string-1.6.1"
                        ];
                      })
                    ];
                  })
                  sources."wordwrap-0.0.2"
                ];
              })
              sources."decamelize-1.2.0"
              sources."window-size-0.1.0"
            ];
          })
        ];
      })
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Databrary web build-time dependencies";
    };
    production = true;
    bypassCache = false;
  };
in
{
  tarball = nodeEnv.buildNodeSourceDist args;
  package = nodeEnv.buildNodePackage args;
  shell = nodeEnv.buildNodeShell args;
}
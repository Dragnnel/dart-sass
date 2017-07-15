// Copyright 2016 Google Inc. Use of this source code is governed by an
// MIT-style license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'src/compile.dart' as c;
import 'src/exception.dart';
import 'src/sync_package_resolver.dart';

/// Loads the Sass file at [path], compiles it to CSS, and returns the result.
///
/// If [color] is `true`, this will use terminal colors in warnings. If [quiet]
/// is `true`, this won't print warnings.
///
/// If [loadPaths] are provided, they're used when searching for Sass files to
/// load with `@import`. They're tried in order, after looking for a relative
/// path.
///
/// If [packageResolver] is provided, it's used to resolve `package:` imports.
/// Otherwise, they aren't supported. It takes a [SyncPackageResolver][] from
/// the `package_resolver` package.
///
/// [SyncPackageResolver]: https://www.dartdocs.org/documentation/package_resolver/latest/package_resolver/SyncPackageResolver-class.html
///
/// Throws a [SassException] if conversion fails.
String compile(String path,
    {bool color: false,
    bool quiet: false,
    Iterable<String> loadPaths,
    SyncPackageResolver packageResolver}) {
  var result = c.compile(path,
      logger: new Logger(color: color, quiet: quiet), loadPaths: loadPaths, packageResolver: packageResolver);
  return result.css;
}

/// Compiles [source] to CSS and returns the result.
///
/// If [indented] is `true`, this parses [source] using indented syntax;
/// otherwise (and by default) it uses SCSS. If [color] is `true`, this will use
/// terminal colors in warnings. If [quiet] is `true`, this won't print
/// warnings.
///
/// If [loadPaths] are provided, they're used when searching for Sass files to
/// load with `@import`. They're tried in order, after looking for a relative
/// path.
///
/// If [packageResolver] is provided, it's used to resolve `package:` imports.
/// Otherwise, they aren't supported. It takes a [SyncPackageResolver][] from
/// the `package_resolver` package.
///
/// [SyncPackageResolver]: https://www.dartdocs.org/documentation/package_resolver/latest/package_resolver/SyncPackageResolver-class.html
///
/// The [url] indicates the location from which [source] was loaded. It may may
/// be a [String] or a [Uri].
///
/// Throws a [SassException] if conversion fails.
String compileString(String source,
    {bool indented: false,
    bool color: false,
      bool quiet: false,
    Iterable<String> loadPaths,
    SyncPackageResolver packageResolver,
    url}) {
  var result = c.compileString(source,
      indented: indented,
      logger: new Logger(color: color,
      quiet: quiet),
      loadPaths: loadPaths,
      packageResolver: packageResolver,
      url: url);
  return result.css;
}

/// Use [compile] instead.
@Deprecated('Will be removed in 1.0.0')
String render(String path,
        {bool color: false, SyncPackageResolver packageResolver}) =>
    compile(path, color: color, packageResolver: packageResolver);

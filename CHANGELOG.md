# Changelog

## [v0.24.1] 2022-05-26

- Added a better `#message` to `SoberSwag::Reporting::Report::Error`

## [v0.22.0] 2021-12-21

- Added `SoberSwag::Reporting`, which is basically a v2 of the gem!
  Docs for this can be found in [docs/reporting.md].

## [v0.21.0] 2021-09-02

- Added a new method of serializing views based on hash lookups, improving performance
- Added a benchmarking suite
- Added `except` parameter to the `merge` method, which allows a specified field to be excluded from the merge.
- Add `type_key` to output objects, for easily serializing out type fields with a constant string.
- Added `type_attribute` to `SoberSwag::InputObject` to add easy constant-value disambiguation.

## [v0.20.0] 2021-05-17

- Added YARD documentation to almost every method


## [v0.19.0] 2021-03-10

- Use [redoc](https://github.com/Redocly/redoc) for generated documentation UI

## [v0.18.0] 2021-03-02

- Add generic hash type for primitive types

## [v0.17.0]: 2020-11-30

- Allow tagging endpoints via the new `tags` method.

## [v0.16.0]: 2020-10-23

- Allow non-class types to be used as the inputs to controllers

## [v0.15.0]: 2020-09-02

### Added
- Add a new `#merge` method to output objects, which will merge fields from another output object into the given output object.
- Add `multi` to Output Objects, as a way to define more than one field of the same type at once.
- Add an `inherits:` key to output objects, for view inheritance.
- Add `SoberSwag::Types::CommaArray`, which parses comma-separated strings into arrays.
  This also sets `style` to `form` and `explode` to `false` when generating Swagger docs.
  This class is mostly useful for query parameters where you want a simpler format: `tag=foo,bar` instead of `tag[]=foo,tag[]=bar`.
- Add support for using `meta` to specify alternative `style` and `explode` keys for query and path params.
  Note that this support *does not* extend to parsing: If you modify the `style` or `explode` keywords, you will need to make those input formats work with the actual type yourself.

### Fixed
- No longer swallow `Dry::Struct` errors, instead let them surface to the user.

[v0.15.0]: https://github.com/SonderMindOrg/sober_swag/releases/tag/v0.15.0

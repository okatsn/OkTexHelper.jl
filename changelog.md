# Changelog

## v0.1.0
  * Initiating the project.


## v0.2.1
New features
- Reading a `.tex` file, `cleanblock` for remove begin-end blocks in the document; returns `lines`.
- Reading a `.tex` file, `cleancomment` for remove comments in the document; returns `lines`.
- `writelines` for save processed `lines`.

## v0.3.0
New `struct` `CleanComment`
- `CleanComments` with a new method of `writelines` to deal with empty lines better.
- The new approach delete empty lines after comments are cleaned, but those were originally line breaks will be kept.

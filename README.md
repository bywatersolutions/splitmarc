# splitmarc

`splitmarc.sh` is used to split a marcxml file with numerous 952 tags (i.e. items) into multiple 
MARC21 files containing 50 items per file. These will be written to /tmp, with a file name based on the origional
marcxml file.

Usage:

    splitmarc.sh FILE

`FILE` is a marcxml file, and must have the extension `.marcxml`.

## Dependencies

* `yaz-marcdump`
* `xpath`

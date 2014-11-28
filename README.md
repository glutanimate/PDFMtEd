# PDFMtEd

<p align="center">
  <img src="https://github.com/Glutanimate/PDFMtEd/blob/master/desktop/pdfmted.png" alt="PDFMtEd logo"/>
</p>

**PDFMtEd** (**PDF** <b>M</b>e<b>t</b>adata <b>Ed</b>itor) is a set of tools designed to simplify working with PDF metadata on Linux. The utilities hosted in this repository are graphical front-ends to the marvelous [ExifTool](http://www.sno.phy.queensu.ca/~phil/exiftool/) by Phil Harvey.

## Table of contents

<!-- MarkdownTOC -->

- [Components](#components)
    - [PDFMtEd Editor](#pdfmted-editor)
    - [PDFMtEd Inspector](#pdfmted-inspector)
    - [PDFMtEd Thumbnailer](#pdfmted-thumbnailer)
- [Installation and dependencies](#installation-and-dependencies)
    - [Dependencies](#dependencies)
        - [Overview of all dependencies](#overview-of-all-dependencies)
        - [Dependency breakdown](#dependency-breakdown)
    - [Installation](#installation)
    - [Uninstall PDFMtEd](#uninstall-pdfmted)
- [Usage](#usage)
    - [General usage](#general-usage)
    - [PDFMtEd Editor](#pdfmted-editor-1)
        - [User interface](#user-interface)
        - [Command-line options](#command-line-options)
    - [PDFMtEd Inspector](#pdfmted-inspector-1)
    - [PDFMtEd Thumbnailer](#pdfmted-thumbnailer-1)
- [Additional information](#additional-information)
    - [Modified metadata tags](#modified-metadata-tags)
    - [Purging metadata](#purging-metadata)
- [Known issues](#known-issues)
- [License](#license)

<!-- /MarkdownTOC -->

## Components

### PDFMtEd Editor

**Overview**

PDFMtEd Editor is an easy-to-use graphical metadata editor that supports viewing and modifying all major metadata fields found in PDF documents.

**Screenshot**

![screenshot of PDFMtEd Editor](https://github.com/Glutanimate/PDFMtEd/blob/master/screenshots/pdfmted-editor.png)

**Features:**

- easily process multiple files and folders right from your file manager
- preview your documents in your default PDF viewer and file manager before editing them
- rename files based on metadata

### PDFMtEd Inspector

**Overview**

PDFMtEd Inspector is a general purpose metadata viewer and cleaner. Aside from granting a quick and easy insight into the meta information stored in your files, it also allows you to quickly and effectively purge all metadata.

While it can handle all file formats supported by exiftool, PDFMtEd Inspector was primarily designed with PDF files in mind.

**Screenshot**

![screenshot of PDFMtEd Inspector](https://github.com/Glutanimate/PDFMtEd/blob/master/screenshots/pdfmted-inspector.png)

**Features:**

- quickly inspect metadata right from your file manager
- easily purge single or multiple files of all metadata

### PDFMtEd Thumbnailer

**Overview**

PDFMtEd Thumbnailer provides the thumbnail previews for the utilities hosted in this repository. It also acts as a general purpose thumbnailing script that can recursively generate thumbnails for one or more directories. 

PDFMtEd Thumbnailer should be able to generate thumbnails for all file types supported by Nautilus/GNOME's thumbnailing back-end.

**Note:** `pdfmted-thumbnailer` was written by [James Henstridge](https://launchpad.net/~jamesh) as part of an [AskUbuntu Q&A](http://askubuntu.com/a/201997).

## Installation and dependencies

The following instructions are provided for Ubuntu. Package names and repositories might differ on other distributions.

### Dependencies

#### Overview of all dependencies

Install all dependencies on Ubuntu with the following commands:

    sudo add-apt-repository ppa:webupd8team/y-ppa-manager
    sudo apt-get update
    sudo apt-get install yad libimage-exiftool-perl qpdf

*Optional but recommended*: [sejda-console](https://github.com/torakiki/sejda/releases)

#### Dependency breakdown

**Required:**

- [YAD](http://sourceforge.net/projects/yad-dialog/): graphical front-end for bash scripts, a Zenity fork; provided by Webupd8 PPA
- [ExifTool](http://www.sno.phy.queensu.ca/~phil/exiftool/): general purpose metadata editing application and library
- [qpdf](http://qpdf.sourceforge.net/): command-line program that does structural, content-preserving transformations on PDF files; used in this project to restore broken PDF files and purge documents of residual metadata
- Python 2.7 is required for the thumbnailer and thumbnail preview to work. This should be installed on your system by default.

**Recommended:**

- [Sejda](http://www.sejda.org/): extensible and configurable PDF manipulation layer library; used to restore broken PDF files; more reliable than qpdf in this, but unfortunately not available in any repository; please use the [debfile release](ttps://github.com/torakiki/sejda/releases) to install `sejda-console`

### Installation

1. Install all dependencies

2. Clone this repository or download the latest zipfile and extract it

3. `cd` to the cloned/extracted directory, e.g.:

        cd PDFMtEd

4. Run the provided installer:

        sudo ./install.sh

    (If your file manager supports custom scripts you can just copy the `PDFMtEd` folder to the default scripts path instead ([instructions for Nautilus](http://askubuntu.com/a/236415)))

After the installation PDFMtEd Editor and Inspector should be available as entries in the *Open with* context menu:

![file manager context menu with PDFMtEd entries](https://github.com/Glutanimate/PDFMtEd/blob/master/screenshots/pdfmted_usage.png)

If you can't find the entries click on *Other application* (arrow) and navigate to *Show other applications*. You should be able to find the PDFMtEd launchers in the list. Double-click on *PDFMtEd – Inspector* to open the application. This will automatically add a context menu entry. Repeat the procedure for *PDFMtEd – Editor* and you are set.

### Uninstall PDFMtEd

Follow these steps to uninstall the PDFMted utilities:

1. `cd` to the project directory, e.g.:

        cd PDFMtEd

2. Run `uninstall.sh` as root:

        sudo ./uninstall.sh

## Usage

### General usage

1. Use your file manager to select one or more files/directories
2. Choose the utility you want to launch from the *Open with* context menu

### PDFMtEd Editor

**Important note:** All changes introduced by ExifTool, and in turn PDFMtEd Editor, are [potentially reversible](http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/PDF.html), which might be a security issue under some circumstances. 

PDFMtEd Inspector (not the Editor!) works around this by using `qpdf` to purge PDF files of all existing metadata (further reading: [Purging metadata](#purging-metadata)).

#### User interface

Here are some helpful pointers:

- you can use the next/previous buttons to navigate between files

- you can transfer metadata to the next file by selecting *Copy tags over to next/previous file* option

- renamed files follow this naming scheme: `${AUTHOR} - ${TITLE} - ${YEAR}`

    You can change the scheme by modifying the `update_filename` function in `pdfmted-editor` (I haven't implemented a proper setting for this, yet)

- `exiftool` will sometimes fail at updating the metadata of a document. In most cases this is because the PDF file is malformatted. PDFMtEd automatically detects these errors and prompts you to try to repair the file via `qpdf` or `sejda-console`. Personally, I've had more success with Sejda than qpdf, so I'd recommend choosing that option if you are able to install `sejda-console`.

#### Command-line options

There are a couple of command-line switches that might be interesting:

- `-r` will instruct PDFMtEd Editor to check the *rename* option by default
- `-u` enables parsing of URIs instead of file paths

### PDFMtEd Inspector

The UI should be self-explanatory.

### PDFMtEd Thumbnailer

Call `pdfmted-thumbnailer` from the command-line to generate thumbnails:

    pdfmted-thumbnailer <file(s) or folder(s)>

E.g.:

```sh
pdfmted-thumbnailer "file.pdf" "/home/user/Documents" "file2.pdf"
```

This would generate thumbnails for `file.pdf`, `file2.pdf`, and all compatible files found under `/home/user/Documents` and all of its sub-folders.

## Additional information

### Modified metadata tags

PDF documents use a variety of different metadata formats to store meta information.

The oldest and most common tag system is the [PDF Info dictionary][1]. This is the metadata system CLI tools like `pdfinfo` or the *Properties* dialog of various GNOME applications parse.

PDF editors like Adobe Acrobat additionally use the more recent [XMP metadata format][2].

To avert confusion and ensure consistency across different PDF handlers it is important to keep these two metadata systems synchronized. That's why each field in PDFMtEd Editor's user interface controls two separate metadata tags:

| UI field   | PDF Info dictionary entry | corresponding XMP Dublin Core namespace tag |
| ---------- | :-----------------------: | :-----------------------------------------: |
| Author     | Author                    | Creator                                     |
| Title      | Title                     | Title                                       |
| Year       | CreateDate                | Date                                        |
| Keywords   | Keywords                  | Subject                                     |
| Subject    | Subject                   | Description                                 |

### Purging metadata

Removing PDF metadata is not as straightforward as you might think. As stated before, `exiftool` operations are [reversible](http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/PDF.html), so removing all PDF tags with `exiftool -all:all=""` is no good on its own.

Only by [rebuilding the PDF file](https://gist.github.com/hubgit/6078384) (e.g. with `qpdf`) we can ensure that all orphan data is  purged irreversibly.

**Note:** This method does not remove metadata included in embedded objects (e.g. images, vector graphics). To see if your file contains any residual metadata entries you could use a tool like [strings](http://man.cx/?page=strings&do%5Bgo%5D=go) that can look for printable strings in binary data such as PDF files.

## Known issues

- the Webupd8 PPA currently hosts a GTK2 version of YAD. This build is affected by [a bug](https://groups.google.com/d/msg/yad-common/0WfL8eKMhK4/fs6VN0aQuQUJ) that prevents text labels from aligning properly. As a result, the UI might look somewhat disjointed.

    If you don't want to wait for a fix you can directly compile the YAD GTK3 build from source. Provided your system satisfies all dependencies mentioned on the [YAD project page](http://sourceforge.net/projects/yad-dialog/?source=navbar), you may compile and install YAD with the following routine:

        svn checkout svn://svn.code.sf.net/p/yad-dialog/code/trunk yad-dialog-code
        cd yad-dialog-code
        autoreconf -v -i
        ./configure --with-gtk=gtk3
        make
        sudo make install


## License

*PDFMtEd copyright 2014 Glutanimate*

PDFMtEd is licensed under the [GNU GPLv3](http://www.gnu.de/documents/gpl-3.0.en.html).

[1]: http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/PDF.html
[2]: http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/XMP.html

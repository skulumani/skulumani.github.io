---
layout: post
title: "Business Card"
date: 2017-12-21
tags: [professional, latex]
file: https://github.com/skulumani/business_card/raw/master/card.pdf
excerpt: "A LaTeX business card with a QR code"
---
| Build Status                             | Latest Release                                      | Version                                            | Last Commit                                                    | Activity                                    |
| :--------------------------------------: | :--------------------------:                        | :----:                                             | :------:                                                       | :------:                                    |
| [![Travis][travis_shield]][travis]       | [![Github Release][release_shield]][github_release] | [![Github Version][version_shield]][github_version] | [![Github Last Commit][last_commit_shield]][github_last_commit] | [![Github commit activity][activity_shield]][github_activity] |


[travis_shield]: https://travis-ci.org/skulumani/business_card.svg?branch=master 
[release_shield]: https://img.shields.io/github/release/skulumani/business_card.svg
[version_shield]: https://badge.fury.io/gh/skulumani%2Fbusiness_card.svg
[last_commit_shield]: https://img.shields.io/github/last-commit/skulumani/business_card.svg
[activity_shield]: https://img.shields.io/github/commit-activity/y/skulumani/business_card.svg

[travis]: https://travis-ci.org/skulumani/business_card
[github_release]: https://github.com/skulumani/business_card/releases/latest
[github_version]: https://github.com/skulumani/business_card/releases/latest
[github_last_commit]: https://github.com/skulumani/business_card/commits/master
[github_activity]: https://github.com/skulumani/business_card/graphs/commit-activity


## LaTeX

The `memoir` document class allows for the flexibility required to design a business card.
The important step is to set up the correct dimensions:

```
\documentclass[11pt,a4paper]{memoir}
\setstocksize{2in}{3.5in}
\setpagecc{2in}{3.5in}{*}
\settypeblocksize{1.7in}{3.3in}{*}
\setulmargins{0.2in}{*}{*}
\setlrmargins{0.1in}{*}{*}
\setheadfoot{0.1pt}{0.1pt}
\setheaderspaces{1pt}{*}{*}
\checkandfixthelayout[fixed]
```

After this all of the standard LaTeX commands may be used to position and typset the card to get something fancy.

![Card Front]({{ "assets/business_card.png" | absolute_url }})

For the QR code, I created another file and used the [qrcode package][qrcode_latex].
This was the easiest to use as it does not require any other graphics packages or further formatting.
For example, my contact information in MECARD format:

```
\qrcode[hyperlink, height=1.1in, level=L]{MECARD:N:Shankar Kulumani;
URL:skulumani.github.io;
EMAIL:skulumani@gwu.edu;;}%
```

## Example Card

Feel free to use my [card][card] as an example to design your own.

[qrcode]: https://en.wikipedia.org/wiki/QR_code
[zxing]: https://github.com/zxing/zxing/
[vcard]: https://en.wikipedia.org/wiki/VCard
[mecard]: https://en.wikipedia.org/wiki/MeCard_(QR_code)
[sqrl]: https://www.grc.com/sqrl/sqrl.htm
[qrcode_latex]: https://www.ctan.org/tex-archive/macros/latex/contrib/qrcode?lang=en
[card]: https://github.com/skulumani/business_card

## QR Codes

A QR code is a two-dimensional barcode that may be used to store data. 
It is typically used in manufacturing and shipping industries to track objects as the code is well defined and easy to visually track.
In addition, there is significant error correction in the format which allows the codes to be robust to poor lighting or damage.

QR codes are also used to store contact information and in this respect they are ideal for use on a business card.
The QR code allows for a simple means to bridge the gap between the physical and digital world.

Using an appropriate QR code scanner, such as the [zxing project][zxing], allows a smartphone to parse the QR code.
In this manner, any type of information may be embedded within the image, such as:

* Digital contact card (vCard or MECARD)
* URL link
* Telephone or email 
* Wifi password
* Login information - [SQRL][sqrl]

One caveat with QR codes is that they are relatively permanent.
In order to change the information on the code, one would have to reprint the entire code. 
It is possible to use a static QR code to link to a dynamic website. 
This way one could use the same QR code but allow for future modifications.

## Electronic Business Cards

There are two main formats for sharing electronic business card:

* [vCard][vcard]
* [MECARD][mecard]

Both store contact information as a series of name:value pairs. 
However, the MECARD format is more compact and results in a smaller QR code as compared to the vCard format.
In addition, the MECARD format is more widely implemented and is also compatible with the iPhone.

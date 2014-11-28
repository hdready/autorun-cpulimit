# Video Transcoding Scripts

Utilities to transcode, inspect and convert videos.

## About

Hi, I'm [Martin Storbeck] (http://storbeck.me). This script was written while transcoding a collection of Blu-ray Discs and DVDs with HandBrake. I needed a CPU limiter for handbrake to reduce fan-noise and heat; it needed to run on startup and had to be easily adjustable. Based on `cpulimit` I wrote this while-loop which allows you to enter an application and a percentage of CPU-usage (that can be changed at any time).


The script was written in [Bash](http://www.gnu.org/software/bash/) and leverages the excellent Open Source and cross-platform software like [CPUlimit](https://github.com/opsengine/cpulimit). Essentially the script is an intelligent wrapper around this tool.

Even if you don't use any of these scripts, you may find their source code or this "README" document helpful.

## Requirements

The script works on OS X because that's the platform where it is developed. It requires CPUlimit, which is available via [Homebrew](http://brew.sh).

CPUlimit can also be [downloaded and installed manually](https://github.com/opsengine/cpulimit).

Installing a package with Homebrew is as simple as:

    brew install cpulimit

## Installation

Download the script and put it wherever you want.  In some cases you might need to set permissions to execute the scripts like this. In terminal, change to the directory where you put the script and enter:

    chmod u+x autorun-cpulimit.command

Or simply:

chmod u+x "/folder/where/you/put/the/script/autorun-cpulimit.command"

Start the script by double-click or run it via terminal or put it in Settings -> Users & Groups -> Login Items

## Default Values

By default, the script limits HandBrakeCLI to 30% CPU usage (multiplied with the number of cores in your machine). To define other default settings, edit the script.

Change the default program here:

    default_application="HandBrakeCLI"

Change the default cpu-percentage here:

    default_percentage="30"

## Feedback

The best way to send feedback is mentioning me [@hdready](http://twittter.com/hdready) on Twitter. 

## License

Autorun-cpulimit is copyright [Martin Storbeck](http://storbeck.me) and available under a [MIT license](https://github.com/hdready/autorun-cpulimit/LICENSE).

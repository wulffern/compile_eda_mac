---
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

Installing from source can sometimes be a drawn out process, I'm
impatient and often miss things in documentation, and thus end up 
debugging for a while.

I also forget what I did, what libraries I installed, 
what problems I solved, what hacks I implemented, and what modifications 
I did to the source.

As such, I spent some effort to write everything down.

Github luckily has a macOS instance, so it's possible to create
an
[action](https://github.com/wulffern/compile_eda_mac/blob/main/.github/workflows/makefile.yml)
and a [Makefile](https://github.com/wulffern/compile_eda_mac/blob/main/Makefile)
to create a full continuous integration/deployment flow to create a
[macos-12](assets/eda-macos-12.tar.gz) release.


## Do things your self 
Clone the repo, and have a look at the `makefile.yaml` action and the Makefile
to understand what you need to do.

## Use the release on MacOS

In theory, it should be possible to download
[macos-12](assets/eda-macos-12.tar.gz) and use it, however, I've
not been successful yet with that strategy.

``` bash
cd /
sudo tar zxvf ~/Downloads/eda-macos-12.tar.gz
```




  

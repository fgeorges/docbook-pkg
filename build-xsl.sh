zip="$1"

## Utility functions

die() {
    echo
    echo "*** $@" 1>&2;
    exit 1;
}

## Checks on the variables

if test -z "$zip"; then
    die "The ZIP file is a mandatory option."
fi

if test \! -f "$zip"; then
    die "ZIP file '$zip' is not a regular file."
fi

if test \! -d garbage; then
    die "The 'garbage' dir does not exist.  Are you in the root dir?"
fi

## Unzip it

rm -rf garbage/*
unzip "$zip" -d garbage/ >/dev/null

src=`echo garbage/docbook-*/`
num=`echo "$src" | sed -e 's|garbage/docbook-xsl-\(.*\)/|\1|'`
dest=garbage/build

mkdir "$dest"
mkdir "$dest/content"

die "TODO: Build EXPATH-PKG.XML dynamically!"

cp    rsrc/docbook-xsl-pkg.xml  "$dest/expath-pkg.xml"
cp    rsrc/docbook-xsl-cxan.xml "$dest/cxan.xml"
cp    "$src/VERSION"            "$dest/content/"
cp -R "$src/common"             "$dest/content/"
cp -R "$src/epub"               "$dest/content/"
cp -R "$src/epub3"              "$dest/content/"
cp -R "$src/fo"                 "$dest/content/"
cp -R "$src/highlighting"       "$dest/content/"
cp -R "$src/html"               "$dest/content/"
cp -R "$src/lib"                "$dest/content/"
cp -R "$src/manpages"           "$dest/content/"
cp -R "$src/params"             "$dest/content/"
cp -R "$src/profiling"          "$dest/content/"
cp -R "$src/template"           "$dest/content/"
cp -R "$src/website"            "$dest/content/"
cp -R "$src/xhtml"              "$dest/content/"

( cd "$dest"; zip -r "docbook-xsl-${num}.xar" . )

mv "$dest"/*.xar dist/

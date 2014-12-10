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
num=`echo "$src" | sed -e 's|garbage/docbook-\(.*\)/|\1|'`
dest=garbage/build

mkdir "$dest"
mkdir "$dest/content"

sed "s/{@VERSION}/$num/g" rsrc/docbook-schemas-pkg.xml  > "$dest/expath-pkg.xml"
sed "s/{@VERSION}/$num/g" rsrc/docbook-schemas-cxan.xml > "$dest/cxan.xml"

cp    "$src/docbook.nvdl"    "$dest/content/"
cp    "$src/dtd/docbook.dtd" "$dest/content/"
cp    "$src/sch/docbook.sch" "$dest/content/"
cp -R "$src/rng"             "$dest/content/"
cp -R "$src/xsd"             "$dest/content/"

( cd "$dest"; zip -r "docbook-schemas-${num}.xar" . )

mv "$dest"/*.xar dist/

#!/usr/bin/env fish

set name (basename (status -f))

echo "package ctxdata"
echo ""
echo "import ("
echo "	\"time\""
echo ")"
echo ""
echo "// Code generated by $name; DO NOT EDIT."

for pair in String/string Int/int Int64/int64 Uint64/uint64 Float64/float64 Bool/bool Duration/time.Duration Time/time.Time
    set name   (echo $pair | cut -d'/' -f1)
    set gotype (echo $pair | cut -d'/' -f2)
    echo ""
    echo "// Get$name return the value of key as a $gotype."
    echo "// If key is not set, or its value is not a $gotype,"
    echo "// then Get$name returns defaultValue."
    echo "func (d *Data) Get$name(key string, defaultValue $gotype) $gotype {"
    echo "	val, err := d.Get(key)"
    echo "	if err != nil {"
    echo "		return defaultValue"
    echo "	}"
    echo ""
    echo "	res, ok := val.($gotype)"
    echo "	if !ok {"
    echo "		return defaultValue"
    echo "	}"
    echo ""
    echo "	return res"
    echo "}"
end

# Misc Utils

function sz() {
    if [[ ! -d "$2" ]] && [[ ! -f "$2" ]]; then
        echo "Query the size of a (file/directory)"
        exit 1
    fi
    find "$2" -maxdepth 0 -exec ls -lh {} \; | awk '{print "\033[1;31m" $5 "\033[0m" "\t" $9}'
}

function clip() {
    if [[ ! -f "$2" ]]; then
        echo "Copy (file) contents to clipboard"
        exit 1
    fi
    xclip -sel clip < "$2"
}

function img-comp() {
    if [[ ! -f "$2" ]] || [[ ! -f "$3" ]]; then
        echo "Compare two (images)"
        exit 1
    fi
    img1="$2"
    img2="$3"
    compare -verbose -metric AE "$img1" "$img2" null: 2>&1
    compare -verbose -metric AE -fuzz 0.3% "$img1" "$img2" null: 2>&1
    compare -verbose -metric MAE "$img1" "$img2" null: 2>&1
    compare -verbose -metric RMSE "$img1" "$img2" null: 2>&1
}

# convert iso8601 UTC timestamp to local time
# example: "conv-iso 021-02-24T21:12:02.479"
function conv-iso() {
    if [[ "$#" -lt 2 ]]; then
        echo 'provide: iso8601'
    else
        date -d "$2 today -8 hours" "+%I:%M%p %Ss | %a.%d"
    fi
}

# convert UTC timestamp in seconds to local time
# example: "conv-ts 1614207232"
function conv-ts() {
    if [[ "$#" -lt 2 ]]; then
        echo 'provide: timestamp in seconds'
    else
        # trim numbers from tail, st timestamp is length 10
        TS="$2"
        LEN="10"
        if [[ "${#TS}" -gt "$LEN" ]]; then
            CUT="$(("${#TS}" - "$LEN"))"
            TS=${TS::-$CUT}
        fi
        date "+%I:%M%p %Ss | %a.%d" -d "@$TS"
    fi
}
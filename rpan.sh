for C in jq xdg-open nc curl xclip; do 
    command -v "$C" >/dev/null 2>&1 || { echo "$C is required but not installed, aborting" >&2; exit 1; }
done

usage() {
    echo "Usage: $0 SubredditName \"stream title\" [access_token]"
    exit 1
}

sub="$1"
test -z "$sub" && usage
title="$2"
test -z "$title" && usage

REDIR=$(cat <<EOF
HTTP/1.1 200 OK

<script>
if( location.href.indexOf("#") > 0) {
  window.setTimeout(function(){
    location.href=location.href.replace("#","?") // redirect with hash string parameters as query string (so it is sent to the HTTP server)
}, 100);
} else {
  document.write("Thanks. You can close this window now");
}
</script>
EOF
)

get_access_token() {
    # open browser
    xdg-open "https://www.reddit.com/api/v1/authorize?client_id=ohXpoqrZYub1kg&response_type=token&redirect_uri=http://localhost:65010/callback&scope=*&state=$RANDOM"
    # start a "web" server and wait for the user to click on accept which would lead to requests to this server

    # the server is queried for favicon too and in random order - in that case the token is in the referrer header - proper web server would be better
    while true; do
        access_token=$(echo "$REDIR" | nc -lvp 65010 -q0  | grep -E 'access_token=' | sed -ne 's/.*access_token=\([^&]*\).*/\1/p')
        test -z "$access_token" || break
    done
}


access_token="$3"
test -z "$access_token" && get_access_token

echo "Access Token: $access_token" # can be reused for 1 hour as an argument to this script


stream=$(curl -v -XPOST "https://strapi.reddit.com/r/$sub/broadcasts" \
    -G --data-urlencode "title=$title" \
    -H "User-Agent: Key/0.1" \
    -H "Authorization: Bearer $access_token");

post=$(echo "$stream" | jq -r '.data.post.url')
key=$(echo "$stream" | jq -r '.data.streamer_key')
test -z "$key" && echo "$stream" && exit 1

echo -n "$key" | xclip -sel p -f | xclip -i -sel c # copy to both clipboards

echo "Post URL: $post"
echo "RTMP URL: rtmp://ingest.redd.it/inbound/"
echo "Streamer Key: $key (copied to your clipboard)"

# TODO query watchers / remaining time / comments?


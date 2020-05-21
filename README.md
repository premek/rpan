This script allows you to start streaming to Reddit Public Access Network (RPAN) from OBS. It's written in bash and is tested to be running on Linux.
Thanks to https://github.com/Spikeedoo/SnooKey and https://github.com/IOnlyPlayAsDrift/Snookey2 for the knowhow.

If you dont use Linux or the script doesn't work for you it is easy to do the steps manually or implement it in another scripting language:

[Read how it works here](MANUAL.md)

## Installation
- Just download the `rpan.sh` and make it executable.

## Usage:
```
$ ./rpan.sh SubredditName "stream title"
```
for example:
```
$ ./rpan.sh RedditSessions "Playing my ukulele"
Post URL: https://www.reddit.com/rpan/r/RedditSessions/glly1o
RTMP URL: rtmp://ingest.redd.it/inbound/
Streamer Key: 938baa45-180f-4e9e-932e-eaa0a45eaf2e (copied to your clipboard)
```
Now you have to open OBS, go to Settings -> Stream, select Service: Custom and fill in:
 - Server: rtmp://ingest.redd.it/inbound/
 - Stream Key: (see the last line of the script output - `938baa45-180f-4e9e-932e-eaa0a45eaf2e` in this case - it is also copied to your clipboard so you can just paste it)

![OBS settings (c) Spikeedoo](https://github.com/Spikeedoo/SnooKey/blob/master/examples/snookey03.PNG)    


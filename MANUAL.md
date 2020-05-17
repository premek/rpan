# How to obtain RPAN streaming key to be used in OBS
1. Open this URL in a browser. The reddit user must be logged in. 
https://www.reddit.com/api/v1/authorize?client_id=ohXpoqrZYub1kg&response_type=token&redirect_uri=http://localhost:65010/callback&scope=*&state=1234
1. Click on **Agree**. This is using the "reddit on Android" app ID to obtain an access token used later.
1. You will get redirected to `http://localhost:65010/callback#access_token=45450553-r7yurPDsI1HdfhTHUp-XcM7GPGQ&token_type=bearer&state=1234&expires_in=3600&scope=%2A` in your browser. It will show an error screen which is fine.
1. Copy the `access_token` part from the URL you got redirrected to. `45450553-r7yurPDsI1HdfhTHUp-XcM7GPGQ` in this example.
1. Make HTTP request to:
   - URL: `https://strapi.reddit.com/r/<subreddit>/broadcasts?title=<url_encoded_title>`
   - Method: POST
   - Headers: 
     - User-Agent: <cannot_be_empty>
     - Authorization: Bearer <access_token>
   
   - example:
   ```
   POST /r/RedditSessions/broadcasts?title=test%20test HTTP/2
   Host: strapi.reddit.com
   User-Agent: xxx/0.1
   Authorization: Bearer 45450553-r7yurPDsI1HdfhTHUp-XcM7GPGQ
   ```
1. In the JSON response get `data.streamer_key` field. That's what is to be entered in OBS settings
 



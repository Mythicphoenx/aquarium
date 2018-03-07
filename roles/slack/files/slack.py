import re
import time
import json
import psutil
import io
from slackclient import SlackClient


slack_client = SlackClient("{{SlackClient}}")

# Fetch your Bot's User ID
user_list = slack_client.api_call("users.list")
for user in user_list.get('members'):
    if user.get('name') == "rpi":
        slack_user_id = user.get('id')
        break

for user in user_list.get('members'):
    if user.get('name') == "sander":
        slack_user_id_sander = user.get('id')
        break

# Fetch your Bot's channels.list
channel_list = slack_client.api_call("channels.list")

for channel in channel_list.get('channels'):
    if channel.get('name') == "aquarium":
        slack_channel_id = channel.get('id')
        break

# Start connection
if slack_client.rtm_connect():
    files = {'file': '/var/www/html/image.jpg'}
    image=slack_client.api_call(
        "files.upload",
        channels=slack_user_id_sander,
        file=open('/var/www/html/image.jpg', 'rb')
    )


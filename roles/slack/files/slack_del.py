import re
import time
import json
import psutil
import io
import datetime
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

# print slack_user_id_sander

im_list = slack_client.api_call("im.list")
for im in im_list.get('ims'):
    if im.get('user') == slack_user_id_sander:
        slack_im_id = im.get('id')
        break

# print slack_im_id

im_history = slack_client.api_call("im.history", channel=slack_im_id)
#print im_history

for messages in im_history.get('messages'):
    if messages.get('subtype') == 'file_share':
        file = messages.get('file')
        d = datetime.datetime.fromtimestamp(int(file.get('timestamp')))
        date_N_days_ago = datetime.datetime.now() - datetime.timedelta(days=1)

        if d.strftime('%M') != '00':
            if d < date_N_days_ago:
                print slack_client.api_call(
                    "files.delete",
                    file=file.get('id')
                )

import json
import websocket

ws = websocket.create_connection("ws://localhost:7905")
devid = 'python-status'
mesid = 'python-status-mex-'
mescount = 1

auth = {
    "name": "authenticate",
    "type": "request",
    "id": (mesid + str(mescount)),
    "device_id": devid,
    "options": {
        "password": ""
    }
}

mescount += 1
ws.send(json.dumps(auth))
ws.recv()

get_play_back = {
    "name": "get_playback_overview",
    "type": "request",
    "id": mesid + str(mescount),
    "device_id": devid,
    "options": { }
}

ws.send(json.dumps(get_play_back))
res = json.loads(ws.recv())
track_info = res['options']['playing_track']

print(track_info['title'], " [", track_info['artist'], "-", track_info['album'], "]")

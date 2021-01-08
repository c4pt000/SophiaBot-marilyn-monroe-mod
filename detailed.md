
# * marilyn monroe (for portrait testing purposes) using "festival" for speech output




to display "SophiaBot -> OpenCOG ai chatbot via avatar type display
<br>
<br>
<br>
<br>
current * 11-22-2019
<p align="center"><img src="https://i.imgur.com/hDqUq1m.png " width="1280"></p>
<br>
<br>
<br>
<br>
<br>
<br>

*previous rough draft design
<p align="center"><img src="https://i.imgur.com/02JmtJe.png" width="800"></p>

<br>
<p align="center"><img src="https://i.imgur.com/yrJQIiv.png" width="800"></p>

<br>
<br>
<br>
<br>
to load run_server.py (script takes about 35 seconds to load)
<br>
2nd-Sophia_client.sh (to load graphics and text to speech output)
<br>
project uses (and depends on) xcowsay and festival for text to speech output (there is no text to speech input)
<br>
<br>
comicChat-wip possibility for the AI to use a local irc server for the AI visual output via the avatar to have breathability 
<br>
using comicChat-strip-Generator for the avatar's expression
<br>
https://github.com/c4pt000/Comic-Chat-Generator
<br>

project also depends on the .txt files to format and process the bot's responses for visual output with cowsay using sed and <br>
grep
<br>

#!/bin/bash
<br>

grep -o 'c]:.*' clientout.txt > clienttxt.out 
<br>
cat clienttxt.out | tail -n 1 > txt.out
<br>
grep -o 'c]:.*' txt.out > currenttxt.out 
<br>
sed -n 's/^.*c]://p' currenttxt.out > fesout.txt
<br>
cat fesout.txt
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


# Sophia-bot
<br>
script pulled from the OpenCOG project
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

(centos)
<br>

centos-release-scl.noarch : Software collections from the CentOS SCLo SIG
<br>
centos-release-scl-rh.noarch : Software collections from the CentOS SCLo SIG
<br>

yum install centos-release-scl
<br>

yum install rh-python36
<br>

scl enable rh-python36 bash
<br>
<br>
<br>
<br>

#  macOS 
<br>
as root:
<br>
sh install-macos-deps.sh
<br>
sh macOS_run_server_and_noirc.sh
<br>
<br>
<br>
<br>
javascript client as script is running
<br>
http://localhost:8001/v1.1/client
<br>
<br>
<br>
<br>
<br>
<br>
<br>



chatbot server and client using python from hansonrobotics/chatbot loads a twisted python irc bot


clone the project and run "sh install-deps-ubuntu.sh"

----------------------------------------------------------------------------------------------------------

make sure to edit the irc server and channel that the bot connects to and its bot name in scripts/Sophia.py

self.nickname = 'Sophia-bot'

self.join('#null')

reactor.connectTCP('moon.freenode.net', 6667, f)

-----------------------------------------------------------------------------------------------------------

run the chatbot server and connect the irc bot

"sh run_server_and_ircbot.sh"


javascript client via browser
http://localhost:8001/v1.1/client


*thank you to habbasi for helping me debug the irc bot's replies with client.py

This is a premature question-answering server. The goal is to provide a ROS independent, scalable, platform-independent QA.

## Run Server
`$ python run.py [port]`

The default port is 8001.

## Load Characters
The default path of the characters is the current [characters](https://github.com/hansonrobotics/HEAD/tree/master/src/chatbot/scripts/characters) directory.
But you can overwrite it by setting the environment variable `HR_CHARACTER_PATH`. Use comma seperator. For example

`$ HR_CHARACTER_PATH=/path/to/characters1:/path/to/characters2 python run.py`

## Define a Character

You can wirte either Python or YAML to define your character.

### Write Python module
```python
from server.character import AIMLCharacter
# id is an unique global string that refers to this character. name is the character name.
character = AIMLCharacter(id, name)
character.load_aiml_files([file1, file2])
character.set_property_file(abc.properties) # Set the key,value properties.

characters = [character] # you need to put character to this module-wide variable so the server can find and load it
```

### Write YAML file

There is a convienent way to load the definition from yaml file.

The yaml file format is like this. The path is relative to the yaml file itself.
```yaml
id:
    han
name:
    han
level:
    90
weight:
    1
property_file:
    ../../../character_aiml/han.properties
aiml:
    - ../../../futurist_aiml/agians.aiml
    - ../../../futurist_aiml/aiexistsans.aiml
    - ...
```

## Client for testing
There is a client for testing purpose. It is called [client.py](https://github.com/hansonrobotics/HEAD/blob/master/src/chatbot/scripts/client.py).

Run `$ python client.py`, then you can ask questions and get the answers. Type `help` for the usage.

## Chatbot Server API (v1.1)

### Start a session

```
GET /v1.1/start_session
```

Parameters: 
- *Auth* - Authorization token
- *botname* - Chatbot name
- *user* - User name
- *test* - If true, start a test session, else start a normal session
- *refresh* - If true, start a new session, else try to reuse the session binding with the same user name

Return:
- *ret* - Return code
- *sid* - Session ID

### List responding character chain

```
GET /v1.1/chatbots
```

Parameters: 
- *Auth* - Authorization token
- *lang* - Language
- *session* - Session ID

Return:
- *ret* - Return code
- *response*

### Chat

```
GET /v1.1/chat
```

Parameters: 
- *Auth* - Authorization token
- *question* - Question
- *lang* - Language
- *session* - Session ID
- *query* - It's a try ask (True or False)

Return:
- *ret* - Return code
- *response*

### Batch Chat

```
POST /v1.1/batch_chat
```

Parameters: 
- *Auth* - Authorization token
- *questions* - Questions
- *lang* - Language
- *session* - Session ID

Return:
- *ret* - Return code
- *response* - List of responses

### Get Bot Names

```
GET /v1.1/bot_names
```

Parameters: 
- *Auth* - Authorization token

Return:
- *ret* - Return code
- *response*

### Set Weights for Each Tier in the Chain

```
GET /v1.1/set_weights
```

Parameters:
- *Auth* - Authorization token
- *param* - Tier weight parameter. Could be, for example, "0=1, 1=0.5", or "reset"
- *session* - Session ID

Return:
- *ret* - Return code
- *response*

### Upload character

```
GET  /v1.1/upload_character
```

Parameters:
- *Auth* - Authorization token
- *user* - User name
- *zipfile* - Character package

Return:
- *ret* - Return code
- *response*

### Rate the answer

```
GET /v1.1/rate
```

Parameters:
- *Auth* - Authorization token
- *session* - Session ID
- *index* - Index of the answer in the session. For exmaple, -1 means the last response.
- *rate* - Rate string, such as "good" or "bad".

Return:
- *ret* - Return code
- *response*

### List current sessions

```
GET /v1.1/sessions
```

Parameters:
- *Auth* - Authorization token

Return:
- *ret* - Return code
- *response*

### Set custom context

```
GET /v1.1/set_context
```

Parameters:
- *Auth* - Authorization token
- *session* - Session ID
- *context* - Context string (format key=value,key2=value2)

Return:
- *ret* - Return code
- *response*

### Remove context

```
GET /v1.1/remove_context
```

Parameters:
- *Auth* - Authorization token
- *session* - Session ID
- *context* - Context keys (format key,key2,key3,...)

Return:
- *ret* - Return code
- *response*

### Get session context

```
GET /v1.1/get_context
```

Parameters:
- *Auth* - Authorization token
- *session* - Session ID
- *lang* - Language

Return:
- *ret* - Return code
- *response*

### Add the message to the output history of the control tier, as the tier has said that before

```
GET /v1.1/said
```

Parameters:
- *Auth* - Authorization token
- *session* - Session ID
- *message* - Message text

Return:
- *ret* - Return code
- *response*


```
GET /v1.1/update_config
```

Parameters:
- *Auth* - Authorization token
- *config_key* - Configuration key
- *config_key2* - Configuration key2
- ...

Return:
- *ret* - Return code
- *response*





















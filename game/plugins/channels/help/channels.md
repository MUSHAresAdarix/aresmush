---
topic: channels
toc: Communicating
summary: Public chat channels.
categories:
- main
order: 1
aliases:
- channel
- chat
- comsys
plugin: channels
---
Channels are public forums for out-of-character communication.  Each game will have a variety of channels available for use.  Some will be locked so that only people with certain roles may use them.

`channels` - Lists channels and their descriptions and roles.  Also shows at
        a glance which channels you're monitoring and the command to talk on them.

You will only see messages on channels you have chosen to join, and you may leave those channels at any time.  When you join a channel, you can specify an alias or nickname.  This becomes the command you use to talk on the channel. Otherwise the system will set one by default.

`channel/join <channel>[=<alias>]`
`channel/leave <channel>`
`<channelalias> <message>` - Talks on a channel.

NOTE: Take care to avoid channel aliases that overlap with other commands, like 'n' for north or 'p' for page.  Remember that AresMUSH ignores prefixes like '+' on commands.

Other handy channel commands:
`channel/who <channel>` - Shows who's on the channel
`channel/gag <channel> or channel/ungag <channel>` - Despams for awhile.
        Gagging is cleared when you disconnect.  You can use 'all' to gag or ungag all channels.
`channel/recall <channel>[=<num messages>]` - Shows the last few messages on a channel.

You can also use MUX-style channel commands, by using the keywords "on", "off", "who", "last", "gag", and "ungag" with the channel alias.  For example:  `pub who`.
---
title: Survival Guide to IRC identification
---
NickServ is the utility used for registration and protection of nicknames. It allows users to register a nickname, and prevent others from using that nickname. 

For a deeper understanding of the service, I recommend using the online HELP.

```
/msg NickServ help [<command>]
```

**Important Note:** If a registered nickname is not logged in for 30 days, NickServ will drop the account, making it available again. If using Freenode, see their [Policies](https://freenode.net/policies#nickname-ownership).

## Register a nickname

```
/msg NickServ REGISTER <password> <email-address>
```

Most servers require a valid email address that they will e-mail with a verification code.

## Log in to the network

Next time you log into the network, you will be prompted for your account password. Identify with the server.

```
/msg NickServ IDENTIFY <password>
```

## Update your information

Update the email address associated with the current account.

```
/msg NickServ SET email <new-email-address>
```

Update the password associated with the current account.

```
/msg NickServ SET password <new-password>
```

## Password Recovery

If you forget your NickServ password and need a reminder.

```
/msg NickServ sendpass <nickname>
```

## Enforce, Blocked and Release

```
/msg NickServ SET ENFORCE <ON|OFF>
```

When `ENFORCE ON`, NickServ will automatically protect any nickname registered to your account by forcibly switching the nick of anyone who attempts to use them without identifying after thirty seconds.  
After a nickname enforcement has happened, the nickname is temporarily blocked.

If you attempt to identify to NickServ more than N amount of times, your nickname will be also temporarily blocked. The services program does this by logging a bot onto the network under your nickname as an extra security precaution.

Whether the server enforced your nickname or blocked from use the RELEASE command can unblock the nickname for it to be used again.

```
/msg NickServ RELEASE <nickname> <password>
```

## Ghosts

A "ghost" session is one which is not connected, but which the IRC server believes is still online. Typically, this happens if client crashes or your Internet connection goes down while you're on IRC.
You can easily disconnect the ghost without any administration help.

```
/msg NickServ GHOST <nickname> <password>
```

## Freenode Cloak

If you're identified to NickServ is possible to replace the `hostname/IP` displayed when you are connected.

**Note:** Cloaks can help obscure your IP address/hostname, but should not be relied upon for that purpose, as they are not reliable. See [Cloaks do not effectively hide your IP](https://freenode.net/kb/answer/cloaks#cloaks-do-not-effectively-hide-your-ip)

You can ask for an unaffiliated cloak in `#freenode`. This is our standard cloak and normally shows `unaffiliated/<nickname>`.  
To obtain one of these, you need to find the group contact for the group you are interested in, and ask them to arrange the cloak for you.

**Ultimately consider connecting using TOR and SASL.**

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Description](#description)
- [Documentation](#documentation)
	- [Websockets](#websockets)
		- [1. GeoCache Channel](#1-geocache-channel)
		- [2. Comment Channel](#2-comment-channel)
		- [3. Reply Channel](#3-reply-channel)
	- [Endpoints](#endpoints)
		- [Users](#users)
			- [New Registration](#new-registration)

# Description

This api has the following features:

- user registration/login
- create a geocache
- comment on a geocache
- reply to a comment
- like/unlike a geocache/comment/reply

The api is hosted in the following url: https://blooming-cove-35281.herokuapp.com/

# Documentation

## Websockets

This API provides three channels:

### 1. GeoCache Channel

**Channel: GeoCacheChannel**

This channel provides updates on the geocaches, it doesn't have any rooms. It sends a json with the following fields:

```json
{
	"id": "", // ID - type string
	"title": "", // title - type string
	"message": "", // message - type string
	"lat": "", // latitude - type float
	"lng": "", // longitude - type float
	"likes": "", // total likes for this cache - type integer
	"unlikes": "", // total unlikes for this cache - type integer
	"comments": "", // total comments for this cache - type integer
	"cacher": {
		"id": "", // ID of the cacher - type string
		"username": "" // username - type string
	}
}
```

### 2. Comment Channel

**Channel: CommentChannel**

**Room: <GeoCache_ID>**

This channel provides updates on the comments for a geocache. It sends a json with the following fields:

```json
{
	"id": "", // ID - type string
	"comment": "", // comment - type string
	"geo_cache_id": "", // ID of the geocache that this comment belongs to - type string
	"likes": "", // total likes for this comment - type integer
	"unlikes": "", // total unlikes for this comment - type integer
	"replies": "", // total replies for this comment - type integer
	"commenter": {
		"id": "", // ID of the commenter - type string
		"username": "" // username - type string
	}
}
```

### 3. Reply Channel

**Channel: ReplyChannel**

**Room: <Comment_ID>**

This channel provides updates on the replies for a comment. It sends a json with the following fields:

```json
{
	"id": "", // ID - type string
	"reply": "", // comment - type string
	"comment_id": "", // ID of the comment that this reply belongs to - type string
	"likes": "", // total likes for this reply - type integer
	"unlikes": "", // total unlikes for this reply - type integer
	"sender": {
		"id": "", // ID of the sender - type string
		"username": "" // username - type string
	}
}
```

We recommend using [actioncable-client-react](https://www.npmjs.com/package/actioncable-client-react) for connecting from a react application. But you are free to use any library that you're comfortable with.

## Endpoints

### Users

#### New Registration

`POST   /api/users`

request:

```json
{
	"user": {
		"email": "",
		"password": "",
		"username": "",
		"first_name": "",
		"last_name": ""
	}
}
```

response:

```json
{
	
}
```

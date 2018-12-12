# Table of Contents

+ [Table of Contents](#table-of-contents)
+ [Description](#description)
+ [Documentation](#documentation)
	+ [Websockets](#websockets)
		+ [GeoCache Channel](#geocache-channel)
		+ [Comment Channel](#comment-channel)
		+ [Reply Channel](#reply-channel)
	+ [Endpoints](#endpoints)
		+ [Users](#users)
			+ [New Registration](#new-registration)
			+ [Login](#login)
			+ [Refresh Token](#refresh-token)
		+ [GeoCaches](#geocaches)
			+ [Index](#index)
			+ [Show](#show)
			+ [Create](#create)
			+ [Update](#update)
			+ [Delete](#delete)
			+ [Like](#like)
			+ [Unlike](#unlike)
			+ [Reactions](#reactions)
		+ [Comments](#comments)
			+ [Show](#show-1)
			+ [Create](#create-1)
			+ [Update](#update-1)
			+ [Delete](#delete-1)
			+ [Like](#like-1)
			+ [Unlike](#unlike-1)
			+ [Reactions](#reactions-1)
		+ [Replies](#replies)
			+ [Show](#show-2)
			+ [Create](#create-2)
			+ [Update](#update-2)
			+ [Delete](#delete-2)
			+ [Like](#like-2)
			+ [Unlike](#unlike-2)
			+ [Reactions](#reactions-2)

# Description

This api has the following features:

- user registration/login
- create a geocache
- comment on a geocache
- reply to a comment
- like/unlike a geocache/comment/reply

The api is hosted in the following url: https://blooming-cove-35281.herokuapp.com/

Test instructions can be found here: [Test Instructions](https://github.com/i8software/test_api/wiki)

# Documentation

## Websockets

This API provides three channels:

### GeoCache Channel

**Channel: GeoCacheChannel**

This channel provides updates on the geocaches, it doesn't have any rooms. It sends a json with the following fields:

```json
{
	"id": "// UUID - type string",
	"title": "// title - type string",
	"message": "// message - type string",
	"lat": "// latitude - type float",
	"lng": "// longitude - type float",
	"likes": "// total likes for this cache - type integer",
	"unlikes": "// total unlikes for this cache - type integer",
	"comments": "// total comments for this cache - type integer",
	"cacher": {
		"id": "// UUID of the cacher - type string",
		"username": "// username - type string",
		"avatar_url": "// type string"
	}
}
```

### Comment Channel

**Channel: CommentChannel**

**Room: <GeoCache_ID>**

This channel provides updates on the comments for a geocache. It sends a json with the following fields:

```json
{
	"id": "// UUID - type string",
	"comment": "// comment - type string",
	"geo_cache_id": "// UUID of the geocache that this comment belongs to - type string",
	"likes": "// total likes for this comment - type integer",
	"unlikes": "// total unlikes for this comment - type integer",
	"replies": "// total replies for this comment - type integer",
	"commenter": {
		"id": "// UUID of the commenter - type string",
		"username": "// username - type string",
		"avatar_url": "// type string"
	}
}
```

### Reply Channel

**Channel: ReplyChannel**

**Room: <Comment_ID>**

This channel provides updates on the replies for a comment. It sends a json with the following fields:

```json
{
	"id": "// UUID - type string",
	"reply": "// comment - type string",
	"comment_id": "// UUID of the comment that this reply belongs to - type string",
	"likes": "// total likes for this reply - type integer",
	"unlikes": "// total unlikes for this reply - type integer",
	"sender": {
		"id": "// UUID of the sender - type string",
		"username": "// username - type string",
		"avatar_url": "// type string"
	}
}
```

We recommend using [actioncable-client-react](https://www.npmjs.com/package/actioncable-client-react) for connecting from a react application. But you are free to use any library that you're comfortable with.

## Endpoints

This api uses jwt token authentication. Except for **New Registration**, **Login**, **Refresh Token** all endpoints need to be authorized.

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
    "id": "// UUID",
    "username": "// type string",
    "email": "// type string",
    "first_name": "// type string",
    "last_name": "// type string",
    "geo_caches": "// type integer",
    "comments": "// type integer",
    "replies": "// type integer",
    "reactions": "// type integer",
	"avatar_url": "// type string"
}
```

#### Login

`POST   /api/oauth/token`

request:

```json
{
	"grant_type": "password",
	"email": "// USER EMAIL",
	"password": "// USER PASSWORD"
}
```

response:

```json
{
    "access_token": "// type string",
    "token_type": "Bearer",
    "expires_in": "//type integer",
    "refresh_token": "// type string",
    "created_at": "// type datetime obj",
    "email": "//type string",
    "id": "UUID",
	"avatar_url": "// type string"
}
```

#### Refresh Token

`POST   /api/oauth/token`

request:

```json
{
	"grant_type": "refresh_token",
	"refresh_token": "// REFRESH_TOKEN"
}
```

response:

```json
{
    "access_token": "// type string",
    "token_type": "Bearer",
    "expires_in": "//type integer",
    "refresh_token": "// type string",
    "created_at": "// type datetime obj",
    "email": "//type string",
    "id": "UUID",
	"avatar_url": "// type string"
}
```

### GeoCaches

#### Index

This endpoint uses [ransack](https://github.com/activerecord-hackery/ransack) to filter the results and [will_paginate](https://github.com/mislav/will_paginate) for pagination.

`GET    /api/geo_caches`

request:

```json
{}
```

response:

```json
[
	{
		"id": "// UUID - type string",
		"title": "// title - type string",
		"message": "// message - type string",
		"lat": "// latitude - type float",
		"lng": "// longitude - type float",
		"likes": "// total likes for this cache - type integer",
		"unlikes": "// total unlikes for this cache - type integer",
		"comments": "// total comments for this cache - type integer",
		"cacher": {
			"id": "// UUID of the cacher - type string",
			"username": "// username - type string",
			"avatar_url": "// type string"
		}
	}
]
```

#### Show

`GET    /api/geo_caches/:id`

request:

```json
{}
```

response:

```json
{
	"id": "// UUID - type string",
	"title": "// title - type string",
	"message": "// message - type string",
	"lat": "// latitude - type float",
	"lng": "// longitude - type float",
	"likes": "// total likes for this cache - type integer",
	"unlikes": "// total unlikes for this cache - type integer",
	"comments": [
		{
			"id": "// UUID - type string",
			"comment": "// comment - type string",
			"geo_cache_id": "// UUID of the geocache that this comment belongs to - type string",
			"likes": "// total likes for this comment - type integer",
			"unlikes": "// total unlikes for this comment - type integer",
			"replies": "// total replies for this comment - type integer",
			"commenter": {
				"id": "// UUID of the commenter - type string",
				"username": "// username - type string",
				"avatar_url": "// type string"
			}
		}
	],
	"cacher": {
		"id": "// UUID of the cacher - type string",
		"username": "// username - type string",
		"avatar_url": "// type string"
	}
}
```

#### Create

`POST   /api/geo_caches`

request:

```json
{
	"geo_cache": {
		"title": "// type string",
		"message": "// type string",
		"lat": "// latitude - type float",
		"lng": "// longitude - type float"
	}
}
```

response:

```json
{
	"id": "// UUID - type string",
	"title": "// title - type string",
	"message": "// message - type string",
	"lat": "// latitude - type float",
	"lng": "// longitude - type float",
	"likes": "// total likes for this cache - type integer",
	"unlikes": "// total unlikes for this cache - type integer",
	"comments": [
		{
			"id": "// UUID - type string",
			"comment": "// comment - type string",
			"geo_cache_id": "// UUID of the geocache that this comment belongs to - type string",
			"likes": "// total likes for this comment - type integer",
			"unlikes": "// total unlikes for this comment - type integer",
			"replies": "// total replies for this comment - type integer",
			"commenter": {
				"id": "// UUID of the commenter - type string",
				"username": "// username - type string",
				"avatar_url": "// type string"
			}
		}
	],
	"cacher": {
		"id": "// UUID of the cacher - type string",
		"username": "// username - type string",
		"avatar_url": "// type string"
	}
}
```

#### Update

`PATCH  /api/geo_caches/:id` or `PUT  /api/geo_caches/:id`

request:

```json
{
	"geo_cache": {
		"title": "// type string",
		"message": "// type string",
		"lat": "// latitude - type float",
		"lng": "// longitude - type float"
	}
}
```

response:

```json
{
	"id": "// UUID - type string",
	"title": "// title - type string",
	"message": "// message - type string",
	"lat": "// latitude - type float",
	"lng": "// longitude - type float",
	"likes": "// total likes for this cache - type integer",
	"unlikes": "// total unlikes for this cache - type integer",
	"comments": [
		{
			"id": "// UUID - type string",
			"comment": "// comment - type string",
			"geo_cache_id": "// UUID of the geocache that this comment belongs to - type string",
			"likes": "// total likes for this comment - type integer",
			"unlikes": "// total unlikes for this comment - type integer",
			"replies": "// total replies for this comment - type integer",
			"commenter": {
				"id": "// UUID of the commenter - type string",
				"username": "// username - type string",
				"avatar_url": "// type string"
			}
		}
	],
	"cacher": {
		"id": "// UUID of the cacher - type string",
		"username": "// username - type string",
		"avatar_url": "// type string"
	}
}
```

#### Delete

`DELETE /api/geo_caches/:id`

request:

```json
{}
```

response:
```json
{}
```

#### Like

`POST   /api/geo_caches/:geo_cach_id/like`

request:

```json
{}
```

response:

```json
{}
```

#### Unlike

`POST   /api/geo_caches/:geo_cach_id/unlike`

request:

```json
{}
```

response:

```json
{}
```

#### Reactions

This endpoint uses [ransack](https://github.com/activerecord-hackery/ransack) to filter the results and [will_paginate](https://github.com/mislav/will_paginate) for pagination.

`GET    /api/geo_caches/:geo_cach_id/reactions`

request:

```json
{}
```

response:

```json
[
	{
		"id": "// UUID",
		"reaction": "// like or unlike - type string",
		"reactor": {
			"id": "// UUID of reactor",
			"username": "// username - type string",
			"avatar_url": "// type string"
		}
	}
]
```

### Comments

#### Show

`GET    /api/geo_caches/:geo_cach_id/comments/:id`

request:

```json
{}
```

response:

```json
{
	"id": "// UUID - type string",
	"comment": "// comment - type string",
	"geo_cache_id": "// UUID of the geocache that this comment belongs to - type string",
	"likes": "// total likes for this comment - type integer",
	"unlikes": "// total unlikes for this comment - type integer",
	"replies": [
		{
			"id": "// UUID - type string",
			"reply": "// comment - type string",
			"comment_id": "// UUID of the comment that this reply belongs to - type string",
			"likes": "// total likes for this reply - type integer",
			"unlikes": "// total unlikes for this reply - type integer",
			"sender": {
				"id": "// UUID of the sender - type string",
				"username": "// username - type string",
				"avatar_url": "// type string"
			}
		}
	],
	"commenter": {
		"id": "// UUID of the commenter - type string",
		"username": "// username - type string",
		"avatar_url": "// type string"
	}
}
```

#### Create

`POST   /api/geo_caches/:geo_cach_id/comments`

request:

```json
{
	"comment": {
		"comment": "// type string"
	}
}
```

response:

```json
{
	"id": "// UUID - type string",
	"comment": "// comment - type string",
	"geo_cache_id": "// UUID of the geocache that this comment belongs to - type string",
	"likes": "// total likes for this comment - type integer",
	"unlikes": "// total unlikes for this comment - type integer",
	"replies": "// total replies for this comment - type integer",
	"commenter": {
		"id": "// UUID of the commenter - type string",
		"username": "// username - type string",
		"avatar_url": "// type string"
	}
}
```

#### Update

`PATCH  /api/geo_caches/:geo_cach_id/comments/:id` or `PUT  /api/geo_caches/:geo_cach_id/comments/:id`

request:

```json
{
	"comment": {
		"comment": "// type string"
	}
}
```

response:

```json
{
	"id": "// UUID - type string",
	"comment": "// comment - type string",
	"geo_cache_id": "// UUID of the geocache that this comment belongs to - type string",
	"likes": "// total likes for this comment - type integer",
	"unlikes": "// total unlikes for this comment - type integer",
	"replies": "// total replies for this comment - type integer",
	"commenter": {
		"id": "// UUID of the commenter - type string",
		"username": "// username - type string",
		"avatar_url": "// type string"
	}
}
```

#### Delete

`DELETE /api/geo_caches/:geo_cach_id/comments/:id`

request:

```json
{}
```

response:

```json
{}
```

#### Like

`POST   /api/comments/:comment_id/like`

request:

```json
{}
```

response:

```json
{}
```

#### Unlike

`POST   /api/comments/:comment_id/unlike`

request:

```json
{}
```

response:

```json
{}
```

#### Reactions

This endpoint uses [ransack](https://github.com/activerecord-hackery/ransack) to filter the results and [will_paginate](https://github.com/mislav/will_paginate) for pagination.

`GET    /api/comments/:comment_id/reactions`

request:

```json
{}
```

response:

```json
[
	{
		"id": "// UUID",
		"reaction": "// like or unlike - type string",
		"reactor": {
			"id": "// UUID of reactor",
			"username": "// username - type string",
			"avatar_url": "// type string"
		}
	}
]
```

### Replies

#### Show

`GET    /api/comments/:comment_id/replies/:id`

request:

```json
{}
```

response:

```json
{
	"id": "// UUID - type string",
	"reply": "// comment - type string",
	"comment_id": "// UUID of the comment that this reply belongs to - type string",
	"likes": "// total likes for this reply - type integer",
	"unlikes": "// total unlikes for this reply - type integer",
	"sender": {
		"id": "// UUID of the sender - type string",
		"username": "// username - type string",
		"avatar_url": "// type string"
	}
}
```

#### Create

`POST   /api/comments/:comment_id/replies`

request:

```json
{
	"reply": {
		"reply": "// type string"
	}
}
```

response:

```json
{
	"id": "// UUID - type string",
	"reply": "// comment - type string",
	"comment_id": "// UUID of the comment that this reply belongs to - type string",
	"likes": "// total likes for this reply - type integer",
	"unlikes": "// total unlikes for this reply - type integer",
	"sender": {
		"id": "// UUID of the sender - type string",
		"username": "// username - type string",
		"avatar_url": "// type string"
	}
}
```

#### Update

`PATCH  /api/comments/:comment_id/replies/:id` or `PUT    /api/comments/:comment_id/replies/:id`

request:

```json
{
	"reply": {
		"reply": "// type string"
	}
}
```

response:

```json
{
	"id": "// UUID - type string",
	"reply": "// comment - type string",
	"comment_id": "// UUID of the comment that this reply belongs to - type string",
	"likes": "// total likes for this reply - type integer",
	"unlikes": "// total unlikes for this reply - type integer",
	"sender": {
		"id": "// UUID of the sender - type string",
		"username": "// username - type string",
		"avatar_url": "// type string"
	}
}
```

#### Delete

`DELETE /api/comments/:comment_id/replies/:id`

request:

```json
{}
```

response:

```json
{}
```

#### Like

`POST   /api/replies/:reply_id/like`

request:

```json
{}
```

response:

```json
{}
```

#### Unlike

`POST   /api/replies/:reply_id/unlike`

request:

```json
{}
```

response:

```json
{}
```

#### Reactions

This endpoint uses [ransack](https://github.com/activerecord-hackery/ransack) to filter the results and [will_paginate](https://github.com/mislav/will_paginate) for pagination.

`GET    /api/replies/:reply_id/reactions`

request:

```json
{}
```

response:

```json
[
	{
		"id": "// UUID",
		"reaction": "// like or unlike - type string",
		"reactor": {
			"id": "// UUID of reactor",
			"username": "// username - type string",
			"avatar_url": "// type string"
		}
	}
]
```

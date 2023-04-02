# Sleep Tracker API

The Sleep Tracker API allows users to track their sleep records and follow other users to see their friends' sleep records.

## Endpoints

### Users

- `POST /users`: Create a new user
  - Params: `name` (required)

- `GET /users/:id`: Get a user's information
  - Params: `id` (required)

- `GET /users/:id/followers`: Get a list of a user's followers
  - Params: `id` (required)

- `GET /users/:id/following`: Get a list of users the specified user is following
  - Params: `id` (required)

- `GET /users/:id/friends_sleep_records`: Get sleep records of a user's friends (mutual followers) from the past week
  - Params: `id` (required)

### Sleep Records

- `POST /users/:user_id/sleep_records`: Create a new sleep record for a user
  - Params: `user_id` (required), `start_time` (required), `end_time` (required)

- `GET /users/:user_id/sleep_records`: Get a list of a user's sleep records, ordered by start_time in descending order
  - Params: `user_id` (required)

### Relationships

- `POST /relationships`: Create a new relationship (follow a user)
  - Params: `id` (required), `followed_id` (required)
  - Note:id stands for follower's id

- `DELETE /relationships/:id`: Destroy a relationship (unfollow a user)
  - Params: `id` (required), `followed_id` (required)
  - Note:id stands for follower's id
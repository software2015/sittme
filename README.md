# Sittme

### Route to create babysitter
Post first_name and last_name to localhost:3000/api/v1/babysitters. last_name is optional, first_name is requred.

### Route to pagination
Get localhost:3000/api/v1/babysitters?end_cursor=50&direction=forward
localhost:3000/api/v1/babysitters?start_cursor=50&direction=backward

direction is the direction from cursor, it can be forward and backward.
end_cursor is the id of the last babysitter in array of paginated babysitters,
start_cursor is the id of the first babysitter in array of paginated babysitters

Use end_cursor with direction=forward and start_cursor with direction=backward
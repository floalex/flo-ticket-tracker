# README

* Boostrap modal used for comment#edit
  - https://coderwall.com/p/ej0mhg/open-a-rails-form-with-twitter-bootstrap-modals
  - Need to take out the class "hide" in tickets/show div id="modal-window" in order to show the modal

* Optimize Tags Index
  - If use Tag.all:
    Server returns:
    ```
    Processing by TagsController#index as HTML
   (0.3ms)  SELECT COUNT(*) FROM "tags"
    Tag Load (8.3ms)  SELECT "tags".* FROM "tags"  ORDER BY tags.name ASC
   (0.2ms)  SELECT COUNT(*) FROM "tickets" INNER JOIN "taggings" ON "tickets"."id" = "taggings"."ticket_id" WHERE "taggings"."tag_id" = $1  [["tag_id", 3]]
   (0.1ms)  SELECT COUNT(*) FROM "tickets" INNER JOIN "taggings" ON "tickets"."id" = "taggings"."ticket_id" WHERE "taggings"."tag_id" = $1  [["tag_id", 4]]
   (0.2ms)  SELECT COUNT(*) FROM "tickets" INNER JOIN "taggings" ON "tickets"."id" = "taggings"."ticket_id" WHERE "taggings"."tag_id" = $1  [["tag_id", 5]]
   (0.1ms)  SELECT COUNT(*) FROM "tickets" INNER JOIN "taggings" ON "tickets"."id" = "taggings"."ticket_id" WHERE "taggings"."tag_id" = $1  [["tag_id", 6]]
   (0.1ms)  SELECT COUNT(*) FROM "tickets" INNER JOIN "taggings" ON "tickets"."id" = "taggings"."ticket_id" WHERE "taggings"."tag_id" = $1  [["tag_id", 7]]
   (0.1ms)  SELECT COUNT(*) FROM "tickets" INNER JOIN "taggings" ON "tickets"."id" = "taggings"."ticket_id" WHERE "taggings"."tag_id" = $1  [["tag_id", 2]]
    Rendered tags/index.html.erb within layouts/application (20.6ms)
    User Load (0.4ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = $1 LIMIT 1  [["id", 1]]
    ```
  
  - With count scope: `Tag.with_counts.alphabetical`: returns the tags and their usage counts with "left join"
  - Tag load time significantly reduced from 8.3ms to 0.5ms
    From server:
    ```
    (0.6ms)  SELECT COUNT(*) AS count_all, tags.id AS tags_id FROM "tags" LEFT JOIN taggings ON taggings.tag_id = tags.id GROUP BY tags.id  ORDER BY tags.name ASC
    Tag Load (0.5ms)  SELECT tags.*, COUNT(taggings.id) FROM "tags" LEFT JOIN taggings ON taggings.tag_id = tags.id GROUP BY tags.id  ORDER BY tags.name ASC
   (0.2ms)  SELECT COUNT(*) FROM "tickets" INNER JOIN "taggings" ON "tickets"."id" = "taggings"."ticket_id" WHERE "taggings"."tag_id" = $1  [["tag_id", 3]]
   (0.1ms)  SELECT COUNT(*) FROM "tickets" INNER JOIN "taggings" ON "tickets"."id" = "taggings"."ticket_id" WHERE "taggings"."tag_id" = $1  [["tag_id", 4]]
   (0.1ms)  SELECT COUNT(*) FROM "tickets" INNER JOIN "taggings" ON "tickets"."id" = "taggings"."ticket_id" WHERE "taggings"."tag_id" = $1  [["tag_id", 5]]
   (0.1ms)  SELECT COUNT(*) FROM "tickets" INNER JOIN "taggings" ON "tickets"."id" = "taggings"."ticket_id" WHERE "taggings"."tag_id" = $1  [["tag_id", 6]]
   (0.2ms)  SELECT COUNT(*) FROM "tickets" INNER JOIN "taggings" ON "tickets"."id" = "taggings"."ticket_id" WHERE "taggings"."tag_id" = $1  [["tag_id", 7]]
   (0.2ms)  SELECT COUNT(*) FROM "tickets" INNER JOIN "taggings" ON "tickets"."id" = "taggings"."ticket_id" WHERE "taggings"."tag_id" = $1  [["tag_id", 2]]
    Rendered tags/index.html.erb within layouts/application (166.2ms)
    User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = $1 LIMIT 1  [["id", 1]]
   ```
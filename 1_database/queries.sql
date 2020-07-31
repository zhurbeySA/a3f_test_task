-- First query
-- Get users who have more than 5 contacts
SELECT "User"."UserID", COUNT(*) FROM "User"
LEFT JOIN "Relationship"
ON "User"."UserID" = "Relationship"."UserID"
GROUP BY "User"."UserID"
HAVING COUNT(*) >= 5 AND "User"."UserID" IS NOT NULL;

-- Or if we want to get all information about users who have more than 5 contacts
SELECT * FROM "User" WHERE "UserID" IN (
    SELECT "Relationship"."UserID" FROM "User"
    LEFT JOIN "Relationship"
    ON "User"."UserID" = "Relationship"."UserID"
    GROUP BY "Relationship"."UserID"
    HAVING COUNT(*) >= 5 AND "Relationship"."UserID" IS NOT NULL
);



-- Second query
-- Get all ID pairs of contacts without duplicates
SELECT "OuterTable"."UserID", "OuterTable"."FriendID"
FROM "Relationship" AS "OuterTable"
WHERE "OuterTable"."UserID" IN (
    SELECT "FriendID" FROM "Relationship"
    WHERE "UserID" = "OuterTable"."FriendID"
) AND "OuterTable"."UserID" < "OuterTable"."FriendID";

-- If we want to get this list with names instead of ID's we create new function:
CREATE OR REPLACE FUNCTION get_name_by_id(int) RETURNS varchar
AS $$
BEGIN
    RETURN (SELECT "Name" FROM "User" WHERE "UserID" = $1);
END;
$$ LANGUAGE plpgsql;

-- And use it with previous query:
SELECT get_name_by_id("OuterTable"."UserID"), get_name_by_id("OuterTable"."FriendID")
FROM "Relationship" AS "OuterTable"
WHERE "OuterTable"."UserID" IN (
    SELECT "FriendID" FROM "Relationship"
    WHERE "UserID" = "OuterTable"."FriendID"
) AND "OuterTable"."UserID" < "OuterTable"."FriendID";

-- Quotes are necessary to save case of chars in names
CREATE TABLE "User" (
    "UserID" SERIAL UNIQUE,
    "Name" varchar(64) NOT NULL
);

-- UserID - id of user who an entry related to. User -> Relationship - 1 to many.
-- FriendID is a friend of UserID, not necessary the same in reverse
CREATE TABLE "Relationship" (
    "RelID" SERIAL UNIQUE,
    "UserID" int NOT NULL REFERENCES "User" ("UserID") ON DELETE CASCADE,
    "FriendID" int NOT NULL REFERENCES  "User" ("UserID") ON DELETE CASCADE
        CHECK ("FriendID" <> "UserID"), -- Can't be friend of yourself
    UNIQUE ("UserID", "FriendID") -- No repetitions of the same line
);



-- Insert data for testing
INSERT INTO "User" ("Name") VALUES ('Name1');
INSERT INTO "User" ("Name") VALUES ('Name2');
INSERT INTO "User" ("Name") VALUES ('Name3');
INSERT INTO "User" ("Name") VALUES ('Name4');
INSERT INTO "User" ("Name") VALUES ('Name5');
INSERT INTO "User" ("Name") VALUES ('Name6');
INSERT INTO "User" ("Name") VALUES ('Name7');
INSERT INTO "User" ("Name") VALUES ('Name8');

INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (1, 2);
INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (1, 3);
INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (1, 4);
INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (1, 5);
INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (1, 6);
INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (2, 3);
INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (2, 1);
INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (3, 2);
INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (7, 1);
INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (7, 5);
INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (7, 6);
INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (7, 8);
INSERT INTO "Relationship" ("UserID", "FriendID") VALUES (7, 2);

-- Create database
CREATE DATABASE "datingDB"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Create tables
CREATE TABLE IF NOT EXISTS public.my_contacts
(
    contact_id bigserial,
    last_name character varying(50),
    first_name character varying(50),
    phone bigint,
    email character varying,
    gender character varying(20),
    birthday date,
    prof_id integer,
    zip_code bigint,
    status_id integer,
    PRIMARY KEY (contact_id)
);

CREATE TABLE IF NOT EXISTS public.profession
(
    prof_id bigserial,
    profession character varying(50),
    PRIMARY KEY (prof_id),
    UNIQUE (profession)
);

CREATE TABLE IF NOT EXISTS public.status
(
    status_id bigserial,
    status character varying(50),
    PRIMARY KEY (status_id)
);

CREATE TABLE IF NOT EXISTS public.zip_code
(
    zip_code bigint,
    city character varying(50),
    province character varying(70),
    PRIMARY KEY (zip_code)
);

-- Zip code limit to 4
ALTER TABLE zip_code
ADD CONSTRAINT limit_zip_zode
CHECK (LENGTH(CAST(zip_code AS TEXT)) <= 4);

CREATE TABLE IF NOT EXISTS public.interests
(
    interest_id bigserial,
    interest character varying(50),
    PRIMARY KEY (interest_id)
);

CREATE TABLE IF NOT EXISTS public.seeking
(
    seeking_id bigserial,
    seeking character varying(50),
    PRIMARY KEY (seeking_id)
);

CREATE TABLE IF NOT EXISTS public.contacts_interests
(
    my_contacts_contact_id integer,
    interests_interest_id integer
);

CREATE TABLE IF NOT EXISTS public.contact_seeking
(
    my_contacts_contact_id integer,
    seeking_seeking_id integer
);

ALTER TABLE IF EXISTS public.my_contacts
    ADD FOREIGN KEY (prof_id)
    REFERENCES public.profession (prof_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.my_contacts
    ADD FOREIGN KEY (zip_code)
    REFERENCES public.zip_code (zip_code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.my_contacts
    ADD FOREIGN KEY (status_id)
    REFERENCES public.status (status_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.contacts_interests
    ADD FOREIGN KEY (my_contacts_contact_id)
    REFERENCES public.my_contacts (contact_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.contacts_interests
    ADD FOREIGN KEY (interests_interest_id)
    REFERENCES public.interests (interest_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.contact_seeking
    ADD FOREIGN KEY (my_contacts_contact_id)
    REFERENCES public.my_contacts (contact_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.contact_seeking
    ADD FOREIGN KEY (seeking_seeking_id)
    REFERENCES public.seeking (seeking_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

-- Insert data
-- Zip code
INSERT INTO zip_code(zip_code, city, province)
VALUES  (1431, 'Katlehong', 'Gauteng'),
        (1475, 'Vosloorus','Gauteng'),
        (1234, 'Bhisho', 'Eastern Cape'),
        (1235, 'Gqeberha','Eastern Cape'),
        (1236, 'Bloemfontein', 'Free State'),
        (1237, 'Bethlehem','Free State'),
        (1238, 'Durban', 'KwaZulu-Natal'),
        (1239, 'Pietermaritzburg','KwaZulu-Natal'),
        (1240, 'Jane Furse', 'Limpopo'),
        (1241, 'Polokwane','Limpopo'),
        (1242, 'Nelspruit', 'Mpumalanga'),
        (1243, 'Mbombela','Mpumalanga'),
        (1244, 'Kimberley', 'Northen Cape'),
        (1245, 'Upington','Northen Cape'),
        (1246, 'Mafikeng', 'North West'),
        (1247, 'Vaal','North West'),
        (1248, 'Cape Town', 'Western Cape'),
        (1249, 'George','Western Cape');

-- Profession
INSERT INTO profession(profession)
VALUES  ('Farmer'),
        ('Web Dev'),
        ('Accountant'),
        ('Doctor'),
        ('Unemployed'),
        ('Student'),
        ('Miner'),
        ('Teacher');

-- Status
INSERT INTO status(status)
VALUES  ('Single'),
        ('Married'),
        ('Complicated'),
        ('In a relationship'),
        ('In an open relationship');

-- Interests
INSERT INTO interests(interest)
VALUES  ('Gaming'),
        ('Football'),
        ('Movies'),
        ('Drifting'),
        ('Racing'),
        ('Travelling'),
        ('Coding'),
        ('Music'),
        ('Guitar'),
        ('Cooking'),
        ('Driving'),
        ('Jogging'),
        ('Anime');

-- Seeking
INSERT INTO seeking(seeking)
VALUES  ('Relationship'),
        ('Marriage'),
        ('Friendship'),
        ('Open relationship');

-- My contacts
INSERT INTO my_contacts(last_name, first_name, phone, email, gender, birthday, prof_id, zip_code, status_id)
VALUES  ('Maredi', 'Katlego', 0123456789, 'Katlego@gmail.com', 'Male', '2001-12-09', 11, 1431, 16),
        ('Wildheart', 'Kristine', 1234567890, 'Kristine@gmail.com', 'Female', '2001-11-09', 13, 1475, 18),
        ('Fez', 'Fezao', 0112233445, 'Fez@gmail.com', 'Male', '2001-07-16', 10, 1234, 17),
        ('Markus', 'Chanelle', 0123556789, 'Chanelle@gmail.com', 'Female', '2001-07-16', 15, 1242, 19),
        ('Perish', 'Leslie', 0123452789, 'Les@gmail.com', 'Female', '1997-12-09', 17, 1246, 20),
        ('Whip', 'Mally', 0223456789, 'Mally@gmail.com', 'Female', '2001-12-09', 14, 1248, 16),
        ('Young', 'Eric', 0123450789, 'Eric@gmail.com', 'Male', '1999-12-09', 12, 1249, 20),
        ('Wright', 'Eric', 0123456989, 'Rick@gmail.com', 'Male', '1964-09-21', 10, 1247, 20),
        ('Young', 'Andre', 0123456289, 'Dre@gmail.com', 'Male', '1964-12-09', 13, 1246, 18),
        ('Cube', 'Ice', 0123356789, 'Ice@gmail.com', 'Male', '1999-12-09', 11, 1245, 16),
        ('Lewis', 'Jerry', 0123454789, 'JerryLL@gmail.com', 'Male', '1935-11-09', 11, 1244, 18),
        ('Ifrica', 'Queen', 0123453789, 'Queen@gmail.com', 'Female', '1979-12-09', 14, 1243, 20),
        ('Young', 'Forever', 0123456689, 'Forever@gmail.com', 'Female', '1956-12-09', 15, 1234, 16),
        ('Rise', 'Capleton', 0122456789, 'Capleton@gmail.com', 'Male', '1948-12-12', 16, 1235, 17),
        ('B', 'Bonnie', 0123656789, 'Bonnie@gmail.com', 'Female', '2001-03-09', 17, 1236, 16),
        ('Rhapsody', 'Bohemian', 0113456789, 'Bohemian@gmail.com', 'Male', '2005-12-09', 12, 1237, 20),
        ('Aspire', 'Eve', 1123456789, 'Eve@gmail.com', 'Female', '1973-12-09', 13, 1238, 16),
        ('Asus', 'Whitney', 0123406789, 'Asus@gmail.com', 'Female', '2001-12-09', 11, 1239, 16),
        ('Queenie', 'Little', 0124456789, 'Queenie@gmail.com', 'Female', '2002-07-09', 15, 1240, 18),
        ('Done', 'Finally', 0123156789, 'Done@gmail.com', 'Male', '2004-11-09', 16, 1241, 16);

-- Contact's interest
INSERT INTO contacts_interests(my_contacts_contact_id, interests_interest_id)
VALUES  (1, 1),
        (1, 13),
        (1, 7),
        (1, 4),
        (2, 13),
        (2, 12),
        (2, 11),
        (3, 12),
        (3, 1),
        (3, 2),
        (4, 2),
        (4, 3),
        (4, 4),
        (5, 4),
        (5, 6),
        (5, 7),
        (6, 5),
        (6, 6),
        (6, 7),
        (7, 8),
        (7, 9),
        (7, 10),
        (8, 11),
        (8, 10),
        (8, 11),
        (9, 12),
        (9, 13),
        (9, 1),
        (10, 1),
        (10, 2),
        (10, 3),
        (10, 4),
        (10, 5),
        (11, 6),
        (11, 7),
        (11, 8),
        (12, 9),
        (12, 10),
        (12, 11),
        (13, 12),
        (13, 10),
        (13, 12),
        (14, 11),
        (14, 12),
        (14, 13),
        (15, 1),
        (15, 2),
        (15, 3),
        (16, 2),
        (16, 4),
        (16, 5),
        (17, 6),
        (17, 7),
        (17, 8),
        (18, 9),
        (18, 10),
        (18, 11),
        (19, 10),
        (19, 11),
        (19, 12),
        (20, 13),
        (20, 1),
        (20, 2),
        (20, 3);

-- contact_seeking
INSERT INTO contact_seeking(my_contacts_contact_id, seeking_seeking_id)
VALUES  (1, 1),
        (2, 2),
        (3, 3),
        (4, 4),
        (5, 1),
        (6, 2),
        (7, 3),
        (8, 4),
        (9, 1),
        (10, 2),
        (11, 3),
        (12, 4),
        (13, 1),
        (14, 2),
        (15, 3),
        (16, 4),
        (17, 1),
        (18, 2),
        (19, 3),
        (20, 4);

-- A LEFT JOIN query that will display the profession, zip_code (postal_code, city and province), status, interests and seeking.
SELECT profession.profession, zip_code.zip_code, zip_code.city, zip_code.province, status.status, interests.interest, seeking.seeking
FROM my_contacts
LEFT JOIN profession
ON my_contacts.prof_id = profession.prof_id
LEFT JOIN zip_code
ON my_contacts.zip_code = zip_code.zip_code
LEFT JOIN status
ON my_contacts.status_id = status.status_id
LEFT JOIN contacts_interests
ON my_contacts.contact_id = contacts_interests.my_contacts_contact_id 
LEFT JOIN interests
ON interests.interest_id = contacts_interests.interests_interest_id
LEFT JOIN contact_seeking
ON my_contacts.contact_id = contact_seeking.my_contacts_contact_id 
LEFT JOIN seeking
ON seeking.seeking_id = contact_seeking.seeking_seeking_id
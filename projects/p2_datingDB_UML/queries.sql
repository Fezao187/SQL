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
    interest boolean,
    PRIMARY KEY (interest_id)
);

CREATE TABLE IF NOT EXISTS public.seeking
(
    seeking_id bigserial,
    seeking boolean,
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

-- Add foreign keys
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
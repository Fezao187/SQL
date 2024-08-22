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
    zip_code bigint CHECK (zip_code <= 4), --Check constraint
    city character varying(50),
    province character varying(70),
    PRIMARY KEY (zip_code)
);

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
    contact_id integer,
    seeking_id integer
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
    ADD FOREIGN KEY (contact_id)
    REFERENCES public.my_contacts (contact_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.contact_seeking
    ADD FOREIGN KEY (seeking_id)
    REFERENCES public.seeking (seeking_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
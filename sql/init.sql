--DROP DATABASE IF EXISTS djangoapp;
--CREATE DATABASE IF NOT EXISTS djangoapp;
CREATE DATABASE djangoapp;

\c djangoapp

--DROP TABLE IF EXISTS public.greetings_words

CREATE TABLE IF NOT EXISTS public.greetings_words
(
    --id bigint NOT NULL,
    id serial PRIMARY KEY,
    lang VARCHAR(3) COLLATE pg_catalog."default" NOT NULL,
    word VARCHAR(50) COLLATE pg_catalog."default" NOT NULL
    --CONSTRAINT greetings_words_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.greetings_words
    OWNER to postgres;

--INSERT INTO greetings_words (id, lang, word) values (1, 'ENG', 'hello'), (2, 'RUS', 'привет');

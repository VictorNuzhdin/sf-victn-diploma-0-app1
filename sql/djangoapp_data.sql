--Recreates Table [greetings_words] and TOTALLY refresh DATA
/*
DROP TABLE IF EXISTS public.greetings_words;

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
*/

--id filed is not needed in SQL query, cause that field is PrimaryKey (PK) and AutoIncrement and has "serial" type
--*INSERT INTO greetings_words (id, lang, word) ..

--Injects NEW data
INSERT INTO greetings_words (lang, word)
	 values ('ENG', 'hello'),
			('FRA', 'bonjour'),
			('ESP', 'hola'),
			('ITA', 'ciao'),
			('DEU', 'hallo'),
			('UKR', 'вітаю'),
			('BLR', 'прывітанне'),
			('RUS', 'привет'),
			('JPN', 'こんにちは'),
			('CHN', '你好'),
			('KOR', '안녕하세요');

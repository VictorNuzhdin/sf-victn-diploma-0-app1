--NOTES:
--1. the database [djangoapp] is created at PostgreSQL level
--   * with "sql/init.sql" script
--   * when PotgreSQL first start
--
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

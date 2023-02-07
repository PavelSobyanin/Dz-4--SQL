CREATE TABLE IF NOT EXISTS artists (
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS genres (
	id SERIAL PRIMARY KEY,	
	name VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS artists_genres (
	artist INTEGER REFERENCES artists,
	genre INTEGER REFERENCES genres,
	constraint pk_artists_genres PRIMARY KEY (artist, genre)
);

CREATE TABLE IF NOT EXISTS albums (	
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL UNIQUE,
	year INTEGER 
);

CREATE TABLE IF NOT EXISTS albums_artists (
	artist INTEGER REFERENCES artists,
	album INTEGER REFERENCES albums,
	constraint pk_albums_artists PRIMARY KEY (artist, album)
);

CREATE TABLE IF NOT EXISTS tracks (
	id SERIAL PRIMARY KEY,
	album INTEGER REFERENCES albums,
	name VARCHAR(80) NOT NULL,
	length TIME NOT NULL,
	constraint pk_tracks UNIQUE (name, album)
);

CREATE TABLE IF NOT EXISTS collections (	
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL,
	Year INTEGER 
);

CREATE TABLE IF NOT EXISTS collections_tracks (
	collection INTEGER REFERENCES collections,
	track INTEGER REFERENCES tracks,
	constraint pk_collections_tracks PRIMARY KEY (collection, track)
);
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bible_verses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bible_verses (
    id bigint NOT NULL,
    biblebook_id bigint,
    chapter_nr integer,
    verse_nr integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bible_verses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bible_verses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bible_verses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bible_verses_id_seq OWNED BY bible_verses.id;


--
-- Name: biblebooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE biblebooks (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    booksequence integer,
    testament character varying,
    abbreviation character varying,
    bible_verse_id bigint
);


--
-- Name: biblebooks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE biblebooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: biblebooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE biblebooks_id_seq OWNED BY biblebooks.id;


--
-- Name: chapters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE chapters (
    id integer NOT NULL,
    chapter_number integer,
    description character varying,
    biblebook_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    nrofverses integer
);


--
-- Name: chapters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE chapters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chapters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE chapters_id_seq OWNED BY chapters.id;


--
-- Name: pericope_as_ranges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pericope_as_ranges (
    id bigint NOT NULL,
    name character varying,
    starting_verse_id bigint,
    ending_verse_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pericope_as_ranges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pericope_as_ranges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pericope_as_ranges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pericope_as_ranges_id_seq OWNED BY pericope_as_ranges.id;


--
-- Name: pericopes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pericopes (
    id integer NOT NULL,
    studynote_id integer,
    starting_verse integer,
    ending_verse integer,
    biblebook_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying,
    ending_chapter_nr integer,
    starting_chapter_nr integer,
    biblebook_name character varying,
    sequence integer,
    starting_verse_id integer,
    ending_verse_id integer
);


--
-- Name: pericopes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pericopes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pericopes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pericopes_id_seq OWNED BY pericopes.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE roles (
    id integer NOT NULL,
    user_id integer,
    role character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    studynote_id bigint
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: studynotes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE studynotes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title character varying,
    author_id integer
);


--
-- Name: studynotes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE studynotes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: studynotes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE studynotes_id_seq OWNED BY studynotes.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    admin boolean DEFAULT false,
    username character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: bible_verses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bible_verses ALTER COLUMN id SET DEFAULT nextval('bible_verses_id_seq'::regclass);


--
-- Name: biblebooks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY biblebooks ALTER COLUMN id SET DEFAULT nextval('biblebooks_id_seq'::regclass);


--
-- Name: chapters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY chapters ALTER COLUMN id SET DEFAULT nextval('chapters_id_seq'::regclass);


--
-- Name: pericope_as_ranges id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pericope_as_ranges ALTER COLUMN id SET DEFAULT nextval('pericope_as_ranges_id_seq'::regclass);


--
-- Name: pericopes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pericopes ALTER COLUMN id SET DEFAULT nextval('pericopes_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: studynotes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY studynotes ALTER COLUMN id SET DEFAULT nextval('studynotes_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: bible_verses bible_verses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bible_verses
    ADD CONSTRAINT bible_verses_pkey PRIMARY KEY (id);


--
-- Name: biblebooks biblebooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY biblebooks
    ADD CONSTRAINT biblebooks_pkey PRIMARY KEY (id);


--
-- Name: chapters chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chapters
    ADD CONSTRAINT chapters_pkey PRIMARY KEY (id);


--
-- Name: pericope_as_ranges pericope_as_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pericope_as_ranges
    ADD CONSTRAINT pericope_as_ranges_pkey PRIMARY KEY (id);


--
-- Name: pericopes pericopes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pericopes
    ADD CONSTRAINT pericopes_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: studynotes studynotes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY studynotes
    ADD CONSTRAINT studynotes_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_bible_verses_on_biblebook_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bible_verses_on_biblebook_id ON bible_verses USING btree (biblebook_id);


--
-- Name: index_chapters_on_biblebook_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_chapters_on_biblebook_id ON chapters USING btree (biblebook_id);


--
-- Name: index_pericope_as_ranges_on_ending_verse_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pericope_as_ranges_on_ending_verse_id ON pericope_as_ranges USING btree (ending_verse_id);


--
-- Name: index_pericope_as_ranges_on_starting_verse_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pericope_as_ranges_on_starting_verse_id ON pericope_as_ranges USING btree (starting_verse_id);


--
-- Name: index_pericopes_on_biblebook_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pericopes_on_biblebook_id ON pericopes USING btree (biblebook_id);


--
-- Name: index_pericopes_on_studynote_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pericopes_on_studynote_id ON pericopes USING btree (studynote_id);


--
-- Name: index_roles_on_studynote_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_studynote_id ON roles USING btree (studynote_id);


--
-- Name: index_roles_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_user_id ON roles USING btree (user_id);


--
-- Name: index_studynotes_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_studynotes_on_author_id ON studynotes USING btree (author_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: pericope_as_ranges fk_rails_1fb7dc670f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pericope_as_ranges
    ADD CONSTRAINT fk_rails_1fb7dc670f FOREIGN KEY (starting_verse_id) REFERENCES bible_verses(id);


--
-- Name: pericopes fk_rails_2346317ca8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pericopes
    ADD CONSTRAINT fk_rails_2346317ca8 FOREIGN KEY (biblebook_id) REFERENCES biblebooks(id);


--
-- Name: roles fk_rails_3081f4c8c8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT fk_rails_3081f4c8c8 FOREIGN KEY (studynote_id) REFERENCES studynotes(id);


--
-- Name: bible_verses fk_rails_5b7f84edd9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bible_verses
    ADD CONSTRAINT fk_rails_5b7f84edd9 FOREIGN KEY (biblebook_id) REFERENCES biblebooks(id);


--
-- Name: chapters fk_rails_63a8dc128c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chapters
    ADD CONSTRAINT fk_rails_63a8dc128c FOREIGN KEY (biblebook_id) REFERENCES biblebooks(id);


--
-- Name: studynotes fk_rails_6d80886104; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY studynotes
    ADD CONSTRAINT fk_rails_6d80886104 FOREIGN KEY (author_id) REFERENCES users(id);


--
-- Name: roles fk_rails_ab35d699f0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT fk_rails_ab35d699f0 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: pericopes fk_rails_dc13300de2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pericopes
    ADD CONSTRAINT fk_rails_dc13300de2 FOREIGN KEY (studynote_id) REFERENCES studynotes(id);


--
-- Name: pericope_as_ranges fk_rails_eeafde9249; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pericope_as_ranges
    ADD CONSTRAINT fk_rails_eeafde9249 FOREIGN KEY (ending_verse_id) REFERENCES bible_verses(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20160708081949'),
('20160805130602'),
('20160805172534'),
('20160805201940'),
('20160805202029'),
('20160805202938'),
('20160805203057'),
('20160805204355'),
('20160807195509'),
('20160809191633'),
('20160816201511'),
('20160817191619'),
('20160821185114'),
('20160829074821'),
('20160829074899'),
('20160829075522'),
('20160830044019'),
('20160831074151'),
('20160831205219'),
('20160831205249'),
('20160909112552'),
('20160909113737'),
('20161003052316'),
('20161007054135'),
('20161012185857'),
('20161018204911'),
('20161108215333'),
('20161130104008'),
('20170114115435'),
('20171223162059');



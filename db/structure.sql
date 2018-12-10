SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    commenter_id uuid,
    geo_cache_id uuid,
    comment character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    replies_count integer DEFAULT 0,
    likes_count integer DEFAULT 0,
    unlikes_count integer DEFAULT 0
);


--
-- Name: geo_caches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.geo_caches (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    cacher_id uuid,
    message character varying,
    title character varying,
    lat numeric(10,6),
    lng numeric(10,6),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    comments_count integer DEFAULT 0,
    likes_count integer DEFAULT 0,
    unlikes_count integer DEFAULT 0
);


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_access_tokens (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    resource_owner_id uuid,
    application_id uuid,
    token character varying NOT NULL,
    refresh_token character varying,
    expires_in integer,
    revoked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    scopes character varying,
    previous_refresh_token character varying DEFAULT ''::character varying NOT NULL
);


--
-- Name: reactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reactions (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    reactor_id uuid,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    reacted_on_type character varying,
    reacted_on_id uuid,
    reaction integer
);


--
-- Name: replies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.replies (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    comment_id uuid,
    reply character varying,
    sender_id uuid,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    likes_count integer DEFAULT 0,
    unlikes_count integer DEFAULT 0
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
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
    username character varying,
    first_name character varying,
    last_name character varying,
    geo_caches_count integer DEFAULT 0,
    comments_count integer DEFAULT 0,
    replies_count integer DEFAULT 0,
    likes_count integer DEFAULT 0,
    unlikes_count integer DEFAULT 0
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: geo_caches geo_caches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.geo_caches
    ADD CONSTRAINT geo_caches_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: reactions reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT reactions_pkey PRIMARY KEY (id);


--
-- Name: replies replies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies
    ADD CONSTRAINT replies_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_comments_on_commenter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_commenter_id ON public.comments USING btree (commenter_id);


--
-- Name: index_comments_on_geo_cache_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_geo_cache_id ON public.comments USING btree (geo_cache_id);


--
-- Name: index_geo_caches_on_cacher_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_geo_caches_on_cacher_id ON public.geo_caches USING btree (cacher_id);


--
-- Name: index_oauth_access_tokens_on_application_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_access_tokens_on_application_id ON public.oauth_access_tokens USING btree (application_id);


--
-- Name: index_oauth_access_tokens_on_refresh_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_refresh_token ON public.oauth_access_tokens USING btree (refresh_token);


--
-- Name: index_oauth_access_tokens_on_resource_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_access_tokens_on_resource_owner_id ON public.oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: index_oauth_access_tokens_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_token ON public.oauth_access_tokens USING btree (token);


--
-- Name: index_reactions_on_reacted_on_type_and_reacted_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reactions_on_reacted_on_type_and_reacted_on_id ON public.reactions USING btree (reacted_on_type, reacted_on_id);


--
-- Name: index_reactions_on_reactor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reactions_on_reactor_id ON public.reactions USING btree (reactor_id);


--
-- Name: index_replies_on_comment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_replies_on_comment_id ON public.replies USING btree (comment_id);


--
-- Name: index_replies_on_sender_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_replies_on_sender_id ON public.replies USING btree (sender_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: reactions fk_rails_1698478f95; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT fk_rails_1698478f95 FOREIGN KEY (reactor_id) REFERENCES public.users(id);


--
-- Name: comments fk_rails_270a981201; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_270a981201 FOREIGN KEY (geo_cache_id) REFERENCES public.geo_caches(id);


--
-- Name: replies fk_rails_79515c7644; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies
    ADD CONSTRAINT fk_rails_79515c7644 FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: comments fk_rails_7c76e8dc86; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_7c76e8dc86 FOREIGN KEY (commenter_id) REFERENCES public.users(id);


--
-- Name: geo_caches fk_rails_a2f83f4025; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.geo_caches
    ADD CONSTRAINT fk_rails_a2f83f4025 FOREIGN KEY (cacher_id) REFERENCES public.users(id);


--
-- Name: oauth_access_tokens fk_rails_ee63f25419; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT fk_rails_ee63f25419 FOREIGN KEY (resource_owner_id) REFERENCES public.users(id);


--
-- Name: replies fk_rails_f13795d06e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.replies
    ADD CONSTRAINT fk_rails_f13795d06e FOREIGN KEY (comment_id) REFERENCES public.comments(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20181019092142'),
('20181019141031'),
('20181019150055'),
('20181021074309'),
('20181021074430'),
('20181021074505'),
('20181021074551'),
('20181210112418'),
('20181210125241'),
('20181210132153'),
('20181210134802');



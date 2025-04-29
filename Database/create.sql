CREATE TABLE IF NOT EXISTS public.author_comment
(
    author text COLLATE pg_catalog."default",
    date timestamp without time zone,
    comment text COLLATE pg_catalog."default"
)

CREATE TABLE IF NOT EXISTS public.author_company
(
    author character varying(255) COLLATE pg_catalog."default" NOT NULL,
    company character varying(255) COLLATE pg_catalog."default"
)

CREATE TABLE IF NOT EXISTS public.critic
(
    id text COLLATE pg_catalog."default" NOT NULL,
    rating numeric,
    top_critic boolean,
    fk_game_id text COLLATE pg_catalog."default",
    CONSTRAINT critic_pkey PRIMARY KEY (id)
)


CREATE TABLE IF NOT EXISTS public.games
(
    id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    name character varying(255) COLLATE pg_catalog."default",
    game_slug character varying(255) COLLATE pg_catalog."default",
    price integer,
    release_date timestamp without time zone,
    platform character varying(255) COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default",
    developer character varying(255) COLLATE pg_catalog."default",
    publisher character varying(255) COLLATE pg_catalog."default",
    genres character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT games_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.necessary_hardware
(
    id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    operacional_system character varying(255) COLLATE pg_catalog."default",
    processor character varying(255) COLLATE pg_catalog."default",
    memory character varying(255) COLLATE pg_catalog."default",
    graphics character varying(255) COLLATE pg_catalog."default",
    fk_game_id character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT necessary_hardware_pkey PRIMARY KEY (id),
    CONSTRAINT necessary_hardware_fk_game_id_fkey FOREIGN KEY (fk_game_id)
        REFERENCES public.games (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)


CREATE TABLE IF NOT EXISTS public.social_networks
(
    id integer NOT NULL DEFAULT nextval('social_networks_id_seq'::regclass),
    description character varying(255) COLLATE pg_catalog."default",
    url text COLLATE pg_catalog."default",
    fk_game_id character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT social_networks_pkey PRIMARY KEY (id),
    CONSTRAINT social_networks_fk_game_id_fkey FOREIGN KEY (fk_game_id)
        REFERENCES public.games (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.tweets
(
    id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    text text COLLATE pg_catalog."default",
    url_media text COLLATE pg_catalog."default",
    quantity_likes double precision,
    quantity_retweets double precision,
    quantity_quotes character varying(255) COLLATE pg_catalog."default",
    quantity_replys double precision,
    "timestamp" timestamp without time zone,
    twitter_account_id double precision,
    CONSTRAINT tweets_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.tweets_in_reply
(
    id bigint NOT NULL,
    in_reply_to_user_id bigint,
    CONSTRAINT tweets_in_reply_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.twitter_account
(
    id integer NOT NULL,
    name text COLLATE pg_catalog."default",
    username text COLLATE pg_catalog."default",
    bio text COLLATE pg_catalog."default",
    location text COLLATE pg_catalog."default",
    website text COLLATE pg_catalog."default",
    join_date timestamp without time zone,
    following integer,
    followers integer,
    fk_game_id text COLLATE pg_catalog."default",
    CONSTRAINT twitter_account_pkey PRIMARY KEY (id)
)
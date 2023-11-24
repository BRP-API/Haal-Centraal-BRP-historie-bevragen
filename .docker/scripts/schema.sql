--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE haalcentraal;
ALTER ROLE haalcentraal WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION NOBYPASSRLS;
-- CREATE ROLE root;
ALTER ROLE root WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5b4b8daf4b8ea9d39568719e1e320076f';






\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.21
-- Dumped by pg_dump version 11.21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.21
-- Dumped by pg_dump version 11.21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.21
-- Dumped by pg_dump version 11.21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: root; Type: DATABASE; Schema: -; Owner: root
--

-- CREATE DATABASE root WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE root OWNER TO root;

\connect root

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.21
-- Dumped by pg_dump version 11.21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: rvig_haalcentraal_testdata; Type: DATABASE; Schema: -; Owner: haalcentraal
--

CREATE DATABASE rvig_haalcentraal_testdata WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE rvig_haalcentraal_testdata OWNER TO haalcentraal;

\connect rvig_haalcentraal_testdata

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: vospg; Type: SCHEMA; Schema: -; Owner: haalcentraal
--

CREATE SCHEMA vospg;


ALTER SCHEMA vospg OWNER TO haalcentraal;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: contains_special_characters(character varying); Type: FUNCTION; Schema: public; Owner: haalcentraal
--

CREATE FUNCTION public.contains_special_characters(character varying) RETURNS boolean
    LANGUAGE sql
    AS $_$
-- Implementation: replace special characters by an inverted exclamation mark and
--   return true if the translation result contains any of those marks.
select position(E'\xc2\xa1' in translate(
$1,-- search original string

E'\xc2\xa1' ||-- inverted exclamation mark
E'\xc2\xa2' ||-- cent sign
E'\xc2\xa3' ||-- pound sign
E'\xc2\xa5' ||-- yen sign
E'\xc2\xa4' ||-- currency sign
E'\xc2\xab' ||-- angle quotation mark left
E'\xc2\xb0' ||-- degree sign
E'\xc2\xb1' ||-- plus minus sign
E'\xc2\xb2' ||-- superscript 2
E'\xc2\xb3' ||-- superscript 3
E'\xc3\x97' ||-- multiply sign
E'\xc2\xb7' ||-- middle dot
E'\xc3\xb7' ||-- divide sign
E'\xc2\xbb' ||-- angle quotation mark right
E'\xc2\xbc' ||-- fraction one quarter
E'\xc2\xbd' ||-- fraction one half
E'\xc2\xbe' ||-- fraction three quarter
E'\xc2\xbf' ||-- inverted question mark
E'\xe2\x84\xa6' ||-- Ohm sign
E'\xc3\x86' ||-- capital AE diphtong
E'\xc4\x90' ||-- capital D with stroke
E'\xc2\xaa' ||-- ordinal indicator feminine
E'\xc4\xa6' ||-- capital H with stroke
E'\xc4\xbf' ||-- capital L with middle dot
E'\xc5\x81' ||-- capital L with stroke
E'\xc3\x98' ||-- capital O with slash
E'\xc5\x92' ||-- capital OE ligature
E'\xc2\xba' ||-- ordinal indicator masculine
E'\xc3\x9e' ||-- capital thorn, icelandic
E'\xc5\xa6' ||-- capital T with stroke
E'\xc5\x8a' ||-- capital eng, lapp
E'\xc5\x89' ||-- small n with apostrophe
E'\xc4\xb8' ||-- small k, greenlandic
E'\xc3\xa6' ||-- small ae diphtong
E'\xc4\x91' ||-- small d with stroke
E'\xc3\xb0' ||-- small eth, icelandic
E'\xc4\xa7' ||-- small h with stroke
E'\xc4\xb1' ||-- small i without dot
E'\xc5\x80' ||-- small l with middle dot
E'\xc5\x82' ||-- small l with stroke
E'\xc3\xb8' ||-- small o with slash
E'\xc5\x93' ||-- small oe ligature
E'\xc3\x9f' ||-- small sharp s, german
E'\xc3\xbe' ||-- small thorn, icelandic
E'\xc5\xa7' ||-- small t with stroke
E'\xc5\x8b',-- small eng, lapp
E'\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1')) > 0
$_$;


ALTER FUNCTION public.contains_special_characters(character varying) OWNER TO haalcentraal;

--
-- Name: convert_special_characters_to_slim(character varying); Type: FUNCTION; Schema: public; Owner: haalcentraal
--

CREATE FUNCTION public.convert_special_characters_to_slim(character varying) RETURNS character varying
    LANGUAGE sql
    AS $_$
select replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(translate(

-- convert the contents of the input string
$1,

-- from these special characters
E'\xc2\xa1' ||-- inverted exclamation mark
E'\xc2\xa2' ||-- cent sign
E'\xc2\xa3' ||-- pound sign
E'\xc2\xa5' ||-- yen sign
E'\xc2\xa4' ||-- currency sign
E'\xc2\xb0' ||-- degree sign
E'\xc2\xb2' ||-- superscript 2
E'\xc2\xb3' ||-- superscript 3
E'\xc3\x97' ||-- multiply sign
E'\xc2\xb7' ||-- middle dot
E'\xc3\xb7' ||-- divide sign
E'\xc2\xbf' ||-- inverted question mark
E'\xc4\x90' ||-- capital D with stroke
E'\xc2\xaa' ||-- ordinal indicator feminine
E'\xc4\xa6' ||-- capital H with stroke
E'\xc5\x81' ||-- capital L with stroke
E'\xc3\x98' ||-- capital O with slash
E'\xc2\xba' ||-- ordinal indicator masculine
E'\xc5\xa6' ||-- capital T with stroke
E'\xc4\xb8' ||-- small k, greenlandic
E'\xc4\x91' ||-- small d with stroke
E'\xc3\xb0' ||-- small eth, icelandic
E'\xc4\xa7' ||-- small h with stroke
E'\xc4\xb1' ||-- small i without dot
E'\xc5\x82' ||-- small l with stroke
E'\xc3\xb8' ||-- small o with slash
E'\xc5\xa7',-- small t with stroke

-- to a single ASCII-compatible character
'!' ||-- inverted exclamation mark
'c' ||-- cent sign
'L' ||-- pound sign
'Y' ||-- yen sign
'*' ||-- currency sign
'o' ||-- degree sign
'2' ||-- superscript 2
'3' ||-- superscript 3
'x' ||-- multiply sign
'.' ||-- middle dot
':' ||-- divide sign
'?' ||-- inverted question mark
'D' ||-- capital D with stroke
'a' ||-- ordinal indicator feminine
'H' ||-- capital H with stroke
'L' ||-- capital L with stroke
'O' ||-- capital O with slash
'o' ||-- ordinal indicator masculine
'T' ||-- capital T with stroke
'q' ||-- small k, greenlandic
'd' ||-- small d with stroke
'd' ||-- small eth, icelandic
'h' ||-- small h with stroke
'i' ||-- small i without dot
'l' ||-- small l with stroke
'o' ||-- small o with slash
't'),-- small t with stroke

-- and from the other special characters to more than one ASCII-compatible character
E'\xc2\xab', '<<'),-- angle quotation mark left
E'\xc2\xb1', '+/-'),-- plus minus sign
E'\xc2\xbb', '>>'),-- angle quotation mark right
E'\xc2\xbc', '1/4'),-- fraction one quarter
E'\xc2\xbd', '1/2'),-- fraction one half
E'\xc2\xbe', '3/4'),-- fraction three quarter
E'\xe2\x84\xa6', 'Ohm'),-- Ohm sign
E'\xc3\x86', 'AE'),-- capital AE diphtong
E'\xc4\xbf', 'L.'),-- capital L with middle dot
E'\xc5\x92', 'OE'),-- capital OE ligature
E'\xc3\x9e', 'TH'),-- capital thorn, icelandic
E'\xc5\x8a', 'NG'),-- capital eng, lapp
E'\xc5\x89', '''n'),-- small n with apostrophe
E'\xc3\xa6', 'ae'),-- small ae diphtong
E'\xc5\x80', 'l.'),-- small l with middle dot
E'\xc5\x93', 'oe'),-- small oe ligature
E'\xc3\x9f', 'ss'),-- small sharp s, german
E'\xc3\xbe', 'th'),-- small thorn, icelandic
E'\xc5\x8b', 'ng')-- small eng, lapp
$_$;


ALTER FUNCTION public.convert_special_characters_to_slim(character varying) OWNER TO haalcentraal;

--
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: haalcentraal
--

CREATE FUNCTION public.plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO haalcentraal;

--
-- Name: plpgsql_validator(oid); Type: FUNCTION; Schema: public; Owner: haalcentraal
--

CREATE FUNCTION public.plpgsql_validator(oid) RETURNS void
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_validator';


ALTER FUNCTION public.plpgsql_validator(oid) OWNER TO haalcentraal;

--
-- Name: activiteit_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.activiteit_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activiteit_id_sequence OWNER TO haalcentraal;

SET default_tablespace = '';

SET default_with_oids = true;

--
-- Name: activiteit_small; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.activiteit_small (
    activiteit_id bigint NOT NULL,
    activiteit_type integer NOT NULL,
    activiteit_subtype integer NOT NULL,
    moeder_id bigint,
    toestand integer NOT NULL,
    start_dt timestamp without time zone DEFAULT now() NOT NULL,
    laatste_actie_dt timestamp without time zone,
    uiterlijke_actie_dt timestamp without time zone NOT NULL,
    pl_id bigint,
    communicatie_partner character varying(40),
    nr_1 bigint,
    nr_2 bigint,
    nr_3 bigint,
    nr_4 bigint,
    nr_5 bigint,
    tekst_1 character varying(40),
    tekst_2 character varying(40),
    tekst_3 character varying(40),
    tekst_4 character varying(40),
    tekst_5 character varying(40),
    trace_level character(1),
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.activiteit_small OWNER TO haalcentraal;

--
-- Name: adres_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.adres_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adres_id_sequence OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: afnemer; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.afnemer (
    afnemer_id bigint NOT NULL,
    afnemer_code integer NOT NULL,
    geschatte_omvang integer DEFAULT 0 NOT NULL,
    leverwijze integer DEFAULT 0 NOT NULL,
    max_berichten integer DEFAULT 0 NOT NULL,
    berichtsoort integer,
    selectiesoort integer DEFAULT 0 NOT NULL,
    bestands_formaat integer,
    oin character varying(20)
);


ALTER TABLE public.afnemer OWNER TO haalcentraal;

--
-- Name: afnemer_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.afnemer_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.afnemer_id_sequence OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: gebeurtenis_data; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.gebeurtenis_data (
    gebeurtenis_data_id bigint NOT NULL,
    gebeurtenis_data_type integer NOT NULL,
    gebeurtenis_data text,
    gebeurtenis_nr_1 bigint,
    gebeurtenis_nr_2 bigint,
    gebeurtenis_id bigint NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.gebeurtenis_data OWNER TO haalcentraal;

--
-- Name: gebeurtenis_data_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.gebeurtenis_data_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gebeurtenis_data_id_sequence OWNER TO haalcentraal;

--
-- Name: gebeurtenis_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.gebeurtenis_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gebeurtenis_id_sequence OWNER TO haalcentraal;

--
-- Name: gebeurtenis_small; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.gebeurtenis_small (
    gebeurtenis_id bigint NOT NULL,
    gebeurtenis_type integer NOT NULL,
    gebeurtenis_dt timestamp without time zone DEFAULT now() NOT NULL,
    gebeurtenis_oms text,
    activiteit_id bigint NOT NULL,
    activiteit_nieuwe_toestand integer,
    creatie_door character varying(40),
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    gebeurtenis_hash bigint
);


ALTER TABLE public.gebeurtenis_small OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: haalcentraal_vraag; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.haalcentraal_vraag (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE public.haalcentraal_vraag OWNER TO root;

--
-- Name: herindeling; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.herindeling (
    herindeling_id bigint NOT NULL,
    nieuwe_gemeente_code character varying(4) NOT NULL,
    oude_gemeente_codes character varying(400),
    herindeling_datum integer NOT NULL,
    volg_nr integer NOT NULL,
    verstrekking_start_datum integer NOT NULL,
    verstrekking_eind_datum integer NOT NULL,
    afnemers_am_verstrekkingen text,
    afnemers_niet_verstrekkingen text,
    toelichting text,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT herindeling_check CHECK (((herindeling_datum >= verstrekking_start_datum) AND (herindeling_datum <= verstrekking_eind_datum))),
    CONSTRAINT herindeling_check1 CHECK ((verstrekking_eind_datum >= verstrekking_start_datum)),
    CONSTRAINT herindeling_nieuwe_gemeente_code_check CHECK ((length((nieuwe_gemeente_code)::text) = 4)),
    CONSTRAINT herindeling_verstrekking_start_datum_check CHECK ((verstrekking_start_datum >= 20121101)),
    CONSTRAINT herindeling_volg_nr_check CHECK (((volg_nr >= 1) AND (volg_nr <= 25)))
);


ALTER TABLE public.herindeling OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: lo3_adres; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_adres (
    adres_id bigint NOT NULL,
    gemeente_code smallint NOT NULL,
    gemeente_deel character varying(24),
    straat_naam character varying(24),
    diak_straat_naam character varying(24),
    huis_nr integer,
    huis_letter character(1),
    huis_nr_toevoeging character varying(4),
    huis_nr_aand character varying(2),
    postcode character varying(6),
    locatie_beschrijving character varying(35),
    diak_locatie_beschrijving character varying(35),
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    open_ruimte_naam character varying(80),
    diak_open_ruimte_naam character varying(80),
    woon_plaats_naam character varying(80),
    diak_woon_plaats_naam character varying(80),
    verblijf_plaats_ident_code character varying(16),
    nummer_aand_ident_code character varying(16)
);


ALTER TABLE public.lo3_adres OWNER TO haalcentraal;

--
-- Name: lo3_adres_afnemer_ind; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_adres_afnemer_ind (
    adres_id bigint NOT NULL,
    afnemer_code integer NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_adres_afnemer_ind OWNER TO haalcentraal;

--
-- Name: lo3_afnemers_verstrekking_aut; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_afnemers_verstrekking_aut (
    autorisatie_id bigint NOT NULL,
    afnemer_code integer NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_afnemers_verstrekking_aut OWNER TO haalcentraal;

--
-- Name: lo3_akte_aand; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_akte_aand (
    akte_aand character varying(3) NOT NULL,
    akte_soort_oms character varying(80) NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_akte_aand OWNER TO haalcentraal;

--
-- Name: lo3_autorisatie; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_autorisatie (
    autorisatie_id bigint NOT NULL,
    afnemer_code integer NOT NULL,
    geheimhouding_ind smallint NOT NULL,
    verstrekkings_beperking smallint NOT NULL,
    afnemer_naam character varying(80),
    straat_naam character varying(24),
    huis_nr integer,
    huis_letter character(1),
    huis_nr_toevoeging character varying(4),
    postcode character varying(6),
    gemeente_code smallint,
    conditionele_verstrekking smallint,
    spontaan_medium character(1),
    selectie_soort smallint,
    bericht_aand smallint,
    eerste_selectie_datum integer,
    selectie_periode smallint,
    selectie_medium character(1),
    pl_plaatsings_bevoegdheid smallint,
    adres_vraag_bevoegdheid smallint,
    ad_hoc_medium character(1),
    adres_medium character(1),
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    sleutel_rubrieken text,
    spontaan_rubrieken text,
    selectie_rubrieken text,
    ad_hoc_rubrieken text,
    adres_rubrieken text,
    afnemers_verstrekkingen text,
    bijzondere_betrekking_kind_verstrekken smallint DEFAULT 0,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_autorisatie OWNER TO haalcentraal;

--
-- Name: lo3_autorisatie_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.lo3_autorisatie_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lo3_autorisatie_id_sequence OWNER TO haalcentraal;

--
-- Name: lo3_bericht; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_bericht (
    lo3_bericht_id bigint NOT NULL,
    aanduiding_in_uit character(1) NOT NULL,
    bericht_activiteit_id bigint,
    medium character(1) NOT NULL,
    originator_or_recipient character varying(7),
    spg_mailbox_instantie integer,
    eref character varying(12),
    bref character varying(12),
    eref2 character varying(12),
    berichtcyclus_id bigint,
    tijdstip_verzending_ontvangst timestamp without time zone,
    dispatch_sequence_number integer,
    report_delivery_time timestamp without time zone,
    non_delivery_reason character varying(4),
    non_receipt_reason character varying(4),
    bericht_data text,
    kop_random_key integer,
    kop_berichtsoort_nummer character varying(4),
    kop_a_nummer bigint,
    kop_oud_a_nummer bigint,
    kop_herhaling character(1),
    kop_foutreden character(1),
    kop_datum_tijd bigint,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_bericht OWNER TO haalcentraal;

--
-- Name: lo3_bericht_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.lo3_bericht_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lo3_bericht_id_sequence OWNER TO haalcentraal;

--
-- Name: lo3_bericht_view_inkomend; Type: VIEW; Schema: public; Owner: haalcentraal
--

CREATE VIEW public.lo3_bericht_view_inkomend AS
 SELECT lo3_bericht.lo3_bericht_id,
    lo3_bericht.originator_or_recipient,
    lo3_bericht.bref,
    lo3_bericht.dispatch_sequence_number,
    lo3_bericht.kop_berichtsoort_nummer
   FROM public.lo3_bericht;


ALTER TABLE public.lo3_bericht_view_inkomend OWNER TO haalcentraal;

--
-- Name: lo3_bericht_view_insert_update; Type: VIEW; Schema: public; Owner: haalcentraal
--

CREATE VIEW public.lo3_bericht_view_insert_update AS
 SELECT lo3_bericht.lo3_bericht_id,
    NULL::character(1) AS aanduiding_in_uit,
    NULL::bigint AS bericht_activiteit_id,
    NULL::character(1) AS medium,
    NULL::character varying(7) AS originator_or_recipient,
    NULL::integer AS spg_mailbox_instantie,
    NULL::character varying(12) AS eref,
    NULL::character varying(12) AS bref,
    NULL::character varying(12) AS eref2,
    NULL::timestamp without time zone AS tijdstip_verzending_ontvangst,
    NULL::integer AS dispatch_sequence_number,
    NULL::timestamp without time zone AS report_delivery_time,
    NULL::character varying(4) AS non_delivery_reason,
    NULL::character varying(4) AS non_receipt_reason,
    NULL::text AS bericht_data,
    NULL::integer AS kop_random_key,
    NULL::character varying(4) AS kop_berichtsoort_nummer,
    NULL::bigint AS kop_a_nummer,
    NULL::bigint AS kop_oud_a_nummer,
    NULL::character(1) AS kop_herhaling,
    NULL::character(1) AS kop_foutreden,
    NULL::bigint AS kop_datum_tijd
   FROM public.lo3_bericht;


ALTER TABLE public.lo3_bericht_view_insert_update OWNER TO haalcentraal;

--
-- Name: lo3_bericht_view_uitgaand; Type: VIEW; Schema: public; Owner: haalcentraal
--

CREATE VIEW public.lo3_bericht_view_uitgaand AS
 SELECT lo3_bericht.lo3_bericht_id,
    lo3_bericht.aanduiding_in_uit,
    lo3_bericht.bericht_activiteit_id,
    lo3_bericht.medium,
    lo3_bericht.originator_or_recipient,
    lo3_bericht.spg_mailbox_instantie,
    lo3_bericht.eref,
    lo3_bericht.bref,
    lo3_bericht.eref2,
    lo3_bericht.berichtcyclus_id,
    lo3_bericht.tijdstip_verzending_ontvangst,
    lo3_bericht.dispatch_sequence_number,
    lo3_bericht.report_delivery_time,
    lo3_bericht.non_delivery_reason,
    lo3_bericht.non_receipt_reason,
    lo3_bericht.bericht_data,
    lo3_bericht.kop_random_key,
    lo3_bericht.kop_berichtsoort_nummer,
    lo3_bericht.kop_a_nummer,
    lo3_bericht.kop_oud_a_nummer,
    lo3_bericht.kop_herhaling,
    lo3_bericht.kop_foutreden,
    lo3_bericht.kop_datum_tijd,
    lo3_bericht.creatie_dt
   FROM public.lo3_bericht
  WHERE (lo3_bericht.aanduiding_in_uit = 'U'::bpchar);


ALTER TABLE public.lo3_bericht_view_uitgaand OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: lo3_gba_deelnemer; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_gba_deelnemer (
    deelnemer_code integer NOT NULL,
    deelnemer_oms character varying(80) NOT NULL,
    gba_netwerk_aand smallint,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_gba_deelnemer OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: lo3_gemeente; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_gemeente (
    gemeente_code smallint NOT NULL,
    gemeente_naam character varying(40) NOT NULL,
    nieuwe_gemeente_code smallint,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_gemeente OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: lo3_gezagsverhouding; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_gezagsverhouding (
    gezagsverhouding_code character varying(2) NOT NULL,
    gezagsverhouding_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_gezagsverhouding OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: lo3_land; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_land (
    land_code smallint NOT NULL,
    land_naam character varying(42) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_land OWNER TO haalcentraal;

--
-- Name: lo3_mailbox; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_mailbox (
    lo3_mailbox_nummer character varying(7) NOT NULL,
    spg_mailbox_instantie integer,
    soort_instantie character(1) NOT NULL,
    code_instantie integer,
    indicatie_mailbox_actief character(1),
    brp_overgangs_datum integer,
    blokkade_start_dt timestamp without time zone,
    blokkade_eind_dt timestamp without time zone,
    mutatie_dt timestamp without time zone,
    blokkade_bericht_nrs character varying(400),
    deblokkade_toestand integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_mailbox OWNER TO haalcentraal;

--
-- Name: lo3_nationaliteit; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_nationaliteit (
    nationaliteit_code smallint NOT NULL,
    nationaliteit_oms character varying(42) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_nationaliteit OWNER TO haalcentraal;

--
-- Name: lo3_nl_nat_verkrijg_verlies_reden; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_nl_nat_verkrijg_verlies_reden (
    nl_nat_verkrijg_verlies_reden smallint NOT NULL,
    nl_nat_reden_oms character varying(80) NOT NULL,
    nl_nat_reden_soort character varying(2) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_nl_nat_verkrijg_verlies_reden OWNER TO haalcentraal;

--
-- Name: lo3_nl_reis_doc_autoriteit; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_nl_reis_doc_autoriteit (
    nl_reis_doc_autoriteit_code character varying(6) NOT NULL,
    nl_reis_doc_autoriteit_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_nl_reis_doc_autoriteit OWNER TO haalcentraal;

--
-- Name: lo3_nl_reis_doc_soort; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_nl_reis_doc_soort (
    nl_reis_doc_soort character varying(2) NOT NULL,
    nl_reis_doc_soort_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_nl_reis_doc_soort OWNER TO haalcentraal;

--
-- Name: lo3_pl; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl (
    pl_id bigint NOT NULL,
    pl_blokkering_start_datum integer,
    bijhouding_opschort_datum integer,
    bijhouding_opschort_reden character(1),
    gba_eerste_inschrijving_datum integer,
    pk_gemeente_code smallint,
    geheim_ind smallint,
    volledig_geconverteerd_pk character(1),
    europees_kiesrecht_aand smallint,
    europees_kiesrecht_datum integer,
    europees_uitsluit_eind_datum integer,
    kiesrecht_uitgesl_aand character(1),
    kiesrecht_uitgesl_eind_datum integer,
    kiesrecht_doc_gemeente_code smallint,
    kiesrecht_doc_datum integer,
    kiesrecht_doc_beschrijving character varying(40),
    mutatie_activiteit_id bigint,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    mutatie_dt timestamp without time zone NOT NULL,
    versie_nr smallint,
    stempel_dt bigint,
    verificatie_datum integer,
    verificatie_oms character varying(50),
    rni_deelnemer smallint,
    verdrag_oms character varying(50)
);


ALTER TABLE public.lo3_pl OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: lo3_pl_afnemer_ind; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_afnemer_ind (
    pl_id bigint NOT NULL,
    stapel_nr smallint NOT NULL,
    volg_nr smallint NOT NULL,
    afnemer_code integer,
    geldigheid_start_datum integer
);


ALTER TABLE public.lo3_pl_afnemer_ind OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: lo3_pl_gezagsverhouding; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_gezagsverhouding (
    pl_id bigint NOT NULL,
    volg_nr smallint NOT NULL,
    minderjarig_gezag_ind character varying(2),
    curatele_register_ind smallint,
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer
);


ALTER TABLE public.lo3_pl_gezagsverhouding OWNER TO haalcentraal;

--
-- Name: lo3_pl_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.lo3_pl_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lo3_pl_id_sequence OWNER TO haalcentraal;

--
-- Name: lo3_pl_nationaliteit; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_nationaliteit (
    pl_id bigint NOT NULL,
    stapel_nr smallint NOT NULL,
    volg_nr smallint NOT NULL,
    nationaliteit_code smallint,
    nl_nat_verkrijg_reden smallint,
    nl_nat_verlies_reden smallint,
    bijzonder_nl_aand character(1),
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer,
    rni_deelnemer smallint,
    verdrag_oms character varying(50),
    eu_persoon_nr character varying(40)
);


ALTER TABLE public.lo3_pl_nationaliteit OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: lo3_pl_overlijden; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_overlijden (
    pl_id bigint NOT NULL,
    volg_nr smallint NOT NULL,
    overlijden_datum integer,
    overlijden_plaats character varying(40),
    overlijden_land_code smallint,
    akte_register_gemeente_code smallint,
    akte_nr character varying(7),
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer,
    rni_deelnemer smallint,
    verdrag_oms character varying(50)
);


ALTER TABLE public.lo3_pl_overlijden OWNER TO haalcentraal;

--
-- Name: lo3_pl_paw_index_2; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_paw_index_2 (
    pl_id bigint NOT NULL,
    voor_naam character varying(200),
    diak_voor_naam character varying(200),
    geslachts_naam character varying(200) NOT NULL,
    diak_geslachts_naam character varying(200),
    titel_predikaat character varying(2),
    geslachts_naam_voorvoegsel character varying(10),
    geboorte_datum integer,
    geboorte_plaats character varying(40),
    geboorte_land_code smallint,
    geslachts_aand character(1),
    naam_gebruik_aand character(1),
    inschrijving_gemeente_code smallint NOT NULL,
    gemeente_deel character varying(24),
    straat_naam character varying(24),
    diak_straat_naam character varying(24),
    huis_nr integer,
    huis_letter character(1),
    huis_nr_toevoeging character varying(4),
    huis_nr_aand character varying(2),
    postcode character varying(6),
    locatie_beschrijving character varying(35),
    diak_locatie_beschrijving character varying(35),
    open_ruimte_naam character varying(80),
    diak_open_ruimte_naam character varying(80),
    woon_plaats_naam character varying(80),
    diak_woon_plaats_naam character varying(80),
    verblijf_plaats_ident_code character varying(16),
    nummer_aand_ident_code character varying(16)
);


ALTER TABLE public.lo3_pl_paw_index_2 OWNER TO haalcentraal;

--
-- Name: lo3_pl_persoon; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_persoon (
    pl_id bigint NOT NULL,
    persoon_type character(1) NOT NULL,
    stapel_nr smallint NOT NULL,
    volg_nr smallint NOT NULL,
    a_nr bigint,
    burger_service_nr bigint,
    voor_naam character varying(200),
    diak_voor_naam character varying(200),
    titel_predicaat character varying(2),
    geslachts_naam_voorvoegsel character varying(10),
    geslachts_naam character varying(200),
    diak_geslachts_naam character varying(200),
    geboorte_datum integer,
    geboorte_plaats character varying(40),
    geboorte_land_code smallint,
    geslachts_aand character(1),
    naam_gebruik_aand character(1),
    akte_register_gemeente_code smallint,
    akte_nr character varying(7),
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer,
    relatie_start_datum integer,
    relatie_start_plaats character varying(40),
    relatie_start_land_code smallint,
    relatie_eind_datum integer,
    relatie_eind_plaats character varying(40),
    relatie_eind_land_code smallint,
    relatie_eind_reden character(1),
    verbintenis_soort character(1),
    familie_betrek_start_datum integer,
    vorig_a_nr bigint,
    volgend_a_nr bigint,
    rni_deelnemer smallint,
    verdrag_oms character varying(50),
    registratie_betrekking character(1)
);


ALTER TABLE public.lo3_pl_persoon OWNER TO haalcentraal;

--
-- Name: lo3_pl_reis_doc; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_reis_doc (
    pl_id bigint NOT NULL,
    stapel_nr smallint NOT NULL,
    nl_reis_doc_soort character varying(2),
    nl_reis_doc_nr character varying(9),
    nl_reis_doc_uitgifte_datum integer,
    nl_reis_doc_autoriteit_code character varying(6),
    nl_reis_doc_geldig_eind_datum integer,
    nl_reis_doc_weg_datum integer,
    nl_reis_doc_weg_ind character(1),
    nl_reis_doc_houder_lengte smallint,
    nl_reis_doc_signalering smallint,
    buitenland_reis_doc_aand smallint,
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    geldigheid_start_datum integer,
    opneming_datum integer
);


ALTER TABLE public.lo3_pl_reis_doc OWNER TO haalcentraal;

--
-- Name: lo3_pl_serialized; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_serialized (
    pl_id bigint NOT NULL,
    mutatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.lo3_pl_serialized OWNER TO haalcentraal;

--
-- Name: lo3_pl_verblijfplaats; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_verblijfplaats (
    pl_id bigint NOT NULL,
    volg_nr smallint NOT NULL,
    inschrijving_gemeente_code smallint,
    adres_id bigint,
    inschrijving_datum integer,
    adres_functie character(1),
    gemeente_deel character varying(24),
    adreshouding_start_datum integer,
    vertrek_land_code smallint,
    vertrek_datum integer,
    vertrek_land_adres_1 character varying(35),
    vertrek_land_adres_2 character varying(35),
    vertrek_land_adres_3 character varying(35),
    vestiging_land_code smallint,
    vestiging_datum integer,
    aangifte_adreshouding_oms character(1),
    doc_ind smallint,
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer,
    rni_deelnemer smallint,
    verdrag_oms character varying(50)
);


ALTER TABLE public.lo3_pl_verblijfplaats OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: lo3_pl_verblijfstitel; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_verblijfstitel (
    pl_id bigint NOT NULL,
    volg_nr smallint NOT NULL,
    verblijfstitel_aand smallint,
    verblijfstitel_eind_datum integer,
    verblijfstitel_start_datum integer,
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer
);


ALTER TABLE public.lo3_pl_verblijfstitel OWNER TO haalcentraal;

--
-- Name: lo3_relatie_eind_reden; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_relatie_eind_reden (
    relatie_eind_reden character(1) NOT NULL,
    relatie_eind_reden_oms character varying(80),
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_relatie_eind_reden OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: lo3_rni_deelnemer; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_rni_deelnemer (
    deelnemer_code smallint NOT NULL,
    deelnemer_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_rni_deelnemer OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: lo3_titel_predicaat; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_titel_predicaat (
    titel_predicaat character varying(2) NOT NULL,
    titel_predicaat_oms character varying(10) NOT NULL,
    titel_predicaat_soort character varying(10) NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_titel_predicaat OWNER TO haalcentraal;

--
-- Name: lo3_verblijfstitel_aand; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_verblijfstitel_aand (
    verblijfstitel_aand smallint NOT NULL,
    verblijfstitel_aand_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_verblijfstitel_aand OWNER TO haalcentraal;

--
-- Name: lo3_voorvoegsel; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_voorvoegsel (
    voorvoegsel character varying(10) NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_voorvoegsel OWNER TO haalcentraal;

--
-- Name: lo3_voorwaarde_regel_aut; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_voorwaarde_regel_aut (
    voorwaarde_type character(1) NOT NULL,
    voorwaarde_regel character varying(4096) NOT NULL,
    autorisatie_id bigint NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_voorwaarde_regel_aut OWNER TO haalcentraal;

--
-- Name: lo3_vospg_instructie; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_vospg_instructie (
    spg_mailbox_instantie integer NOT NULL,
    soort_instructie character varying(40),
    dag_van_de_week smallint,
    tijd time without time zone,
    datum_tijd timestamp without time zone,
    tijdstip_laatste_actie timestamp without time zone,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_vospg_instructie OWNER TO haalcentraal;

--
-- Name: lo3_vospg_instructie_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.lo3_vospg_instructie_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lo3_vospg_instructie_id_sequence OWNER TO haalcentraal;

--
-- Name: lookup_codering; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lookup_codering (
    lookup_codering_id integer NOT NULL,
    codering_naam character varying(40) NOT NULL,
    code_type character(1) NOT NULL,
    idc_vaste_codering character(1) NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lookup_codering OWNER TO haalcentraal;

--
-- Name: lookup_codewaarde; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lookup_codewaarde (
    lookup_codering_id integer NOT NULL,
    referentie_waarde_num integer,
    referentie_waarde_alfa character varying(40),
    lookup_afkorting character varying(20),
    lookup_omschrijving character varying(40) NOT NULL,
    omschrijving_volledig character varying(200),
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    mutatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lookup_codewaarde OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: miteller; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.miteller (
    groep_id character varying(8) NOT NULL,
    soort_teller integer NOT NULL,
    aantal integer NOT NULL,
    datum_telling date NOT NULL,
    periode smallint NOT NULL,
    periode_aanduiding character varying(5) NOT NULL
);


ALTER TABLE public.miteller OWNER TO haalcentraal;

--
-- Name: miteller_marker; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.miteller_marker (
    marker_id character varying(30) NOT NULL,
    marker bigint NOT NULL
);


ALTER TABLE public.miteller_marker OWNER TO haalcentraal;

--
-- Name: monitor; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.monitor (
    monitor_id bigint NOT NULL,
    node character varying(50) NOT NULL,
    component character varying(50) NOT NULL,
    ernst integer NOT NULL,
    melding text,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.monitor OWNER TO haalcentraal;

--
-- Name: monitor_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.monitor_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.monitor_id_sequence OWNER TO haalcentraal;

--
-- Name: selectie_enumeratie; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.selectie_enumeratie (
    selectie_instelling_id bigint NOT NULL,
    enumeratie text
);


ALTER TABLE public.selectie_enumeratie OWNER TO haalcentraal;

--
-- Name: selectie_instelling; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.selectie_instelling (
    selectie_instelling_id bigint NOT NULL,
    autorisatie_id bigint NOT NULL,
    geschatte_omvang integer NOT NULL,
    leverwijze integer NOT NULL,
    max_berichten integer NOT NULL,
    berichtsoort integer,
    selectiesoort integer NOT NULL,
    bestands_formaat integer,
    selectie_datum date NOT NULL,
    berekende_selectie_datum date NOT NULL,
    selectie_activiteit_id bigint NOT NULL,
    voorwaarde_regel character varying(4096) NOT NULL,
    rubrieken character varying(4096) NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    teller_definities character varying(4096)
);


ALTER TABLE public.selectie_instelling OWNER TO haalcentraal;

--
-- Name: selectie_instelling_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.selectie_instelling_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.selectie_instelling_id_sequence OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: spg_mailbox; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.spg_mailbox (
    spg_mailbox_instantie integer NOT NULL,
    spg_mailbox_nummer character varying(7) NOT NULL
);


ALTER TABLE public.spg_mailbox OWNER TO haalcentraal;

--
-- Name: spg_schema; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.spg_schema (
    version character varying(40) NOT NULL
);


ALTER TABLE public.spg_schema OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: tmp_convert_special_characters_adres; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.tmp_convert_special_characters_adres (
    adres_id bigint,
    old_straat_naam character varying(24),
    old_diak_straat_naam character varying(24),
    old_locatie_beschrijving character varying(35),
    old_diak_locatie_beschrijving character varying(35),
    new_straat_naam character varying,
    new_diak_straat_naam character varying(24),
    new_locatie_beschrijving character varying,
    new_diak_locatie_beschrijving character varying(35)
);


ALTER TABLE public.tmp_convert_special_characters_adres OWNER TO haalcentraal;

--
-- Name: tmp_convert_special_characters_persoon; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.tmp_convert_special_characters_persoon (
    pl_id bigint,
    persoon_type character(1),
    stapel_nr smallint,
    volg_nr smallint,
    old_voor_naam character varying(200),
    old_diak_voor_naam character varying(200),
    old_geslachts_naam character varying(200),
    old_diak_geslachts_naam character varying(200),
    new_voor_naam character varying,
    new_diak_voor_naam character varying(200),
    new_geslachts_naam character varying,
    new_diak_geslachts_naam character varying(200)
);


ALTER TABLE public.tmp_convert_special_characters_persoon OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: toestand_overgang; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.toestand_overgang (
    toestand_overgang_id integer NOT NULL,
    activiteit_type integer NOT NULL,
    activiteit_subtype integer,
    toestand_huidig integer,
    gebeurtenis_type integer NOT NULL,
    toestand_nieuw integer NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.toestand_overgang OWNER TO haalcentraal;

--
-- Name: toestand_overgang_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.toestand_overgang_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.toestand_overgang_id_sequence OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: pl_bericht; Type: TABLE; Schema: vospg; Owner: haalcentraal
--

CREATE TABLE vospg.pl_bericht (
    pl_bericht_id bigint NOT NULL,
    a_nr bigint,
    bericht_data text,
    hash_bericht_data text,
    verzender character varying(7),
    tijdstip_ontvangst timestamp without time zone,
    berichtsoort_nummer character varying(4)
);


ALTER TABLE vospg.pl_bericht OWNER TO haalcentraal;

--
-- Name: pl_bericht_id_sequence; Type: SEQUENCE; Schema: vospg; Owner: haalcentraal
--

CREATE SEQUENCE vospg.pl_bericht_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE vospg.pl_bericht_id_sequence OWNER TO haalcentraal;

--
-- Name: activiteit_small activiteit_small_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.activiteit_small
    ADD CONSTRAINT activiteit_small_pk PRIMARY KEY (activiteit_id);


--
-- Name: afnemer afnemer_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.afnemer
    ADD CONSTRAINT afnemer_pk PRIMARY KEY (afnemer_id);


--
-- Name: gebeurtenis_data gebeurtenis_data_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.gebeurtenis_data
    ADD CONSTRAINT gebeurtenis_data_pk PRIMARY KEY (gebeurtenis_data_id);


--
-- Name: gebeurtenis_small gebeurtenis_small_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.gebeurtenis_small
    ADD CONSTRAINT gebeurtenis_small_pk PRIMARY KEY (gebeurtenis_id);


--
-- Name: haalcentraal_vraag haalcentraal_vraag_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.haalcentraal_vraag
    ADD CONSTRAINT haalcentraal_vraag_pk PRIMARY KEY (request_id);


--
-- Name: herindeling herindeling_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.herindeling
    ADD CONSTRAINT herindeling_pk PRIMARY KEY (herindeling_id);


--
-- Name: lo3_adres_afnemer_ind lo3_adres_afnemer_ind_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_adres_afnemer_ind
    ADD CONSTRAINT lo3_adres_afnemer_ind_pk PRIMARY KEY (adres_id, afnemer_code);


--
-- Name: lo3_adres lo3_adres_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_adres
    ADD CONSTRAINT lo3_adres_pk PRIMARY KEY (adres_id);


--
-- Name: lo3_afnemers_verstrekking_aut lo3_afnemers_verstrekking_aut_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_afnemers_verstrekking_aut
    ADD CONSTRAINT lo3_afnemers_verstrekking_aut_pk PRIMARY KEY (autorisatie_id, afnemer_code);


--
-- Name: lo3_akte_aand lo3_akte_aand_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_akte_aand
    ADD CONSTRAINT lo3_akte_aand_pk PRIMARY KEY (akte_aand);


--
-- Name: lo3_autorisatie lo3_autorisatie_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_autorisatie
    ADD CONSTRAINT lo3_autorisatie_pk PRIMARY KEY (autorisatie_id);


--
-- Name: lo3_bericht lo3_bericht_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_bericht
    ADD CONSTRAINT lo3_bericht_pk PRIMARY KEY (lo3_bericht_id);


--
-- Name: lo3_gba_deelnemer lo3_gba_deelnemer_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_gba_deelnemer
    ADD CONSTRAINT lo3_gba_deelnemer_pk PRIMARY KEY (deelnemer_code);


--
-- Name: lo3_gemeente lo3_gemeente_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_gemeente
    ADD CONSTRAINT lo3_gemeente_pk PRIMARY KEY (gemeente_code);


--
-- Name: lo3_gezagsverhouding lo3_gezagsverhouding_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_gezagsverhouding
    ADD CONSTRAINT lo3_gezagsverhouding_pk PRIMARY KEY (gezagsverhouding_code);


--
-- Name: lo3_land lo3_land_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_land
    ADD CONSTRAINT lo3_land_pk PRIMARY KEY (land_code);


--
-- Name: lo3_mailbox lo3_mailbox_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_mailbox
    ADD CONSTRAINT lo3_mailbox_pk PRIMARY KEY (lo3_mailbox_nummer);


--
-- Name: lo3_nationaliteit lo3_nationaliteit_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_nationaliteit
    ADD CONSTRAINT lo3_nationaliteit_pk PRIMARY KEY (nationaliteit_code);


--
-- Name: lo3_nl_nat_verkrijg_verlies_reden lo3_nl_nat_verkrijg_verlies_reden_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_nl_nat_verkrijg_verlies_reden
    ADD CONSTRAINT lo3_nl_nat_verkrijg_verlies_reden_pk PRIMARY KEY (nl_nat_verkrijg_verlies_reden);


--
-- Name: lo3_nl_reis_doc_autoriteit lo3_nl_reis_doc_autoriteit_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_nl_reis_doc_autoriteit
    ADD CONSTRAINT lo3_nl_reis_doc_autoriteit_pk PRIMARY KEY (nl_reis_doc_autoriteit_code);


--
-- Name: lo3_nl_reis_doc_soort lo3_nl_reis_doc_soort_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_nl_reis_doc_soort
    ADD CONSTRAINT lo3_nl_reis_doc_soort_pk PRIMARY KEY (nl_reis_doc_soort);


--
-- Name: lo3_pl_afnemer_ind lo3_pl_afnemer_ind_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_afnemer_ind
    ADD CONSTRAINT lo3_pl_afnemer_ind_pk PRIMARY KEY (pl_id, stapel_nr, volg_nr);


--
-- Name: lo3_pl_gezagsverhouding lo3_pl_gezagsverhouding_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_gezagsverhouding
    ADD CONSTRAINT lo3_pl_gezagsverhouding_pk PRIMARY KEY (pl_id, volg_nr);


--
-- Name: lo3_pl_nationaliteit lo3_pl_nationaliteit_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_nationaliteit
    ADD CONSTRAINT lo3_pl_nationaliteit_pk PRIMARY KEY (pl_id, stapel_nr, volg_nr);


--
-- Name: lo3_pl_overlijden lo3_pl_overlijden_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_overlijden
    ADD CONSTRAINT lo3_pl_overlijden_pk PRIMARY KEY (pl_id, volg_nr);


--
-- Name: lo3_pl_paw_index_2 lo3_pl_paw_index_2_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_paw_index_2
    ADD CONSTRAINT lo3_pl_paw_index_2_pk PRIMARY KEY (pl_id);


--
-- Name: lo3_pl_persoon lo3_pl_persoon_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_persoon
    ADD CONSTRAINT lo3_pl_persoon_pk PRIMARY KEY (pl_id, persoon_type, stapel_nr, volg_nr);

ALTER TABLE public.lo3_pl_persoon CLUSTER ON lo3_pl_persoon_pk;


--
-- Name: lo3_pl lo3_pl_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl
    ADD CONSTRAINT lo3_pl_pk PRIMARY KEY (pl_id);


--
-- Name: lo3_pl_reis_doc lo3_pl_reis_doc_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_reis_doc
    ADD CONSTRAINT lo3_pl_reis_doc_pk PRIMARY KEY (pl_id, stapel_nr);

ALTER TABLE public.lo3_pl_reis_doc CLUSTER ON lo3_pl_reis_doc_pk;


--
-- Name: lo3_pl_serialized lo3_pl_serialized_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_serialized
    ADD CONSTRAINT lo3_pl_serialized_pk PRIMARY KEY (pl_id);


--
-- Name: lo3_pl_verblijfplaats lo3_pl_verblijfplaats_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_verblijfplaats
    ADD CONSTRAINT lo3_pl_verblijfplaats_pk PRIMARY KEY (pl_id, volg_nr);

ALTER TABLE public.lo3_pl_verblijfplaats CLUSTER ON lo3_pl_verblijfplaats_pk;


--
-- Name: lo3_pl_verblijfstitel lo3_pl_verblijfstitel_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_verblijfstitel
    ADD CONSTRAINT lo3_pl_verblijfstitel_pk PRIMARY KEY (pl_id, volg_nr);


--
-- Name: lo3_relatie_eind_reden lo3_relatie_eind_reden_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_relatie_eind_reden
    ADD CONSTRAINT lo3_relatie_eind_reden_pk PRIMARY KEY (relatie_eind_reden);


--
-- Name: lo3_rni_deelnemer lo3_rni_deelnemer_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_rni_deelnemer
    ADD CONSTRAINT lo3_rni_deelnemer_pk PRIMARY KEY (deelnemer_code);


--
-- Name: lo3_titel_predicaat lo3_titel_predikaat_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_titel_predicaat
    ADD CONSTRAINT lo3_titel_predikaat_pk PRIMARY KEY (titel_predicaat);


--
-- Name: lo3_voorvoegsel lo3_voorvoegsel_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_voorvoegsel
    ADD CONSTRAINT lo3_voorvoegsel_pk PRIMARY KEY (voorvoegsel);


--
-- Name: lo3_voorwaarde_regel_aut lo3_voorwaarde_regel_aut_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_voorwaarde_regel_aut
    ADD CONSTRAINT lo3_voorwaarde_regel_aut_pk PRIMARY KEY (voorwaarde_type, autorisatie_id);


--
-- Name: lookup_codering lookup_codering_codering_naam_key; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lookup_codering
    ADD CONSTRAINT lookup_codering_codering_naam_key UNIQUE (codering_naam);


--
-- Name: lookup_codering lookup_codering_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lookup_codering
    ADD CONSTRAINT lookup_codering_pk PRIMARY KEY (lookup_codering_id);


--
-- Name: lookup_codewaarde lookup_codewaarde_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lookup_codewaarde
    ADD CONSTRAINT lookup_codewaarde_pk PRIMARY KEY (lookup_codering_id, lookup_omschrijving);


--
-- Name: monitor monitor_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.monitor
    ADD CONSTRAINT monitor_pk PRIMARY KEY (monitor_id);


--
-- Name: selectie_enumeratie selectie_enumeratie_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.selectie_enumeratie
    ADD CONSTRAINT selectie_enumeratie_pk PRIMARY KEY (selectie_instelling_id);


--
-- Name: selectie_instelling selectie_instelling_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.selectie_instelling
    ADD CONSTRAINT selectie_instelling_pk PRIMARY KEY (selectie_instelling_id);


--
-- Name: spg_mailbox spg_mailbox_pl; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.spg_mailbox
    ADD CONSTRAINT spg_mailbox_pl PRIMARY KEY (spg_mailbox_instantie);


--
-- Name: toestand_overgang toestand_overgang_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.toestand_overgang
    ADD CONSTRAINT toestand_overgang_pk PRIMARY KEY (toestand_overgang_id);


--
-- Name: lo3_verblijfstitel_aand verblijfstitel_aand_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_verblijfstitel_aand
    ADD CONSTRAINT verblijfstitel_aand_pk PRIMARY KEY (verblijfstitel_aand);


--
-- Name: pl_bericht pl_bericht_pk; Type: CONSTRAINT; Schema: vospg; Owner: haalcentraal
--

ALTER TABLE ONLY vospg.pl_bericht
    ADD CONSTRAINT pl_bericht_pk PRIMARY KEY (pl_bericht_id);


--
-- Name: activiteit_small_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX activiteit_small_idx_1 ON public.activiteit_small USING btree (pl_id);


--
-- Name: activiteit_small_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX activiteit_small_idx_2 ON public.activiteit_small USING btree (start_dt, activiteit_type, toestand, activiteit_subtype);


--
-- Name: activiteit_small_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX activiteit_small_idx_3 ON public.activiteit_small USING btree (moeder_id, toestand, activiteit_id);


--
-- Name: activiteit_small_idx_4; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX activiteit_small_idx_4 ON public.activiteit_small USING btree (activiteit_type, toestand, activiteit_subtype);


--
-- Name: activiteit_small_idx_5; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX activiteit_small_idx_5 ON public.activiteit_small USING btree (communicatie_partner, toestand, activiteit_type, activiteit_subtype);


--
-- Name: activiteit_small_idx_6; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX activiteit_small_idx_6 ON public.activiteit_small USING btree (activiteit_type, toestand, activiteit_id, laatste_actie_dt) WHERE ((activiteit_type = 100) AND ((toestand = 10000) OR (toestand = 10002)));


--
-- Name: activiteit_small_idx_8; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX activiteit_small_idx_8 ON public.activiteit_small USING btree (uiterlijke_actie_dt, toestand) WHERE ((toestand < 8000) OR (toestand > 9999));


--
-- Name: afnemer_idx_0; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX afnemer_idx_0 ON public.afnemer USING btree (afnemer_code);


--
-- Name: afnemer_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX afnemer_idx_1 ON public.afnemer USING btree (oin);


--
-- Name: gebeurtenis_data_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX gebeurtenis_data_idx_1 ON public.gebeurtenis_data USING btree (gebeurtenis_id);


--
-- Name: gebeurtenis_small_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX gebeurtenis_small_idx_1 ON public.gebeurtenis_small USING btree (activiteit_id);


--
-- Name: gebeurtenis_small_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX gebeurtenis_small_idx_2 ON public.gebeurtenis_small USING btree (gebeurtenis_type, gebeurtenis_hash, gebeurtenis_dt) WHERE ((gebeurtenis_type = 1103) OR (gebeurtenis_type = 1104) OR (gebeurtenis_type = 1105) OR (gebeurtenis_type = 1106) OR (gebeurtenis_type = 1110) OR (gebeurtenis_type = 1111) OR (gebeurtenis_type = 1112) OR (gebeurtenis_type = 1119));


--
-- Name: gebeurtenis_small_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX gebeurtenis_small_idx_3 ON public.gebeurtenis_small USING btree (gebeurtenis_type, gebeurtenis_dt) WHERE ((gebeurtenis_type >= 4000) AND (gebeurtenis_type <= 4999));


--
-- Name: herindeling_idx_0; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX herindeling_idx_0 ON public.herindeling USING btree (nieuwe_gemeente_code, herindeling_datum);


--
-- Name: lo3_adres_afnemer_ind_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX lo3_adres_afnemer_ind_idx_1 ON public.lo3_adres_afnemer_ind USING btree (afnemer_code, adres_id);


--
-- Name: lo3_adres_idx_0; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX lo3_adres_idx_0 ON public.lo3_adres USING btree (gemeente_code, COALESCE(gemeente_deel, ''::character varying), COALESCE(straat_naam, ''::character varying), COALESCE(diak_straat_naam, ''::character varying), COALESCE(open_ruimte_naam, ''::character varying), COALESCE(diak_open_ruimte_naam, ''::character varying), COALESCE(huis_nr, 666666), COALESCE(huis_letter, ''::bpchar), COALESCE(huis_nr_toevoeging, ''::character varying), COALESCE(huis_nr_aand, ''::character varying), COALESCE(postcode, ''::character varying), COALESCE(woon_plaats_naam, ''::character varying), COALESCE(diak_woon_plaats_naam, ''::character varying), COALESCE(locatie_beschrijving, ''::character varying), COALESCE(diak_locatie_beschrijving, ''::character varying), COALESCE(verblijf_plaats_ident_code, ''::character varying), COALESCE(nummer_aand_ident_code, ''::character varying));


--
-- Name: lo3_adres_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_idx_1 ON public.lo3_adres USING btree (lower((postcode)::text) text_pattern_ops, huis_nr, huis_letter, huis_nr_toevoeging);


--
-- Name: lo3_adres_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_idx_2 ON public.lo3_adres USING btree (gemeente_code, lower((straat_naam)::text) text_pattern_ops, huis_nr, huis_letter, huis_nr_toevoeging);


--
-- Name: lo3_adres_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_idx_3 ON public.lo3_adres USING btree (lower((straat_naam)::text) text_pattern_ops, huis_nr, huis_letter, huis_nr_toevoeging);


--
-- Name: lo3_adres_idx_4; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_idx_4 ON public.lo3_adres USING btree (lower((locatie_beschrijving)::text) text_pattern_ops);


--
-- Name: lo3_bericht_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_bericht_idx_1 ON public.lo3_bericht USING btree (eref);


--
-- Name: lo3_bericht_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_bericht_idx_2 ON public.lo3_bericht USING btree (bref);


--
-- Name: lo3_bericht_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_bericht_idx_3 ON public.lo3_bericht USING btree (bericht_activiteit_id);


--
-- Name: lo3_bericht_idx_4; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_bericht_idx_4 ON public.lo3_bericht USING btree (dispatch_sequence_number);


--
-- Name: lo3_bericht_idx_5; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_bericht_idx_5 ON public.lo3_bericht USING btree (berichtcyclus_id);


--
-- Name: lo3_bericht_idx_6; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_bericht_idx_6 ON public.lo3_bericht USING btree (bref, originator_or_recipient, aanduiding_in_uit);


--
-- Name: lo3_pl_afnemer_ind_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_afnemer_ind_idx_1 ON public.lo3_pl_afnemer_ind USING btree (afnemer_code, geldigheid_start_datum);


--
-- Name: lo3_pl_paw_index_2_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_paw_index_2_idx_1 ON public.lo3_pl_paw_index_2 USING btree (lower((geslachts_naam)::text) text_pattern_ops, inschrijving_gemeente_code, lower((straat_naam)::text) text_pattern_ops);


--
-- Name: lo3_pl_paw_index_2_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_paw_index_2_idx_2 ON public.lo3_pl_paw_index_2 USING btree (lower((postcode)::text) text_pattern_ops, lower((geslachts_naam)::text) text_pattern_ops);


--
-- Name: lo3_pl_paw_index_2_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_paw_index_2_idx_3 ON public.lo3_pl_paw_index_2 USING btree (geboorte_datum, lower((postcode)::text) text_pattern_ops);


--
-- Name: lo3_pl_paw_index_2_idx_4; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_paw_index_2_idx_4 ON public.lo3_pl_paw_index_2 USING btree (lower((straat_naam)::text) text_pattern_ops, lower((geslachts_naam)::text) text_pattern_ops);


--
-- Name: lo3_pl_persoon_idx_0; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX lo3_pl_persoon_idx_0 ON public.lo3_pl_persoon USING btree (a_nr) WHERE ((persoon_type = 'P'::bpchar) AND (stapel_nr = 0) AND (volg_nr = 0));


--
-- Name: lo3_pl_persoon_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_persoon_idx_1 ON public.lo3_pl_persoon USING btree (a_nr, persoon_type, stapel_nr, volg_nr);


--
-- Name: lo3_pl_persoon_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_persoon_idx_2 ON public.lo3_pl_persoon USING btree (burger_service_nr, persoon_type, stapel_nr, volg_nr);


--
-- Name: lo3_pl_persoon_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_persoon_idx_3 ON public.lo3_pl_persoon USING btree (lower((geslachts_naam)::text) text_pattern_ops, persoon_type, stapel_nr, volg_nr, lower((voor_naam)::text) text_pattern_ops);


--
-- Name: lo3_pl_persoon_idx_4; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_persoon_idx_4 ON public.lo3_pl_persoon USING btree (geboorte_datum, lower((geslachts_naam)::text) text_pattern_ops, persoon_type, stapel_nr, volg_nr, lower((voor_naam)::text) text_pattern_ops);


--
-- Name: lo3_pl_serialized_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_serialized_idx_1 ON public.lo3_pl_serialized USING btree (mutatie_dt);


--
-- Name: lo3_pl_verblijfplaats_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_verblijfplaats_idx_1 ON public.lo3_pl_verblijfplaats USING btree (inschrijving_gemeente_code, volg_nr, geldigheid_start_datum);


--
-- Name: lo3_pl_verblijfplaats_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_verblijfplaats_idx_2 ON public.lo3_pl_verblijfplaats USING btree (adres_id, volg_nr, geldigheid_start_datum);


--
-- Name: lookup_codewaarde_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX lookup_codewaarde_idx_1 ON public.lookup_codewaarde USING btree (lookup_codering_id, referentie_waarde_num);


--
-- Name: lookup_codewaarde_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX lookup_codewaarde_idx_2 ON public.lookup_codewaarde USING btree (lookup_codering_id, referentie_waarde_alfa);


--
-- Name: spg_mailbox_nr; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX spg_mailbox_nr ON public.spg_mailbox USING btree (spg_mailbox_nummer);


--
-- Name: toestand_overgang_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX toestand_overgang_idx_1 ON public.toestand_overgang USING btree (activiteit_type, activiteit_subtype, toestand_huidig, gebeurtenis_type, toestand_nieuw);


--
-- Name: pl_bericht_idx_1; Type: INDEX; Schema: vospg; Owner: haalcentraal
--

CREATE INDEX pl_bericht_idx_1 ON vospg.pl_bericht USING btree (verzender, a_nr);


--
-- Name: pl_bericht_idx_2; Type: INDEX; Schema: vospg; Owner: haalcentraal
--

CREATE INDEX pl_bericht_idx_2 ON vospg.pl_bericht USING btree (tijdstip_ontvangst);


--
-- Name: lo3_bericht_view_insert_update view_lo3_bericht_ins; Type: RULE; Schema: public; Owner: haalcentraal
--

CREATE RULE view_lo3_bericht_ins AS
    ON INSERT TO public.lo3_bericht_view_insert_update DO INSTEAD  INSERT INTO public.lo3_bericht (lo3_bericht_id, aanduiding_in_uit, bericht_activiteit_id, medium, originator_or_recipient, spg_mailbox_instantie, eref, bref, eref2, tijdstip_verzending_ontvangst, dispatch_sequence_number, report_delivery_time, non_delivery_reason, non_receipt_reason, bericht_data, kop_random_key, kop_berichtsoort_nummer, kop_a_nummer, kop_oud_a_nummer, kop_herhaling, kop_foutreden, kop_datum_tijd)
  VALUES (new.lo3_bericht_id, new.aanduiding_in_uit, new.bericht_activiteit_id, new.medium, new.originator_or_recipient, new.spg_mailbox_instantie, new.eref, new.bref, new.eref2, new.tijdstip_verzending_ontvangst, new.dispatch_sequence_number, new.report_delivery_time, new.non_delivery_reason, new.non_receipt_reason, new.bericht_data, new.kop_random_key, new.kop_berichtsoort_nummer, new.kop_a_nummer, new.kop_oud_a_nummer, new.kop_herhaling, new.kop_foutreden, new.kop_datum_tijd);


--
-- Name: lo3_bericht_view_insert_update view_lo3_bericht_upd; Type: RULE; Schema: public; Owner: haalcentraal
--

CREATE RULE view_lo3_bericht_upd AS
    ON UPDATE TO public.lo3_bericht_view_insert_update DO INSTEAD  UPDATE public.lo3_bericht SET aanduiding_in_uit = new.aanduiding_in_uit, bericht_activiteit_id = new.bericht_activiteit_id, medium = new.medium, originator_or_recipient = new.originator_or_recipient, spg_mailbox_instantie = new.spg_mailbox_instantie, eref = new.eref, bref = new.bref, eref2 = new.eref2, tijdstip_verzending_ontvangst = new.tijdstip_verzending_ontvangst, dispatch_sequence_number = new.dispatch_sequence_number, report_delivery_time = new.report_delivery_time, non_delivery_reason = new.non_delivery_reason, non_receipt_reason = new.non_receipt_reason, bericht_data = new.bericht_data, kop_random_key = new.kop_random_key, kop_berichtsoort_nummer = new.kop_berichtsoort_nummer, kop_a_nummer = new.kop_a_nummer, kop_oud_a_nummer = new.kop_oud_a_nummer, kop_herhaling = new.kop_herhaling, kop_foutreden = new.kop_foutreden, kop_datum_tijd = new.kop_datum_tijd
  WHERE (lo3_bericht.lo3_bericht_id = old.lo3_bericht_id);


--
-- Name: lo3_pl_verblijfplaats lo3_pl_verblijfplaats_adres_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_verblijfplaats
    ADD CONSTRAINT lo3_pl_verblijfplaats_adres_id_fkey FOREIGN KEY (adres_id) REFERENCES public.lo3_adres(adres_id);


--
-- Name: lo3_vospg_instructie lo3_vospg_instructie_spg_mailbox_instantie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_vospg_instructie
    ADD CONSTRAINT lo3_vospg_instructie_spg_mailbox_instantie_fkey FOREIGN KEY (spg_mailbox_instantie) REFERENCES public.spg_mailbox(spg_mailbox_instantie);


--
-- Name: lookup_codewaarde lookup_codewaarde_lookup_codering_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lookup_codewaarde
    ADD CONSTRAINT lookup_codewaarde_lookup_codering_id_fkey FOREIGN KEY (lookup_codering_id) REFERENCES public.lookup_codering(lookup_codering_id);


--
-- Name: selectie_enumeratie selectie_enumeratie_selectie_instelling_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.selectie_enumeratie
    ADD CONSTRAINT selectie_enumeratie_selectie_instelling_id_fkey FOREIGN KEY (selectie_instelling_id) REFERENCES public.selectie_instelling(selectie_instelling_id);


--
-- Name: selectie_instelling selectie_instelling_autorisatie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.selectie_instelling
    ADD CONSTRAINT selectie_instelling_autorisatie_id_fkey FOREIGN KEY (autorisatie_id) REFERENCES public.lo3_autorisatie(autorisatie_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

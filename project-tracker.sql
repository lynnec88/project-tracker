--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Homebrew)
-- Dumped by pg_dump version 14.7 (Homebrew)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: grades; Type: TABLE; Schema: public; Owner: chenlinglin
--

CREATE TABLE public.grades (
    id integer NOT NULL,
    student_github character varying(30),
    project_title character varying(30),
    grade integer
);


ALTER TABLE public.grades OWNER TO chenlinglin;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: chenlinglin
--

CREATE SEQUENCE public.grades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grades_id_seq OWNER TO chenlinglin;

--
-- Name: grades_id_seq1; Type: SEQUENCE; Schema: public; Owner: chenlinglin
--

CREATE SEQUENCE public.grades_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grades_id_seq1 OWNER TO chenlinglin;

--
-- Name: grades_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: chenlinglin
--

ALTER SEQUENCE public.grades_id_seq1 OWNED BY public.grades.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: chenlinglin
--

CREATE TABLE public.projects (
    title character varying(30) NOT NULL,
    description text,
    max_grade integer
);


ALTER TABLE public.projects OWNER TO chenlinglin;

--
-- Name: students; Type: TABLE; Schema: public; Owner: chenlinglin
--

CREATE TABLE public.students (
    github character varying(30),
    first_name character varying(30),
    last_name character varying(30),
    cohort character varying(20)
);


ALTER TABLE public.students OWNER TO chenlinglin;

--
-- Name: report_card_view; Type: VIEW; Schema: public; Owner: chenlinglin
--

CREATE VIEW public.report_card_view AS
 SELECT students.first_name,
    students.last_name,
    projects.title,
    projects.max_grade,
    grades.grade
   FROM ((public.students
     JOIN public.grades ON (((students.github)::text = (grades.student_github)::text)))
     JOIN public.projects ON (((projects.title)::text = (grades.project_title)::text)));


ALTER TABLE public.report_card_view OWNER TO chenlinglin;

--
-- Name: grades id; Type: DEFAULT; Schema: public; Owner: chenlinglin
--

ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq1'::regclass);


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: chenlinglin
--

COPY public.grades (id, student_github, project_title, grade) FROM stdin;
1	jhacks	Markov	10
2	jhacks	Blockly	2
3	sdevelops	Markov	50
4	sdevelops	Blockly	100
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: chenlinglin
--

COPY public.projects (title, description, max_grade) FROM stdin;
Markov	Tweets generated from Markov chains	50
Blockly	Programmatic Logic Puzzle Game	100
Pooh	Finding Honey	80
Lynne	Sign Language	85
Worm	Flying through wormhole	60
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: chenlinglin
--

COPY public.students (github, first_name, last_name, cohort) FROM stdin;
jhacks	Jane	Hacker	\N
sdevelops	Sarah	Developer	\N
\.


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chenlinglin
--

SELECT pg_catalog.setval('public.grades_id_seq', 1, false);


--
-- Name: grades_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: chenlinglin
--

SELECT pg_catalog.setval('public.grades_id_seq1', 4, true);


--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: chenlinglin
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: students unique_github_username; Type: CONSTRAINT; Schema: public; Owner: chenlinglin
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT unique_github_username UNIQUE (github);


--
-- Name: projects unique_project_title; Type: CONSTRAINT; Schema: public; Owner: chenlinglin
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT unique_project_title UNIQUE (title);


--
-- Name: grades grades_project_title_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chenlinglin
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_project_title_fkey FOREIGN KEY (project_title) REFERENCES public.projects(title);


--
-- Name: grades grades_student_github_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chenlinglin
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_student_github_fkey FOREIGN KEY (student_github) REFERENCES public.students(github);


--
-- PostgreSQL database dump complete
--


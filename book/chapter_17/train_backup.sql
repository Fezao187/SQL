PGDMP  ,    )                |            analysis    16.3    16.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    19330    analysis    DATABASE     �   CREATE DATABASE analysis WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_South Africa.1252';
    DROP DATABASE analysis;
                postgres    false                       1259    32123    grades    TABLE     �   CREATE TABLE public.grades (
    student_id bigint NOT NULL,
    course_id bigint NOT NULL,
    course character varying(30) NOT NULL,
    grade character varying(5) NOT NULL
);
    DROP TABLE public.grades;
       public         heap    postgres    false            �          0    32123    grades 
   TABLE DATA           F   COPY public.grades (student_id, course_id, course, grade) FROM stdin;
    public          postgres    false    281   �                  2606    32127    grades grades_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (student_id, course_id);
 <   ALTER TABLE ONLY public.grades DROP CONSTRAINT grades_pkey;
       public            postgres    false    281    281                       2620    32134    grades grades_update    TRIGGER     {   CREATE TRIGGER grades_update AFTER UPDATE ON public.grades FOR EACH ROW EXECUTE FUNCTION public.record_if_grade_changed();
 -   DROP TRIGGER grades_update ON public.grades;
       public          postgres    false    281            �   M   x�3�4�t�K��,�P04t�t�2�4��/�IQ��,.�/��;�M8C�2��8��CN������J ߙ+F��� �R     
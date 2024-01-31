INSERT ALL
	INTO "rooms" ("r_id", "r_name", "r_space") VALUES (1, N'������� � ����� ������������', 5)
	INTO "rooms" ("r_id", "r_name", "r_space") VALUES (2, N'������� � ����� ������������', 5)
	INTO "rooms" ("r_id", "r_name", "r_space") VALUES (3, N'������ ������� 1', 2)
	INTO "rooms" ("r_id", "r_name", "r_space") VALUES (4, N'������ ������� 2', 2)
	INTO "rooms" ("r_id", "r_name", "r_space") VALUES (5, N'������ ������� 3', 2)
SELECT 1 FROM "DUAL";

INSERT ALL
	INTO "computers" ("c_id", "c_room", "c_name") VALUES (1, 1, N'��������� A � ������� 1')
	INTO "computers" ("c_id", "c_room", "c_name") VALUES (2, 1, N'��������� B � ������� 1')
	INTO "computers" ("c_id", "c_room", "c_name") VALUES (3, 2, N'��������� A � ������� 2')
	INTO "computers" ("c_id", "c_room", "c_name") VALUES (4, 2, N'��������� B � ������� 2')
	INTO "computers" ("c_id", "c_room", "c_name") VALUES (5, 2, N'��������� C � ������� 2')
	INTO "computers" ("c_id", "c_room", "c_name") VALUES (6, NULL, N'��������� ��������� A')
	INTO "computers" ("c_id", "c_room", "c_name") VALUES (7, NULL, N'��������� ��������� B')
	INTO "computers" ("c_id", "c_room", "c_name") VALUES (8, NULL, N'��������� ��������� C')
SELECT 1 FROM "DUAL";


INSERT ALL
  INTO "library_in_json" ("lij_id", "lij_book", "lij_author", "lij_genre")
   VALUES (1, N'������� ������', N'[{"id":7,"name":"�.�. ������"}]',
              N'[{"id":1,"name":"������"},{"id":5,"name":"��������"}]')
  INTO "library_in_json" ("lij_id", "lij_book", "lij_author", "lij_genre")
   VALUES (2, N'������ � ������ � �����',
              N'[{"id":7,"name":"�.�. ������"}]',
              N'[{"id":1,"name":"������"},{"id":5,"name":"��������"}]')
  INTO "library_in_json" ("lij_id", "lij_book", "lij_author", "lij_genre")
   VALUES (3, N'��������� � �������', N'[{"id":2,"name":"�. ������"}]',
              N'[{"id":6,"name":"����������"}]')
  INTO "library_in_json" ("lij_id", "lij_book", "lij_author", "lij_genre")
   VALUES (4, N'���������� ����������������',
              N'[{"id":3,"name":"�. �������"},
                 {"id":6,"name":"�. ����������"}]',
              N'[{"id":2,"name":"����������������"},
                 {"id":3,"name":"����������"}]')
  INTO "library_in_json" ("lij_id", "lij_book", "lij_author", "lij_genre")
   VALUES (5, N'���� ���������������� �++',
              N'[{"id":6,"name":"�. ����������"}]', 
              N'[{"id":2,"name":"����������������"}]')
  INTO "library_in_json" ("lij_id", "lij_book", "lij_author", "lij_genre")
   VALUES (6, N'���� ������������� ������',
              N'[{"id":4,"name":"�.�. ������"},
                 {"id":5,"name":"�.�. ������"}]',
              N'[{"id":5,"name":"��������"}]')
  INTO "library_in_json" ("lij_id", "lij_book", "lij_author", "lij_genre")
   VALUES (7, N'��������� ����������������',
              N'[{"id":1,"name":"�. ����"}]',
              N'[{"id":2,"name":"����������������"},
                 {"id":5,"name":"��������"}]')
SELECT 1 FROM "DUAL";



ALTER TRIGGER "TRG_site_pages_sp_id" DISABLE;
INSERT ALL
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (1, NULL, N'�������')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (2, 1, N'���������')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (3, 1, N'���������')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (4, 1, N'��������������')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (5, 2, N'�������')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (6, 2, N'����������')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (7, 3, N'�����������')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (8, 3, N'������� ������')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (9, 4, N'�����')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (10, 1, N'��������')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (11, 3, N'���������')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (12, 6, N'�������')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (13, 6, N'��������')
 INTO "site_pages" ("sp_id", "sp_parent", "sp_name") VALUES (14, 6, N'�������������')
SELECT 1 FROM "DUAL";
ALTER TRIGGER "TRG_site_pages_sp_id" ENABLE;

ALTER TRIGGER "TRG_cities_ct_id" DISABLE;
INSERT ALL
 INTO "cities" ("ct_id", "ct_name") VALUES (1, N'������')
 INTO "cities" ("ct_id", "ct_name") VALUES (2, N'�����')
 INTO "cities" ("ct_id", "ct_name") VALUES (3, N'������')
 INTO "cities" ("ct_id", "ct_name") VALUES (4, N'�����')
 INTO "cities" ("ct_id", "ct_name") VALUES (5, N'������')
 INTO "cities" ("ct_id", "ct_name") VALUES (6, N'����')
 INTO "cities" ("ct_id", "ct_name") VALUES (7, N'�����')
 INTO "cities" ("ct_id", "ct_name") VALUES (8, N'����')
 INTO "cities" ("ct_id", "ct_name") VALUES (9, N'�������')
 INTO "cities" ("ct_id", "ct_name") VALUES (10, N'������')
SELECT 1 FROM "DUAL";
ALTER TRIGGER "TRG_cities_ct_id" ENABLE;

INSERT ALL
 INTO "connections" ("cn_from", "cn_to", "cn_cost", "cn_bidir") VALUES(1, 5, 10, 'Y')
 INTO "connections" ("cn_from", "cn_to", "cn_cost", "cn_bidir") VALUES(1, 7, 20, 'N')
 INTO "connections" ("cn_from", "cn_to", "cn_cost", "cn_bidir") VALUES(7, 1, 25, 'N')
 INTO "connections" ("cn_from", "cn_to", "cn_cost", "cn_bidir") VALUES(7, 2, 15, 'Y')
 INTO "connections" ("cn_from", "cn_to", "cn_cost", "cn_bidir") VALUES(2, 6, 50, 'N')
 INTO "connections" ("cn_from", "cn_to", "cn_cost", "cn_bidir") VALUES(6, 8, 40, 'Y')
 INTO "connections" ("cn_from", "cn_to", "cn_cost", "cn_bidir") VALUES(8, 4, 30, 'N')
 INTO "connections" ("cn_from", "cn_to", "cn_cost", "cn_bidir") VALUES(4, 8, 35, 'N')
 INTO "connections" ("cn_from", "cn_to", "cn_cost", "cn_bidir") VALUES(8, 9, 15, 'Y')
 INTO "connections" ("cn_from", "cn_to", "cn_cost", "cn_bidir") VALUES(9, 1, 20, 'N')
 INTO "connections" ("cn_from", "cn_to", "cn_cost", "cn_bidir") VALUES(7, 3, 5, 'N')
 INTO "connections" ("cn_from", "cn_to", "cn_cost", "cn_bidir") VALUES(3, 6, 5, 'N')
SELECT 1 FROM "DUAL";


INSERT ALL
 INTO "shopping" ("sh_id", "sh_transaction", "sh_category")
  VALUES (1, 1, N'�����')
 INTO "shopping" ("sh_id", "sh_transaction", "sh_category")
  VALUES(2, 1, N'������')
 INTO "shopping" ("sh_id", "sh_transaction", "sh_category")
  VALUES(3, 1, N'�����')
 INTO "shopping" ("sh_id", "sh_transaction", "sh_category")
  VALUES(4, 2, N'�����')
 INTO "shopping" ("sh_id", "sh_transaction", "sh_category")
  VALUES(5, 2, N'����')
 INTO "shopping" ("sh_id", "sh_transaction", "sh_category")
  VALUES(6, 3, N'������')
 INTO "shopping" ("sh_id", "sh_transaction", "sh_category")
  VALUES(7, 3, N'����')
 INTO "shopping" ("sh_id", "sh_transaction", "sh_category")
  VALUES(8, 3, N'�����')
 INTO "shopping" ("sh_id", "sh_transaction", "sh_category")
  VALUES(9, 3, N'������')
 INTO "shopping" ("sh_id", "sh_transaction", "sh_category")
  VALUES(10, 4, N'�����')
SELECT 1 FROM "DUAL";
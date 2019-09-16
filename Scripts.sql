
--
--Create and Constraint Script

/*
    4.
    Create Types - object/varray/nested table
*/

-- Object type - Create object type named t_address with attributes of implicit types
CREATE TYPE address_type AS OBJECT (
   street        VARCHAR2 (50),
   city          VARCHAR2 (50),
   state         VARCHAR2 (50),
   country       VARCHAR2 (50),
   postal_code   VARCHAR2 (20)
);
/
/*


*/

-- Nested table of type charater - Create type phone_number
CREATE OR REPLACE TYPE phone_number_table_type AS TABLE OF VARCHAR2 (20);
/


-- Object type - Create object type named room_type
CREATE TYPE room_type AS OBJECT (
   floor          NUMBER (5),
   colour         VARCHAR2 (20),
   square_meters  NUMBER (10)
);
/


-- Object type - Create object type named factory_type
CREATE OR REPLACE TYPE factory_type AS OBJECT (
   factory_name     VARCHAR2 (50),
   factory_address  ADDRESS_type
);
/


-- Variable array - Create type factory_varray_type
CREATE OR REPLACE TYPE factory_varray_type AS VARRAY (5) OF factory_type;
/


-- Variable array - VARRAY to store customer details

-- Used in Functions
CREATE OR REPLACE TYPE cust_details_varray_type AS VARRAY (6) OF VARCHAR2 (100);
/


-- Object type -  Object with 2 variables
CREATE OR REPLACE TYPE address_fields_type AS OBJECT (
   field  VARCHAR2 (20),
   value  VARCHAR2 (100)
);
/


-- Nested Table to store customer details
--Used In functions
CREATE OR REPLACE TYPE customer_details_table_type AS TABLE OF address_fields_type;
/



/*
    5.
    Create Table
*/

-- Create table customer, where object type address is used to define an individual attribute address
--                        objects subsequently stored in that column are known as column objects.
CREATE TABLE customers
(
    customer_id       NUMBER (10),
    first_name        VARCHAR2(30)        NOT NULL,
    last_name         VARCHAR2(30),
    customer_address  ADDRESS_type        NOT NULL,
    phone_number      phone_number_table_type
)
NESTED TABLE phone_number STORE AS nested_phone_number;


-- Create table customer_room
CREATE TABLE customer_rooms
(
    cust_room    NUMBER (10),
    customer_id  NUMBER (10) NOT NULL,
    room_no      VARCHAR2(5)  NOT NULL,
    room_desc    ROOM_TYPE
);




-- Create table manufacturer

CREATE TABLE manufacturers
(
    manufacturer_id       NUMBER (10),
    manufacturer_name     VARCHAR2(50)         NOT NULL,
    manufacturer_address  ADDRESS_TYPE,
    factories             FACTORY_VARRAY_TYPE
);


-- Create table accessory
CREATE TABLE accessories
(
    accessory_id     NUMBER (10),
    accessory_name   VARCHAR2(50)  NOT NULL,
    manufacturer_id  NUMBER (10) NOT NULL,
    price            NUMBER (10,3)        NOT NULL,
    quantity         NUMBER (10)        NOT NULL
);


-- Create table accessory_used
CREATE TABLE accessories_used
(
    accessory_used_id  NUMBER (10),
    cust_room          NUMBER (10),
    accessory_id       NUMBER (10) NOT NULL,
    qty_used           NUMBER (10)   NOT NULL,
    date_used          DATE     DEFAULT SYSDATE NOT NULL
);

SELECT * FROM TAB;
DESC customers;
DESC customer_rooms;
DESC manufacturers;
DESC accessories;
DESC accessories_used;


/*
    6.
    Alter Statements to add PK/FK
*/

ALTER TABLE customers ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);

ALTER TABLE customer_rooms ADD CONSTRAINT pk_customer_rooms PRIMARY KEY (cust_room);
ALTER TABLE customer_rooms ADD CONSTRAINT fk_c_customers FOREIGN KEY (customer_id) REFERENCES customers (customer_id);



ALTER TABLE manufacturers ADD CONSTRAINT pk_manufacturers PRIMARY KEY (manufacturer_id);

ALTER TABLE accessories ADD CONSTRAINT pk_accessories PRIMARY KEY (accessory_id);
ALTER TABLE accessories ADD CONSTRAINT fk_a_manufacturers FOREIGN KEY (manufacturer_id) REFERENCES manufacturers (manufacturer_id);

ALTER TABLE accessories_used ADD CONSTRAINT pk_accessories_used PRIMARY KEY (accessory_used_id);
ALTER TABLE accessories_used ADD CONSTRAINT fk_au_cust_rooms FOREIGN KEY (cust_room) REFERENCES customer_rooms (cust_room);
ALTER TABLE accessories_used ADD CONSTRAINT fk_au_accessories FOREIGN KEY (accessory_id) REFERENCES accessories (accessory_id);



/*
    7.
    Create Sequence
*/

CREATE SEQUENCE s_customer START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE s_customer_room START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE s_manufacturer START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE s_accessory START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE s_accessory_used START WITH 1 INCREMENT BY 1;

SELECT sequence_name FROM user_sequences;





--Insert Script




--By default, SQL Plus treats '&' as a special character that begins a substitution string.
--This can cause problems when running scripts that happen to include '&' for other reasons:
--set define off to switch off the behaviour while running the script:

SET DEFINE OFF

--Delete from tables
DELETE FROM accessories_used;
DELETE FROM accessories;
DELETE FROM manufacturers;
DELETE FROM customer_rooms;
DELETE FROM customers;
COMMIT;


-- INSERT INTO table customers
--street city state postal code
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Steven', 'King', address_type('Egnatias 12', 'Roma', '', 'Italy', '2310445'), phone_number_table_type('515.123.4567', '515.123.4578'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Milena', 'Maniani', address_type('Xaldias 12', 'Thessaloniki', '', 'Greece', '2394839'), phone_number_table_type('515.123.4568'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Lex', 'Voras', address_type('Pontou', 'Tokyo', 'Tokyo Prefecture', 'Japan', '1689'), phone_number_table_type('515.123.4569'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Alexander', 'Ibraimovic', address_type('Parodos xiou', 'Nikopolh', '', 'Greece', '53943'), phone_number_table_type('590.423.4567'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Bruce', 'Wayne', address_type('Arkham', 'Gotham', 'Texas', 'United States of America', '34242'), phone_number_table_type('6949101032'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'David', 'Austin', address_type('2011 Boulevard', 'South San Francisco', 'California', 'United States of America', '2310433245'), phone_number_table_type('2541048938'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Vallia', 'Mpoukouvala', address_type('2007 Zagora St', 'Zagorxwria', 'Giannena', 'Greece', '24630453453'), phone_number_table_type('2104332424'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Diana', 'Lorentzakou', address_type('Vardari 12', 'Seattle', 'Washington', 'United States of America', '98199'), phone_number_table_type('69843432'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Nancy', 'Alexiadou', address_type('Lewfoross Nikis 56', 'Toronto', 'Ontario', 'Canada', '342342'), phone_number_table_type('34984234'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Daniel', 'Dousko', address_type('Vardari 30', 'Hgoumenitsa', 'Axladoxwri', 'Greece', '3214'), phone_number_table_type('2310445324'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'John', 'Tikis', address_type('Ethnikis Aminis 4', 'Beijing', '', 'Republic of China', '190518'), phone_number_table_type('694910132', '2310445231', '432343'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Ismael', 'Zanoudakis', address_type('Fleming 4', 'Bombay', 'Xalastra', 'India', '490231'), phone_number_table_type('0909324324'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Uma', 'Therman', address_type('Ligdon 10', 'Ampelokipoi', 'Thessaloniki', 'Greece', '2901'), phone_number_table_type('34039293'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Luis', 'Vuiton', address_type('Klementinou 45', 'Singapore', '', 'Singapore', '540198'), phone_number_table_type('693210293'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Den', 'Raphaely', address_type('Agias sofias 41', 'London', '', 'United Kingdom', ''), phone_number_table_type('3420393'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Alexander', 'TheGreat', address_type('Magdalinis 45, Votsi', 'Oxford', 'Oxford', 'United Kingdom', '54945'), phone_number_table_type('33656578'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Thomas', 'Shelby', address_type('Basilisis Olgas 32', 'Stretford', 'Manchester', 'United Kingdom', '09629850293'), phone_number_table_type('454754'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Steven', 'Seagal', address_type('Petrou Sindika 4', 'Munich', 'Bavaria', 'Germany', '80925'), phone_number_table_type('210343432'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Gus', 'Garamitroudis', address_type('Alejandrou 21 ', 'Sao Paulo', 'Sao Paulo', 'Brazil', '01307-002'), phone_number_table_type('52576734'));
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(s_customer.nextval, 'Karen', 'Colmenares', address_type('Proksenou Koromila', 'Geneva', 'Geneve', 'Switzerland', '1730'), phone_number_table_type('69321002', '0035722313898'));
COMMIT;


-- INSERT INTO table customer_rooms
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 10, 'R1', room_type(1, 'yellow', 100));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 10, 'R2', room_type(1, 'green', 120));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 11, 'R1', room_type(3, 'red', 135));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 11, 'R2', room_type(1, 'blue', 100));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 12, 'R1', room_type(1, 'yellow', 120));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 12, 'R2', room_type(1, 'green', 155));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 13, 'R1', room_type(7, 'red', 135));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 13, 'R2', room_type(1, 'yellow', 100));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 14, 'R1', room_type(1, 'blue', 155));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 14, 'R2', room_type(1, 'yellow', 120));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 15, 'R1', room_type(1, 'blue', 100));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 15, 'R2', room_type(1, 'green', 135));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 16, 'R1', room_type(1, 'yellow', 155));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 16, 'R2', room_type(1, 'red', 120));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 17, 'R1', room_type(2, 'yellow', 100));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 18, 'R1', room_type(1, 'blue', 135));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 18, 'R2', room_type(7, 'green', 100));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 18, 'R3', room_type(3, 'yellow', 120));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 19, 'R1', room_type(1, 'red', 135));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 19, 'R2', room_type(1, 'yellow', 135));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 2, 'R1', room_type(1, 'blue', 155));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 2, 'R2', room_type(1, 'green', 120));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 3, 'R1', room_type(2, 'yellow', 100));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 3, 'R2', room_type(1, 'blue', 100));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 4, 'R1', room_type(1, 'red', 135));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 4, 'R2', room_type(1, 'yellow', 120));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 5, 'R1', room_type(2, 'green', 155));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 5, 'R2', room_type(1, 'yellow', 100));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 6, 'R1', room_type(3, 'blue', 135));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 6, 'R2', room_type(1, 'red', 100));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 7, 'R1', room_type(1, 'green', 155));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 7, 'R2', room_type(7, 'yellow', 120));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 8, 'R1', room_type(1, 'blue', 135));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 9, 'R1', room_type(3, 'green', 155));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 9, 'R2', room_type(1, 'red', 100));
INSERT INTO customer_rooms(cust_room, customer_id, room_no, room_desc) VALUES(s_customer_room.nextval, 9, 'R3', room_type(2, 'yellow', 155));
COMMIT;



--street city state postal code
-- INSERT INTO table manufacturers
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Mimikos', ADDRESS_type('Karolou Nthl 12', 'Kalamaria', 'Thesssaloniki,', 'Greece', '55133'),
           factory_varray_type(factory_type('Mimikos Mex', ADDRESS_type('Makedonomaxwn 52', 'Ptolemaida', 'Eordaia,', 'Greece', '55227'))));
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Neoset', ADDRESS_type('Sofouli 32', 'Florina', 'Florina', 'Albania', '3029SK'),
           factory_varray_type(factory_type('Neoset Design', ADDRESS_type('Olgas 32', 'Kastoria', 'Kastoria', 'Armenia', '3429SK'))));
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Ikea', ADDRESS_type('Aerodromiou 32', 'Foinikas', 'Kalamaria', 'Greece', '3095'),
           factory_varray_type(factory_type('JB', ADDRESS_type('Kyprianou 32', 'Strovolos', 'Nicosia', 'Cyprus', '3095'))));
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Salt and Pepper', ADDRESS_type('Karfouroudi 12', 'Kalamaria', 'Thessaloniki', 'Greece', '552021'),
           factory_varray_type(factory_type('Salt and Pepper Plates', ADDRESS_type('Mariano Esco bedo 9990', 'Mexico City', 'Distrito Federal,', 'Mexico', '11932')),
                               factory_type('Salt & Pepper Inc', ADDRESS_type('Marmelado 41', 'Mexico City', 'Distrito Federal,', 'Mexico', '11932'))));
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'WestSode', ADDRESS_type('Brazilias 43 ', 'Sao Paulo', 'Sao Paulo', 'Brazil', '43242'), NULL);
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Salah Akum', ADDRESS_type('Alaxuntour 32', 'Cairo', '', 'Egypt', '80925'), NULL);
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Loreal', ADDRESS_type(' Chester Road 32', 'Stretford', 'Manchester', 'United Kingdom', '09629850293'), NULL);
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Electric Time Company', ADDRESS_type('Magdalen Centre, The Oxford Science Park', 'Oxford', 'Oxford', 'United Kingdom', '5658'), NULL);
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Standard Electric Time Company', ADDRESS_type('8204 Arthur St', 'London', '', 'United Kingdom', ''),
           factory_varray_type(factory_type('Standard Electric', ADDRESS_type('8203 Arthur St', 'London', '', 'United Kingdom', '')),
                               factory_type('Time Company', ADDRESS_type('8204 Arthur St', 'London', '', 'United Kingdom', ''))));
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Q Telecom', ADDRESS_type('Don Xose 32', 'Madrid', '', 'Vallencia', '540198'),
           factory_varray_type(factory_type('Telecom', ADDRESS_type('Don Julio 37', 'Madrid', '', 'Spain', '540132'))));
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Westclox', ADDRESS_type('12-98 Victoria Street', 'Sydney', 'New South Wales', 'Australia', '2901'), NULL);
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Winterhalder & Hofmeier', ADDRESS_type('1298 Vileparle (E)', 'Bombay', 'Maharashtra', 'India', '490231'), NULL);
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Seiko', ADDRESS_type('Mao Che Tung 32', 'Beijing', '', 'Republic of China', '190518'),
           factory_varray_type(factory_type('Seiko', ADDRESS_type('Mao Che Tung 36', 'Beijing', '', 'Republic of China', '190518'))));
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Comadur', ADDRESS_type('6092 Boxwood St', 'Whitehorse', 'Yukon', 'Canada', 'YSW 9T2'), NULL);
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Jaeger-LeCoultre', ADDRESS_type('147 Spadina Ave', 'Toronto', 'Ontario', 'Canada', 'M5V 2L7'), NULL);
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Tavanoprokes', ADDRESS_type('Chin Chan Chon 324', 'Taiwan', 'Taiwan', 'Republic of China', '98199'), NULL);
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Pagouria', ADDRESS_type('2007 Zagoroxwria St', 'Ioannina', 'Ioannina', 'Greece', '50090'), NULL);
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Heineken', ADDRESS_type('District 9', 'Amsterdam', 'Amsterdam', 'Netherlands', '99236'), NULL);
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Century', ADDRESS_type('8 Mile Road', 'Detroit', 'Michigan', 'United States of America', '9999'), NULL);
INSERT INTO manufacturers(manufacturer_id, manufacturer_name, manufacturer_address, factories)
    VALUES(s_manufacturer.nextval, 'Siemens', ADDRESS_type('Wall street 21', 'Hiroshima', '', 'Japan', '6823'),
           factory_varray_type(factory_type('Siemens Electrics', ADDRESS_type('Alexandras Boulevard', 'Cairo', '', 'Egypt', '3254')),
                               factory_type('Siemens Luxury', ADDRESS_type('Tositsa 32', 'Athens', '', 'Greece', '3215')),
                               factory_type('Siemens Centre', ADDRESS_type('Nautilon 21', 'Malta', '', 'Malta', ''))));
COMMIT;


-- INSERT INTO table accessories
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Vintage Clock', 1, 772, 7);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Terracotta Vase', 2, 128.64, 6);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Festive Diya', 3, 774.74, 17);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Document Organiser', 4, 116.06, 11);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Exotic Bonsai', 5, 434.89, 17);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Name Plate', 6, 932.47, 17);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Planter Stand', 7, 156.45, 1);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Bird House', 8, 931.02, 8);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Coffee Table Book', 9, 891.5, 14);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Wall Clock', 10, 496.07, 14);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Kids Clock', 11, 923.62, 11);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Wall Accent', 12, 809.35, 12);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Photo Frame', 13, 762.56, 15);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Art Panel', 14, 840.74, 11);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Painting', 15, 780.96, 8);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Key Holder', 1, 732.98, 13);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Ethnic Art', 2, 976.73, 18);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Poster', 3, 793.6, 2);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Wall Sticker', 4, 888.59, 7);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Human Figure', 5, 187.86, 16);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Animal Figure', 6, 695.25, 13);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Fridge Magnet', 7, 657.06, 17);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Idol', 8, 189.7, 4);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Miniature', 9, 684.88, 4);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Curio', 10, 770.2, 15);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Vintage Clock', 11, 822.62, 2);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Terracotta Vase', 12, 268.73, 13);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Document Organiser', 13, 247.81, 13);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Name Plate', 14, 317.79, 12);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Planter Stand', 15, 974.83, 10);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Bird House', 16, 533.21, 2);
INSERT INTO accessories(accessory_id, accessory_name, manufacturer_id, price, quantity) VALUES(s_accessory.nextval, 'Coffee Table Book', 17, 295.97, 2);



-- INSERT INTO table accessories_used
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 1, 3, 1, to_date('27-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 2, 4, 1, to_date('06-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 3, 5, 1, to_date('31-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 4, 6, 1, to_date('05-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 5, 7, 3, to_date('16-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 6, 8, 1, to_date('09-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 7, 9, 1, to_date('06-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 8, 10, 1, to_date('28-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 9, 11, 3, to_date('03-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 10, 12, 1, to_date('27-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 11, 13, 1, to_date('28-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 12, 14, 1, to_date('24-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 13, 15, 3, to_date('28-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 14, 16, 1, to_date('11-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 15, 17, 1, to_date('08-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 16, 18, 1, to_date('22-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 17, 19, 3, to_date('21-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 18, 20, 1, to_date('01-03-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 19, 21, 1, to_date('21-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 20, 22, 1, to_date('05-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 21, 23, 1, to_date('22-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 22, 24, 1, to_date('26-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 23, 25, 3, to_date('05-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 24, 26, 1, to_date('28-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 25, 27, 1, to_date('28-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 26, 28, 1, to_date('28-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 27, 29, 1, to_date('19-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used) VALUES(s_accessory_used.nextval, 28, 30, 4);
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 29, 31, 1, to_date('02-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 30, 32, 1, to_date('22-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 31, 3, 1, to_date('30-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 32, 5, 2, to_date('22-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 33, 6, 2, to_date('18-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 34, 17, 2, to_date('09-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 35, 8, 2, to_date('30-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 36, 9, 1, to_date('27-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 36, 10, 2, to_date('15-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 36, 11, 2, to_date('14-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 7, 12, 2, to_date('29-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 8, 13, 2, to_date('09-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 9, 14, 4, to_date('02-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 10, 15, 2, to_date('09-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 11, 16, 2, to_date('26-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 12, 17, 2, to_date('22-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 13, 18, 2, to_date('11-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 14, 19, 2, to_date('22-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 15, 20, 2, to_date('25-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 16, 21, 3, to_date('22-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 17, 22, 2, to_date('30-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used) VALUES(s_accessory_used.nextval, 18, 23, 2);
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 7, 24, 2, to_date('20-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 8, 25, 2, to_date('23-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 9, 26, 4, to_date('25-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 10, 27, 2, to_date('23-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 11, 28, 2, to_date('06-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 12, 29, 2, to_date('03-02-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 13, 26, 1, to_date('27-01-18', 'DD-MM-YY'));
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used) VALUES(s_accessory_used.nextval, 14, 27, 1);
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used) VALUES(s_accessory_used.nextval, 15, 31, 2);
INSERT INTO accessories_used (accessory_used_id, cust_room, accessory_id, qty_used, date_used) VALUES(s_accessory_used.nextval, 15, 32, 2, to_date('28-02-18', 'DD-MM-YY'));
COMMIT;


--Functions Script



-- SQL Functions used: upper, trunc, sum, nvl, concat, union, trim, to_char, substr, instr
SET SERVEROUTPUT ON



DROP FUNCTION f_manufacturer_sellings;
DROP FUNCTION f_cust_name;
DROP FUNCTION objtocol2;
DROP FUNCTION objtocoll;
DROP FUNCTION f_get_payment_amount;
DROP FUNCTION f_update_accessory_price;


/*
    1.
    Increase/Decrease the accessory price and return the percentage increase/decrease in price.
*/

CREATE OR REPLACE FUNCTION f_update_accessory_price (
    p_accessory_name VARCHAR2,
    p_new_price NUMBER
) RETURN NUMBER IS

    -- local variables
    l_return      NUMBER := 0;
    l_old_price   NUMBER;

    -- cursor to fetch accessory_price from accessory table using accessory_name
    CURSOR c_rec IS SELECT
        price
                    FROM
        accessories
                    WHERE
        upper(accessory_name) = upper(p_accessory_name); -- both will be compared in uppercase

BEGIN
    -- cursor to fetch accessory_price from accessory table using accessory_name parameter p_accessory_name
    OPEN c_rec;
    FETCH c_rec INTO l_old_price;
    CLOSE c_rec;

    -- if accessory exists then increase or decrease the price
    IF
        l_old_price IS NOT NULL
    THEN
        -- update the price from old to new value (which is p_new_price)
        UPDATE accessories
            SET
                price = p_new_price
        WHERE
            upper(accessory_name) = upper(p_accessory_name);

        -- calculate the price change in percentage
        -- provide the value in 4 decimal places multiply by 100
        l_return := trunc( ( p_new_price - l_old_price ) / l_old_price , 4) * 100;

        -- print the percentage change in price of accessory
        dbms_output.put_line(l_return
        || '% change in price of accessory!');
        COMMIT;

    -- if accessory doesn't exist, print error
    ELSE
        dbms_output.put_line('Error: Accessory does not exist!');
    END IF;

    -- return value
    RETURN l_return;
EXCEPTION

    -- raise exception in case of any error
    WHEN OTHERS THEN
        raise_application_error(-20006,'Error: '
        || sqlerrm);
END f_update_accessory_price;
/


-- case I (when accessory does not exist)
DECLARE
    l_change_percantage NUMBER;
BEGIN
    l_change_percantage := f_update_accessory_price ('Ido', 200);
END;
/


-- case II (when price has increased)
DECLARE
    l_change_percantage NUMBER;
BEGIN
    l_change_percantage := f_update_accessory_price ('Idol', 200);
END;
/


-- case III (when price has decreased)
DECLARE
    l_change_percantage NUMBER;
BEGIN
    l_change_percantage := f_update_accessory_price ('Idol', 150);
END;
/





/*
    3.
    Function which takes customer address (object type) as an argument and returns varray table.
*/

CREATE OR REPLACE FUNCTION objtocoll (
    p_address address_type
) RETURN cust_details_varray_type IS
    l_varray_type   cust_details_varray_type;
BEGIN
    -- from customer address (object type) return street, city, state, country, postal_code (varray type)
    l_varray_type := cust_details_varray_type(
                        p_address.street,
                        p_address.city,
                        p_address.state,
                        p_address.country,
                        p_address.postal_code);
    RETURN l_varray_type;
END objtocoll;
/


-- test case I
SELECT
    *
FROM
    TABLE (
        SELECT
            objtocoll(customer_address)
        FROM
            customers
        WHERE
            customer_id = 1
    );



/*
    4.
    Function which takes customer address (object type) as an argument and returns nested table.
*/

CREATE OR REPLACE FUNCTION objtocoll2 (
    p_address address_type
) RETURN customer_details_table_type IS
    l_varray_type2   customer_details_table_type;
BEGIN
    -- from customer address (object type) return street, city, state, country, postal_code (nested table)
    l_varray_type2 := customer_details_table_type(
                        address_fields_type('Street',p_address.street),
                        address_fields_type('City',p_address.city),
                        address_fields_type('State',p_address.state),
                        address_fields_type('Country',p_address.country),
                        address_fields_type('Postal Code',p_address.postal_code));
    RETURN l_varray_type2;
END objtocoll2;
/


-- test case I
SELECT
    *
FROM
    TABLE (
        SELECT
            objtocoll2(customer_address)
        FROM
            customers
        WHERE
            customer_id = 1
    );



/*
    5.
    Return concatenated name of customer as (last_name, first_name).
    Take customer_id as input, fetch customer first and last name and return full name.
*/

CREATE OR REPLACE FUNCTION f_cust_name (
    p_cust_id NUMBER
) RETURN VARCHAR2 IS

    -- local variable
    v_name   VARCHAR2(100);

    -- cursor to take customer_id as input, and fetch customer first and last name
    CURSOR c_rec IS SELECT
        c.first_name,
        c.last_name
                    FROM
        customers c
                    WHERE
        c.customer_id = p_cust_id;

BEGIN
    -- concatenate first name and last name
    FOR rec IN c_rec LOOP
        v_name := concat(rec.last_name
        || ', ',rec.first_name);
    END LOOP;

    RETURN v_name; -- reutrn full name
END f_cust_name;
/


-- test case I
SELECT
    2,
    f_cust_name(2)
FROM
    dual
UNION
SELECT
    5,
    f_cust_name(5)
FROM
    dual;



/*
    6.
    Return the total amount of money made by specific manufacturer by selling it's respective accessories (till now).
*/

CREATE OR REPLACE FUNCTION f_manufacturer_sellings (
    p_manu_name VARCHAR2
) RETURN VARCHAR2 IS

    v_price   VARCHAR2(50);

    -- cursor to fetch accessory_amount * used_quantity_of_accessory
    CURSOR c_rec IS SELECT
        TRIM('.' FROM TO_CHAR(SUM(au.qty_used * a.price), 'FM9,999,999,990.999'))
                    FROM
        manufacturers m,
        accessories a,
        accessories_used au
                    WHERE
        upper(m.manufacturer_name) = upper(p_manu_name)
        AND   m.manufacturer_id = a.manufacturer_id
        AND   a.accessory_id = au.accessory_id;

BEGIN
    -- cursor is using manufacturer's name as parameter
    OPEN c_rec;
    FETCH c_rec INTO v_price;
    CLOSE c_rec;
    RETURN v_price;
END f_manufacturer_sellings;
/


-- test case I
SELECT
    f_manufacturer_sellings('Mimikos')
FROM
    dual;





/*
    8.
    Given a person's full name extract his first name, using substr and instr in select statement.
*/

SELECT
    ( substr('Voula Vavatsi',1,instr('Voula Vavatsi',' ',1) - 1) ) domain
FROM
    dual;


--Procecures Script



SET SERVEROUTPUT ON


/*
    1.
    Create a procedure to return customer's list of phone numbers.
*/

CREATE OR REPLACE PROCEDURE p_customer_number (
    p_cust_id NUMBER,
    p_num OUT VARCHAR2
) IS

    v_count   NUMBER := 0;
    v_num     VARCHAR2(100);

    -- fetch customer's phone numbers
    CURSOR c_rec IS SELECT
        *
                    FROM
        TABLE (
            SELECT
                phone_number
            FROM
                customers
            WHERE
                customer_id = p_cust_id
        );

BEGIN
    -- loop through the customer_id, and fetch all the phone numbers
    FOR rec IN c_rec LOOP
        v_count := v_count + 1;

        -- save comma separated values
        IF
            v_count = 1
        THEN
            v_num := rec.column_value;
        ELSE
            v_num := ( v_num
            || ', '
            || rec.column_value );
        END IF;

    END LOOP;

    p_num := v_num;
END p_customer_number;
/


-- test case
DECLARE
    v_num   VARCHAR2(100);
BEGIN
    p_customer_number(1,v_num);
    dbms_output.put_line('Customer 1 phone number list: '
    || v_num);
END;
/



/*
    2.
    Create a procedure to return customer's address as string.
*/

CREATE OR REPLACE PROCEDURE p_print_address (
    p_address address_type,
    p_address_string OUT VARCHAR2
)
    IS
BEGIN
    -- from the address (object type), return concatenated string as (street, city, state, country, postal_code)
    p_address_string := ( p_address.street
    || ', '
    || p_address.city
    || ', '
    || p_address.state
    || ', '
    || p_address.country
    || ', '
    || p_address.postal_code );
END p_print_address;
/


-- test case
DECLARE
    l_add   address_type;
    v_add   VARCHAR2(200);
BEGIN
    SELECT
        customer_address
    INTO
        l_add
    FROM
        customers
    WHERE
        customer_id = 1;

    p_print_address(l_add,v_add);
    dbms_output.put_line('Customer''s address: '
    || v_add);
END;
/








/*
    5.
    Procedure to return manufacturer's factory name and address.
    It takes manufacturer_id as input, and returns factory details as output (OUT variable - type string)
*/

CREATE OR REPLACE PROCEDURE p_manu_fctry (
    p_manu_id   NUMBER,
    p_fctry IN OUT VARCHAR2
) IS

    -- local variable
    l_count   NUMBER := 0;
    l_addr    VARCHAR2(200);

    -- local cursor to fetch factory details for respective manufacturer
    CURSOR c_rec IS SELECT
        *
                    FROM
        TABLE (
            SELECT
                factories
            FROM
                manufacturers
            WHERE
                manufacturer_id = p_manu_id
        );

BEGIN
    -- loop through all the factories (if multiple)
    FOR rec IN c_rec LOOP
        l_count := l_count + 1;

        -- get the factory address as string, from above created procedure.
        p_print_address(rec.factory_address,l_addr);

        -- prepare a concatenated list (comma separated string) of factories
        IF
            l_count > 1
        THEN
            p_fctry := ( p_fctry
            || ', ' );
        END IF;

        p_fctry := ( p_fctry
        || rec.factory_name
        || ' - ('
        || l_addr
        || ')' );

    END LOOP;
END p_manu_fctry;
/


-- test case
DECLARE
    v_fctry   VARCHAR2(500);
BEGIN
    p_manu_fctry(4,v_fctry);
    dbms_output.put_line('Manufacturer 4 has factory(s): '
    || v_fctry);
END;
/



/*
    6.
    Create a procedure to return manufacturer's name, address and factory details.
*/

CREATE OR REPLACE PROCEDURE p_view_manufacturer_info IS

    -- local variable
    l_count     NUMBER := 0;
    l_address   VARCHAR2(200);
    l_fctry     VARCHAR2(1000);

    -- plsql record type to store manufacturer's details
    TYPE r_manu IS RECORD ( id          manufacturers.manufacturer_id%TYPE,
    name        manufacturers.manufacturer_name%TYPE,
    address     manufacturers.manufacturer_address%TYPE,
    factories   manufacturers.factories%TYPE );

    -- nested table of plsql record type to store manufacturer's details
    TYPE t_manu IS
        TABLE OF r_manu;
    l_manu      t_manu;

    -- cursor to fetch all manufacturer details
    CURSOR c_det IS SELECT
        m.manufacturer_id,
        m.manufacturer_name,
        m.manufacturer_address,
        m.factories
                    FROM
        manufacturers m;

BEGIN
    -- open cursor, fetch details into variable and close
    OPEN c_det;
    FETCH c_det BULK COLLECT INTO l_manu;
    CLOSE c_det;

    -- loop through all the manufacturers
    FOR rec IN 1..l_manu.count LOOP
        l_count := l_count + 1;

        -- print header/heading
        IF
            l_count = 1
        THEN
            dbms_output.put_line('Total number of manufacturers: '
            || l_manu.count
            || chr(10) );
            dbms_output.put_line(rpad('MANUFACTURER NAME',50)
            || rpad('MANUFACTURER ADDRESS',100)
            || chr(10) );
        END IF;

        -- fetch address (from address object type to string) of manufacturer
        p_print_address(l_manu(rec).address,l_address);

        -- fetch factory details of manufacturer
        p_manu_fctry(l_manu(rec).id,l_fctry);

        -- print details
        dbms_output.put_line(rpad(l_manu(rec).name,50)
        || rpad(l_address,100)
        || chr(10)
        || 'Factory(s): '
        || l_fctry
        || chr(10) );

    END LOOP;
END p_view_manufacturer_info;
/


-- test case
BEGIN
    p_view_manufacturer_info;
END;
/



/*
    7.
    List all accessories under manufacturers.
*/

CREATE OR REPLACE PROCEDURE p_list_accessory IS

    -- local variables
    l_count   NUMBER := 0;
    l_acc     VARCHAR2(50);

    -- local cursor to fetch all manufacturer's details
    CURSOR c_manu IS SELECT
        m.manufacturer_id,
        m.manufacturer_name
                     FROM
        manufacturers m;

    -- local cursor to fetch all accessories under respective manufacturer
    CURSOR c_acc (
        p_manu_id NUMBER
    ) IS SELECT
        a.accessory_name
         FROM
        accessories a
         WHERE
        a.manufacturer_id = p_manu_id;

BEGIN
    -- print headers
    dbms_output.put_line(rpad('MANUFACTURER NAME',50)
    || rpad('ACCESSORY NAME',50)
    || chr(10) );

    -- loop through all the manufacturers
    FOR r_manu IN c_manu LOOP
        l_count := 0;
        l_acc := NULL;

        -- loop through all the accessories under manufacturer
        FOR r_acc IN c_acc(r_manu.manufacturer_id) LOOP
            l_count := l_count + 1;

            -- make a comma-separated list of accessories
            IF
                l_count > 1
            THEN
                l_acc := l_acc
                || ', ';
            END IF;
            l_acc := l_acc || r_acc.accessory_name;
        END LOOP;

        -- print details
        dbms_output.put_line(rpad(r_manu.manufacturer_name,50)
        || rpad(l_acc,50) );

    END LOOP;
END p_list_accessory;
/


-- test case
BEGIN
p_list_accessory;
END;
/


--Select Script



-- customer
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       c.customer_address.street,
       c.customer_address.city,
       c.customer_address.state,
       c.customer_address.country,
       c.customer_address.postal_code,
       c.phone_number
  FROM customers c;


-- customer_room
SELECT cr.cust_room,
       cr.customer_id,
       cr.room_no,
       cr.room_desc.floor,
       cr.room_desc.colour,
       cr.room_desc.square_meters
  FROM customer_rooms cr;




-- manufacturer
SELECT m.manufacturer_id,
       m.manufacturer_name,
       m.manufacturer_address.street,
       m.manufacturer_address.city,
       m.manufacturer_address.state,
       m.manufacturer_address.country,
       m.manufacturer_address.postal_code,
       m.factories
  FROM manufacturers m;


-- accessory
SELECT accessory_id,
       accessory_name,
       manufacturer_id,
       price,
       quantity
  FROM accessories;


-- accessory_used
SELECT accessory_used_id,
       cust_room,
       accessory_id,
       qty_used,
       date_used
  FROM accessories_used;


--Triggers script

SET SERVEROUTPUT ON


--Drop Triggers and Tables
DROP TRIGGER t_validate_country;
DROP TRIGGER t_ddl_trigger;
DROP TRIGGER t_initcap_name;
DROP TRIGGER t_check_accessory_date_used;
DROP TRIGGER t_session_logoff;
DROP TRIGGER t_session_logon;
DROP TABLE session_logs;
DROP TRIGGER t_log_customer_change;
DROP TABLE customer_logs;
DROP TRIGGER t_check_accessory_availability;


/*
    1.
    Before taking a new booking, check if product is in stock
    If yes, update the new quantity, after taking the booking.

    Trigger will work if there's an update or insert on accessory_used table.
*/

CREATE OR REPLACE TRIGGER t_check_accessory_availability BEFORE
    INSERT OR UPDATE ON accessories_used
    FOR EACH ROW

DECLARE
    -- cursor to get accessory details using accessory_id
    CURSOR c_accessory_qty (
        p_accessory_id VARCHAR2
    ) IS SELECT
        accessory_name,
        quantity
         FROM
        accessories
         WHERE
        accessory_id = p_accessory_id;

BEGIN
    -- loop through the specific accessory
    FOR rec IN c_accessory_qty(:new.accessory_id) LOOP

        -- if quantity in stock >= booked quantity
        IF
            rec.quantity >=:new.qty_used
        THEN
            -- update the accessory in stock (accessory table)
            UPDATE accessories
                SET
                    quantity = ( quantity -:new.qty_used )
            WHERE
                accessory_id =:new.accessory_id;

        -- if quantity in stock < booked quantity
        ELSE
            -- raise exception
            raise_application_error(-20005,'Error: There are only '
            || rec.quantity
            || ' '
            || rec.accessory_name
            || ' in the stock!');
        END IF;
    END LOOP;
END t_check_accessory_availability;
/


-- check current available qty
SELECT
    accessory_name,
    quantity
FROM
    accessories
WHERE
    accessory_id = '32';


-- test case I
-- It will not let you insert a record, because quantity is not available in stock.
INSERT INTO accessories_used (
    accessory_used_id,
    cust_room,
    accessory_id,
    qty_used,
    date_used
) VALUES (
    61,
    15,
    32,
    999,
    TO_DATE('28-02-18','DD-MM-YY')
);


-- test case II
-- It will let you insert a record, because quantity is available in stock.
INSERT INTO accessories_used (
    accessory_used_id,
    cust_room,
    accessory_id,
    qty_used,
    date_used
) VALUES (
    61,
    15,
    32,
    1,
    TO_DATE('28-02-18','DD-MM-YY')
);


-- new available qty
SELECT
    accessory_name,
    quantity
FROM
    accessories
WHERE
    accessory_id = '32';

-- rollback the changes
ROLLBACK;



/*
    2.
    System trigger to log all insert, update and delete changes on one of the master tables (customer).
    Master table: "Has no dependency on other tables".
*/

-- Create customer log table
CREATE TABLE customer_logs
(
   customer_id   VARCHAR2(30),
   status        VARCHAR2(30) NOT NULL,
   update_date   DATE NOT NULL,
   user_id       VARCHAR2(30) NOT NULL
);


CREATE OR REPLACE TRIGGER t_log_customer_change
   BEFORE INSERT OR UPDATE OR DELETE
   ON customers
   FOR EACH ROW

DECLARE

   -- local variable
   l_state   VARCHAR2(10);
   l_user    VARCHAR2(30) := 'N/A';

   -- local cursor to fetch current logged in user
   CURSOR fetch_user
   IS
      SELECT USER ID FROM DUAL;
BEGIN

   -- cursor: fetch current logged in user
   OPEN  fetch_user;
   FETCH fetch_user INTO l_user;
   CLOSE fetch_user;

   CASE
      -- if there's an insert on customer table
      WHEN INSERTING
      THEN
         l_state := 'Insert';
      -- if there's an update on customer table
      WHEN UPDATING
      THEN
         l_state := 'Update';
      -- if there's a delete on customer table
      WHEN DELETING
      THEN
         l_state := 'Delete';
   END CASE;

   -- insert an entry into the log table
   INSERT INTO customer_logs
        VALUES (:NEW.customer_id, -- operation was performed on which customer_id
                l_state, -- whether it's an insert/update/delete
                SYSDATE, -- current system date
                l_user); -- logged in user
END t_log_customer_change;
/


-- test case I
UPDATE customers
   SET first_name = 'Ellen'
 WHERE last_name = 'Mpoukouvala';


-- test case II
INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
    VALUES(21, 'Karen', 'Colmenares', address_type('Proksenou Koromila', 'Geneva', 'Geneve', 'Switzerland', '1730'), phone_number_table_type('69321002', '0035722313898'));


-- check the result
SELECT * FROM customer_logs;

-- rollback current transaction
ROLLBACK;



/*
    3.
    System trigger to log all Logons.
    Trigger will log all the logon time, user details. Once user log into the database.
*/

-- create log table
CREATE TABLE session_logs
(
   user_id       VARCHAR2(30)  NOT NULL,
   logon_logoff  VARCHAR2(3)   CHECK (logon_logoff IN ('IN', 'OUT', 'DDL')) NOT NULL,
   datetime      DATE          NOT NULL
);


CREATE OR REPLACE TRIGGER t_session_logon
    AFTER LOGON ON DATABASE DECLARE
BEGIN
    -- Insert into log table
    INSERT INTO session_logs (
        user_id,
        logon_logoff,
        datetime
    ) VALUES (
        user, -- user name
        'IN', -- logged in
        SYSDATE -- log in date and time
    );
END;
/



/*
    4.
    System trigger to log all Logoffs.
    Trigger will log all the logout time, user details.
*/

CREATE OR REPLACE TRIGGER t_session_logoff
    BEFORE LOGOFF ON DATABASE DECLARE
BEGIN
    -- Insert into log table
    INSERT INTO session_logs (
        user_id,
        logon_logoff,
        datetime
    ) VALUES (
        user, -- user name
        'OUT', -- logged out
        SYSDATE -- log in date and time
    );
END t_session_logoff;
/


-- disconnect from user
DISCONNECT;
-- reconnect to user to test
CONNECT CSY2038_05/CSY2038_05;


-- check the session table
SELECT * FROM session_logs;



/*
    5.
    Trigger to check accessory_used.date_used, which should be in between '01-jan-2017' (business start date) and sysdate.
    It will trigger whenever there is an insert or update on accessory_used table.
*/

CREATE OR REPLACE TRIGGER t_check_accessory_date_used BEFORE
    INSERT OR UPDATE ON accessories_used
    FOR EACH ROW
DECLARE BEGIN
    -- If the accessory_used.date_used is not between '01-jan-2017' and sysdate, raise an error
    IF NOT (:new.date_used BETWEEN to_date('01-JAN-2017', 'DD-MON-YYYY') AND SYSDATE)
    THEN
        -- Raise an error
        raise_application_error(-20005,'Error: Accessory used date cannot be more than system date!');
    END IF;
END t_check_accessory_date_used;
/


-- test case I
-- trigger will throw an error, because 28-May-2018 is a future date.
INSERT INTO accessories_used (
    accessory_used_id,
    cust_room,
    accessory_id,
    qty_used,
    date_used
) VALUES (
    61,
    15,
    32,
    999,
    TO_DATE('28-05-18','DD-MM-YY')
);



/*
    6.
    During insert or update, store/save/insert Customer first and last name as initial capital letter.
*/

CREATE OR REPLACE TRIGGER t_initcap_name BEFORE
    UPDATE OR INSERT ON customers
    FOR EACH ROW
BEGIN
    :new.first_name := initcap(:new.first_name); -- update first_name as initial capital letter
    :new.last_name := initcap(:new.last_name); -- update last_name as initial capital letter
END t_initcap_name;
/


-- test case I
-- Even if you pass name as 'MATRIX', 'matrix' or 'MatRIx' but the name will be saved as 'Matrix'.
UPDATE customers
   SET first_name = LOWER (first_name),
       last_name = LOWER (last_name)
 WHERE customer_id = 1;


-- Fetch the first_name and last_name to check if trigger works or not.
SELECT
    first_name,
    last_name
FROM
    customers
WHERE
    customer_id = 1;

ROLLBACK;



/*
    7.
    Log any DDL event which will happen on the schema.
    DDL (Data Definition Language) event can be - Alter, Create, Drop, Grant, Rename, Truncate etc.
*/

CREATE OR REPLACE TRIGGER t_ddl_trigger
    BEFORE DDL ON SCHEMA
BEGIN
    -- log the details into the session log table.
    INSERT INTO session_logs (
        user_id,
        logon_logoff,
        datetime
    ) VALUES (
        user, -- user who executed the transaction
        'DDL', -- performed ddl
        SYSDATE -- date and time of transaction
    );
END t_ddl_trigger;
/


-- Execute a DDL transaction - Create
CREATE TABLE temp_tables
(
    SATAN NUMBER (6,66)
);

-- Execute a another DDL transaction - Drop
DROP TABLE temp_tables;

-- check the session log, for both DDL transactions
SELECT * FROM session_logs;



/*
    8.
    Trigger to validate address.country
    Whenever there is an update or insert on customer table, check if the address.country is in between the specified countries.
*/

CREATE OR REPLACE TRIGGER t_validate_country
   BEFORE INSERT OR UPDATE
   ON customers
   FOR EACH ROW
BEGIN

    -- If country is not in specified list, raise an exception that 'Country is invalid'
    IF :new.customer_address.country NOT IN
           ('Australia',
            'Armenia',
            'Brazil',
            'Canada',
            'Eordaia',
            'Egypt',
            'Germany',
            'Greece',
            'India',
            'Italy',
            'Japan',
            'Mexico',
            'Netherlands',
            'Republic of China',
            'Singapore',
            'Spain',
            'Switzerland',
            'United Kingdom',
            'United States of America')
   THEN
      -- raise an exception
      raise_application_error (-20001, 'FAILURE: Country is invalid!');
   END IF;

END t_validate_country;
/


-- Test case to check if above trigger works or not.
-- Country specified is 'Pakistan', which is not in the specified list.


    INSERT INTO customers(customer_id, first_name, last_name, customer_address, phone_number)
        VALUES(41, 'Robert', 'Plant', address_type('Zeppelin 32', 'Woodstock', 'Woodstock', 'Pakistan', '1730'), phone_number_table_type('69321002', '0035722313898'));





--
--
-- In purpose all the DROP commands
-- are in comment
--



        /*
            1.
            Drop Sequences
        */

        -- DROP SEQUENCE s_accessory_used;
        -- DROP SEQUENCE s_accessory;
        -- DROP SEQUENCE s_manufacturer;
        -- DROP SEQUENCE s_customer_room;
        -- DROP SEQUENCE s_customer;
        --
        --



        /*
            2.
            Drop Foreign Keys
        */
        --
        -- ALTER TABLE accessories_used
        -- DROP CONSTRAINT fk_au_accessories;
        --
        -- ALTER TABLE accessories_used
        -- DROP CONSTRAINT fk_au_cust_rooms;
        --
        -- ALTER TABLE accessories
        -- DROP CONSTRAINT fk_a_manufacturers;
        --
        -- ALTER TABLE customer_rooms
        -- DROP CONSTRAINT fk_c_customers;
        --
        --



        /*
            3.
            Drop Primary Keys
        */

        -- ALTER TABLE accessories_used
        -- DROP CONSTRAINT pk_accessories_used;
        --
        -- ALTER TABLE accessories
        -- DROP CONSTRAINT pk_accessories;
        --
        -- ALTER TABLE manufacturers
        -- DROP CONSTRAINT pk_manufacturers;
        --
        -- ALTER TABLE customer_rooms
        -- DROP CONSTRAINT pk_customer_rooms;
        --
        -- ALTER TABLE customers
        -- DROP CONSTRAINT pk_customers;
        --
        --
        --
        --



        /*
            4.
            Drop Tables
        */

        -- DROP TABLE accessories_used;
        -- DROP TABLE accessories;
        -- DROP TABLE manufacturers;
        -- DROP TABLE customer_rooms;
        -- DROP TABLE customers;
        --
        --
        /*
            5.
            Drop Types - object/varray/nested table
        */

        -- DROP TYPE cust_details_varray_type;
        -- DROP TYPE customer_details_table_type;
        -- DROP TYPE address_fields_type;
        -- DROP TYPE factory_varray_type;
        -- DROP TYPE factory_type;
        -- DROP TYPE room_type;
        -- DROP TYPE phone_number_table_type;
        -- DROP TYPE address_type;
        --
        --
        --
        --
        -- PURGE RECYCLEBIN;
        --

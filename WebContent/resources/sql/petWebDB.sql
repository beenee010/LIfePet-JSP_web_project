CREATE TABLE USER(
	u_oid int NOT NULL AUTO_INCREMENT,
	u_id varchar(30) NOT NULL,
	u_passwd varchar(30) NOT NULL,
	u_name varchar(20) NOT NULL,
	u_phone varchar(20) NOT NULL,
	u_email varchar(30) NOT NULL,
	u_address varchar(50) NOT NULL,
	u_advAgree boolean NOT NULL,
	u_admin boolean DEFAULT FALSE,
	PRIMARY KEY (u_oid)
);

CREATE TABLE POST(
	p_oid int NOT NULL AUTO_INCREMENT,
	p_uid int NOT NULL,
	p_title varchar(100) NOT NULL,
	p_text text NOT NULL,
	p_category varchar(30) NOT NULL,
	p_like int NOT NULL,
	p_postDate TIMESTAMP NOT NULL,
	p_filename varchar(100) NOT NULL,
	p_hit int NOT NULL DEFAULT 0,
	PRIMARY KEY (p_oid),
	FOREIGN KEY (p_uid) REFERENCES USER(u_oid)
);

CREATE TABLE ITEM(
	f_oid int NOT NULL AUTO_INCREMENT,
	f_uid int NOT NULL,
	f_name varchar(30) NOT NULL,
	f_unitPrice int NOT NULL,
	f_description text NOT NULL,
	f_category varchar(20) NOT NULL,
	f_unitsInStock int NOT NULL,
	f_condition ENUM('N','O') NOT NULL,
	f_filename varchar(100) NOT NULL,
	f_date TIMESTAMP NOT NULL,
	i_hit int NOT NULL DEFAULT 0;
	PRIMARY KEY (f_oid),
	FOREIGN KEY (f_uid) REFERENCES USER(u_oid)
);

CREATE TABLE FLEA(
	f_oid int NOT NULL AUTO_INCREMENT,
	f_uid int NOT NULL,
	f_name varchar(30) NOT NULL,
	f_unitPrice int NOT NULL,
	f_description text NOT NULL,
	f_category varchar(20) NOT NULL,
	f_unitsInStock int NOT NULL,
	f_condition ENUM('N','O') NOT NULL,
	f_filename varchar(100) NOT NULL,
	f_date TIMESTAMP NOT NULL,
	f_hit int NOT NULL DEFAULT 0,
	PRIMARY KEY (f_oid),
	FOREIGN KEY (f_uid) REFERENCES USER(u_oid)
);

CREATE TABLE ORDERING(
	o_oid int NOT NULL AUTO_INCREMENT,
	o_uid int NOT NULL,
	o_iid int NOT NULL,
	o_count int NOT NULL DEFAULT 0,
	o_total int NOT NULL DEFAULT 0,
	o_zip varchar(10) NOT NULL,
	o_address varchar(50) NOT NULL,
	o_date TIMESTAMP NOT NULL,
	o_memo varchar(50),
	o_state varchar(20) DEFAULT 'READY',
	PRIMARY KEY (o_oid),
	FOREIGN KEY (o_uid) REFERENCES USER(u_oid),
	FOREIGN KEY (o_iid) REFERENCES ITEM(i_oid)
);
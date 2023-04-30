CREATE TABLE
    department (
        d_id NUMBER(10) PRIMARY KEY,
        d_name VARCHAR2(255)
    );

CREATE TABLE
    student (
        s_id NUMBER(10) PRIMARY KEY,
        s_name VARCHAR2(255),
        semail VARCHAR2(255),
        dob DATE,
        tot_cred NUMBER(10),
        d_id NUMBER(10),
        FOREIGN KEY (d_id) REFERENCES department(d_id)
    );

CREATE TABLE
    instructor (
        i_id NUMBER(10) PRIMARY KEY,
        i_name VARCHAR2(255),
        iemail VARCHAR2(255),
        d_id NUMBER(10),
        FOREIGN KEY (d_id) REFERENCES department(d_id)
    );

CREATE TABLE
    course (
        c_id NUMBER(10) PRIMARY KEY,
        c_name VARCHAR2(255),
        credits NUMBER(10),
        d_id NUMBER(10),
        i_id NUMBER(10),
        FOREIGN KEY (d_id) REFERENCES department(d_id),
        FOREIGN KEY (i_id) REFERENCES instructor(i_id)
    );

CREATE TABLE
    takes (
        s_id NUMBER(10),
        c_id NUMBER(10),
        attendance NUMBER(10),
        PRIMARY KEY (s_id, c_id),
        FOREIGN KEY (s_id) REFERENCES student(s_id),
        FOREIGN KEY (c_id) REFERENCES course(c_id)
    );

CREATE TABLE
    assignment (
        a_id NUMBER(10) PRIMARY KEY,
        a_name VARCHAR2(255),
        marks NUMBER(10),
        c_id NUMBER(10),
        s_id NUMBER(10),
        max_m NUMBER(10),
        FOREIGN KEY (c_id) REFERENCES course(c_id),
        FOREIGN KEY (s_id) REFERENCES student(s_id)
    );

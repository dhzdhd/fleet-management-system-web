-- driver

INSERT INTO driver
VALUES (
        'DR1',
        2367842341,
        '20-JAN-2030',
        'Rakesh',
        'Verma',
        'Madhav Nagar',
        'Bengaluru'
    );

INSERT INTO driver
VALUES (
        'DR2',
        6567842342,
        '2-JAN-2034',
        'Sanath',
        'Rao',
        'Ananth Nagar',
        'Bengaluru'
    );

INSERT INTO driver
VALUES (
        'DR3',
        4577842345,
        '6-OCT-2032',
        'Siddarth',
        'Sharma',
        'Madhav Nagar',
        'Bengaluru'
    );

INSERT INTO driver
VALUES (
        'DR4',
        7824236348,
        '30-MAR-2037',
        'Raj',
        'Kumar',
        'Madhav Nagar',
        'Bengaluru'
    );

INSERT INTO driver
VALUES (
        'DR5',
        3673742312,
        '25-AUG-2033',
        'Rajesh',
        'Patel',
        'Ananth Nagar',
        'Bengaluru'
    );

-- vehicle

INSERT INTO vehicle VALUES ( 'VH1', 'EcoSport', 25, 2015);

INSERT INTO vehicle VALUES ('VH2', 'XUV 700', 30, 2023);

INSERT INTO vehicle VALUES ( 'VH3','Swift', 23, 2013 );

INSERT INTO vehicle VALUES ( 'VH4', 'Alto', 35, 2010 );

INSERT INTO vehicle VALUES ( 'VH5', 'Nexon', 25, 2020 );

-- trip

INSERT INTO trip
VALUES (
        'TR1',
        '22-JUN-2022',
        '23-JUN-2022',
        'Bengaluru',
        'Manipal',
        400,
        5
    );

INSERT INTO trip
VALUES (
        'TR2',
        '24-AUG-2022',
        '25-AUG-2022',
        'Bengaluru',
        'Mangaluru',
        500,
        5
    );

INSERT INTO trip
VALUES (
        'TR3',
        '01-JUN-2022',
        '03-JUN-2022',
        'Bengaluru',
        'Delhi',
        1000,
        5
    );

-- cost

INSERT INTO cost VALUES ('CS1', 'TR1', 7000, 15000);

INSERT INTO cost VALUES ('CS2', 'TR2', 8000, 16000);

INSERT INTO cost VALUES ('CS3', 'TR3', 20000, 30000);

-- vehicle_involved

INSERT INTO vehicle_involved VALUES ('TR3', 'VH2');

INSERT INTO vehicle_involved VALUES ('TR3', 'VH4');

INSERT INTO vehicle_involved VALUES ('TR1', 'VH1');

INSERT INTO vehicle_involved VALUES ('TR1', 'VH3');

INSERT INTO vehicle_involved VALUES ('TR1', 'VH5');

INSERT INTO vehicle_involved VALUES ('TR2', 'VH1');

INSERT INTO vehicle_involved VALUES ('TR2', 'VH3');

INSERT INTO vehicle_involved VALUES ('TR2', 'VH5');

-- driver_involved

INSERT INTO driver_involved VALUES ('TR1', 'DR1');

INSERT INTO driver_involved VALUES ('TR1', 'DR2');

INSERT INTO driver_involved VALUES ('TR2', 'DR3');

INSERT INTO driver_involved VALUES ('TR3', 'DR4');

INSERT INTO driver_involved VALUES ('TR3', 'DR5');

-- driver_phone

INSERT INTO driver_phone VALUES ('DR1', 1234234892);

INSERT INTO driver_phone VALUES ('DR2', 3481234292);

INSERT INTO driver_phone VALUES ('DR3', 4234367392);

INSERT INTO driver_phone VALUES ('DR4', 9212566348);

INSERT INTO driver_phone VALUES ('DR5', 3489245542);

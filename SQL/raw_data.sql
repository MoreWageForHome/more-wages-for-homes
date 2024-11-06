CREATE TABLE raw_data.lease_type (
    lease_type_id SERIAL PRIMARY KEY,
    lease_type VARCHAR(5)
);

CREATE TABLE raw_data.year (
    year_id SERIAL PRIMARY KEY,
    year INT NOT NULL
);

CREATE TABLE raw_data.district (
    district_id SERIAL PRIMARY KEY,
    district_code INT NOT NULL,
    district_name VARCHAR(20) NOT NULL
);

CREATE TABLE raw_data.building_type (
    building_type_id SERIAL PRIMARY KEY,
    building_type VARCHAR(20) NOT NULL
);

CREATE TABLE raw_data.lease_sales (
    lease_sales_id SERIAL PRIMARY KEY,
    deposit INT NOT NULL DEFAULT 0,
    rent INT NOT NULL DEFAULT 0,
    lease_area NUMERIC(20, 2) NOT NULL DEFAULT 0,
    district_id INT NOT NULL,
    building_type_id INT NOT NULL,
    lease_type_id INT NOT NULL,
    contract_year_id INT NOT NULL,
    construct_year_id INT NOT NULL,
    CONSTRAINT FK_district FOREIGN KEY (district_id) REFERENCES raw_data.district(district_id),
    CONSTRAINT FK_building_type FOREIGN KEY (building_type_id) REFERENCES raw_data.building_type(building_type_id),
    CONSTRAINT FK_lease_type FOREIGN KEY (lease_type_id) REFERENCES raw_data.lease_type(lease_type_id),
    CONSTRAINT FK_year FOREIGN KEY (contract_year_id) REFERENCES raw_data.year(year_id),
    CONSTRAINT FK_year2 FOREIGN KEY (construct_year_id) REFERENCES raw_data.year(year_id)
);

CREATE TABLE raw_data.property_sales (
    property_sales_id SERIAL PRIMARY KEY,
    price INT NOT NULL DEFAULT 0,
    lease_area NUMERIC(20, 2) NOT NULL DEFAULT 0,
    district_id INT NOT NULL,
    building_type_id INT NOT NULL,
    contract_year_id INT NOT NULL,
    construct_year_id INT NOT NULL,
    CONSTRAINT FK_property_district FOREIGN KEY (district_id) REFERENCES raw_data.district(district_id),
    CONSTRAINT FK_property_building_type FOREIGN KEY (building_type_id) REFERENCES raw_data.building_type(building_type_id),
    CONSTRAINT FK_property_year FOREIGN KEY (contract_year_id) REFERENCES raw_data.year(year_id),
    CONSTRAINT FK_property_year2 FOREIGN KEY (construct_year_id) REFERENCES raw_data.year(year_id)
);

CREATE TABLE raw_data.wage_age_year(
    wage_age_year_id SERIAL PRIMARY KEY,
    age VARCHAR(20) NOT NULL,
    avg_wage INT NOT NULL,
    year_id INT NOT NULL,
    CONSTRAINT FK_wage_year FOREIGN KEY (year_id) REFERENCES raw_data.year(year_id)
);

CREATE DATABASE Net365Solution_db;
USE Net365Solution_db;

-- Table: appointment
CREATE TABLE appointment (
    appointment_id int NOT NULL AUTO_INCREMENT COMMENT 'Unique appointment identifier',
    client_id int NOT NULL COMMENT 'Reference to the client requesting the service',
    technical_id int NOT NULL COMMENT 'Unique technician identifier',
    team_id int NOT NULL COMMENT 'Unique equipment identifier',
    service_id int NOT NULL COMMENT 'Unique identifier of the technical service',
    appointment_date timestamp NOT NULL COMMENT 'Date and time scheduled for the appointment',
    mode varchar(20) NOT NULL COMMENT 'Service modality (local, home, etc.).',
    problem_description longtext NOT NULL COMMENT 'Initial description of the equipment problem, provided by the customer',
    state boolean NOT NULL COMMENT 'Current status of the appointment (true if active or completed, false if canceled or pending).',
    CONSTRAINT cita_pk PRIMARY KEY (appointment_id)
) COMMENT 'Central table that manages technical service requests. It lists the customer, equipment, technician, and requested service. It includes details such as date, type, problem description, and appointment status.
';

-- Table: customer
CREATE TABLE customer (
    client_id int NOT NULL AUTO_INCREMENT COMMENT 'Unique customer identifier',
    name varchar(100) NOT NULL COMMENT 'Client name.',
    lastname varchar(100) NOT NULL COMMENT 'Client''''s last name.',
    phone char(9) NOT NULL COMMENT 'Contact phone number',
    email varchar(120) NOT NULL COMMENT 'Customer email.',
    document_type char(3) NOT NULL COMMENT 'Type of identity document',
    ubigeo varchar(6) NOT NULL COMMENT 'Geographic code of the customer''''s place of residence',
    CONSTRAINT cliente_pk PRIMARY KEY (client_id)
) COMMENT 'Stores the personal data of customers requesting technical services. It includes contact and location information for proper service management and tracking.';

-- Table: equipment
CREATE TABLE equipment (
    team_id int NOT NULL AUTO_INCREMENT COMMENT 'Unique equipment identifier',
    client_id int NOT NULL COMMENT 'Unique customer identifier',
    equipment_type varchar(100) NOT NULL COMMENT 'Type or category of equipment',
    brand varchar(50) NOT NULL COMMENT 'Team brand',
    model varchar(50) NOT NULL COMMENT 'Specific equipment model',
    serial_number varchar(100) NOT NULL COMMENT 'Unique serial number of the equipment, useful for precise identification',
    CONSTRAINT equipo_pk PRIMARY KEY (team_id)
) COMMENT 'Records customer-owned equipment. Each device is linked to a customer and contains information about the equipment type, brand, model, and serial number for identification.
';

-- Table: technical
CREATE TABLE technical (
    technical_id int NOT NULL AUTO_INCREMENT COMMENT 'Unique technician identifier',
    technical_name varchar(100) NOT NULL COMMENT 'Technician name',
    technical_lastname varchar(100) NOT NULL COMMENT 'Technician''''s last name',
    specialty varchar(100) NOT NULL COMMENT 'Specialty or technical area in which you work',
    technical_phone char(9) NOT NULL COMMENT 'Technician contact number',
    technical_email varchar(120) NOT NULL COMMENT 'Professional email of the technician',
    CONSTRAINT tecnico_pk PRIMARY KEY (technical_id)
) COMMENT 'Contains the information of the technical staff responsible for performing the services. It includes their name, specialty, and contact information. It allows you to assign technicians to appointments based on their experience.';

-- Table: technical_service
CREATE TABLE technical_service (
    service_id int NOT NULL COMMENT 'Unique identifier of the technical service',
    service_name varchar(100) NOT NULL COMMENT 'Service name',
    service_description Text NOT NULL COMMENT 'Full details of the service offered',
    service_price decimal(10,2) NOT NULL COMMENT 'Approximate cost of the service, expressed in local currency',
    CONSTRAINT servicio_tecnico_pk PRIMARY KEY (service_id)
) COMMENT 'Define the different types of technical services the company offers. Include the name, detailed description of the service, and estimated price. This is essential for classifying and quoting services.';

-- foreign keys
-- Reference: customer_equipment (table: equipment)
ALTER TABLE equipment ADD CONSTRAINT customer_equipment FOREIGN KEY customer_equipment (client_id)
    REFERENCES customer (client_id);

-- Reference: equipment_appointment (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT equipment_appointment FOREIGN KEY equipment_appointment (team_id)
    REFERENCES equipment (team_id);

-- Reference: technical_appointment (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT technical_appointment FOREIGN KEY technical_appointment (technical_id)
    REFERENCES technical (technical_id);

-- Reference: technical_service_appointment (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT technical_service_appointment FOREIGN KEY technical_service_appointment (service_id)
    REFERENCES technical_service (service_id);

-- End of file.

CREATE TABLE IF NOT EXISTS HIP_TABLE (
    Id SERIAL PRIMARY KEY,
    healthcare_id TEXT NOT NULL UNIQUE,
    healthcare_license TEXT NOT NULL UNIQUE,
    healthcare_name TEXT NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    availability VARCHAR(15) NOT NULL,
    total_facilities INTEGER NOT NULL, 
    total_mbbs_doc INTEGER NOT NULL,
    total_worker INTEGER NOT NULL, 
    no_of_beds INTEGER NOT NULL,
    date_of_registration TIMESTAMP DEFAULT NOW(),
    password TEXT NOT NULL,
    about VARCHAR(300) NOT NULL,
    country VARCHAR(30) NOT NULL,
    state VARCHAR(20) NOT NULL,
    city VARCHAR(30) NOT NULL,
    landmark VARCHAR(45) NOT NULL
);

INSERT INTO HIP_TABLE (
    healthcare_id,
    healthcare_license,
    healthcare_name,
    email,
    availability,
    total_facilities,
    total_mbbs_doc,
    total_worker,
    no_of_beds,
    password,
    about,
    country,
    state,
    city,
    landmark
) VALUES (
    'GuestUser-001',
    'GuestUser-001',
    'Guest User Hospital',
    'GuestUser@example.com',
    'Yes',
    200,
    58,
    400,
    200,
    '$2a$10$N3q2dzQ11frAPlxpD8WLI.fwVrTY/DWhYMami0E01WIifOhJgjn/u',
    'GuestUser Hospital to view and test the functionlity',
    'India',
    'Karnataka',
    'Bangalore',
    'MG Road'
);


CREATE TABLE IF NOT EXISTS HealthCare_pref (
    Id SERIAL PRIMARY KEY,
    healthcare_id TEXT NOT NULL,
    scheduled_deletion VARCHAR(20),
    profile_viewed INTEGER,
    profile_updated INTEGER NOT NULL,
    account_locked VARCHAR(15) NOT NULL,
    records_created INTEGER NOT NULL,
    records_viewed INTEGER NOT NULL,
    totalrequest_count INTEGER NOT NULL,
    appointmentFee INTEGER NOT NULL,
    isAvailable VARCHAR(20) NOT NULL,
    FOREIGN KEY (healthcare_id) REFERENCES HIP_TABLE(healthcare_id) ON DELETE CASCADE
);

-- Insert matching pref record
INSERT INTO HealthCare_pref (
    healthcare_id,
    scheduled_deletion,
    profile_viewed,
    profile_updated,
    account_locked,
    records_created,
    records_viewed,
    totalrequest_count,
    appointmentFee,
    isAvailable
) VALUES (
    'GuestUser-001',
    false,
    0,
    0,
    false,
    0,
    0,
    50000,
    300,
    true
)
ON CONFLICT DO NOTHING;

-- 1️⃣ Create client_profile first
CREATE TABLE IF NOT EXISTS client_profile (
    id SERIAL PRIMARY KEY,
    health_id VARCHAR(150) NOT NULL UNIQUE,
    first_name VARCHAR(150) NOT NULL,
    middle_name VARCHAR(150),
    last_name VARCHAR(150) NOT NULL,
    sex VARCHAR(150) NOT NULL,
    healthcare_id VARCHAR NOT NULL,
    dob VARCHAR(150) NOT NULL,
    blood_group VARCHAR(150) NOT NULL,
    bmi VARCHAR(150) NOT NULL,
    marriage_status VARCHAR(150) NOT NULL,
    weight VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    mobile_number VARCHAR(150) NOT NULL,
    aadhaar_number VARCHAR(150) NOT NULL,
    primary_location VARCHAR(150) NOT NULL,
    sibling VARCHAR(150) NOT NULL,
    twin VARCHAR(150) NOT NULL,
    father_name VARCHAR(150) NOT NULL,
    mother_name VARCHAR(150) NOT NULL,
    emergency_number VARCHAR(150) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    country VARCHAR(150) NOT NULL,
    city VARCHAR(150) NOT NULL,
    state VARCHAR(150) NOT NULL,
    landmark VARCHAR(150) NOT NULL
);

-- 2️⃣ Create client_stats after client_profile
CREATE TABLE IF NOT EXISTS client_stats (
    health_id VARCHAR PRIMARY KEY UNIQUE,
    account_status VARCHAR CHECK (account_status IN ('Trial', 'Testing', 'Beta', 'Premium')) 
        NOT NULL DEFAULT 'Trial',
    available_money VARCHAR NOT NULL DEFAULT '5000',
    profile_viewed INTEGER NOT NULL DEFAULT 0,
    profile_updated INTEGER NOT NULL DEFAULT 0,
    records_viewed INTEGER NOT NULL DEFAULT 0,
    records_created INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (health_id) REFERENCES client_profile(health_id) ON DELETE CASCADE
);

INSERT INTO client_profile (
    health_id, first_name, middle_name, last_name, sex, healthcare_id, dob,
    blood_group, bmi, marriage_status, weight, email, mobile_number,
    aadhaar_number, primary_location, sibling, twin, father_name, mother_name,
    emergency_number, created_at, updated_at, country, city, state, landmark
) VALUES (
    'GuestUser-001', 'Dear', 'User', '.', 'male', 'GuestUser-001', '2000-01-01',
    'O+', '22', 'Unmarried', '65', 'guest@example.com', '0000000000',
    '0000-0000-0000', 'N/A', '0', '0', 'GuestFather', 'GuestMother',
    '0000000000', NOW(), NOW(), 'GuestCountry', 'GuestCity', 'GuestState', 'GuestLandmark'
) ON CONFLICT (health_id) DO NOTHING;

INSERT INTO client_stats (
    health_id, account_status, available_money,
    profile_viewed, profile_updated, records_viewed, records_created
) VALUES (
    'GuestUser-001', 'Trial', '50000', 0, 0, 0, 0
) ON CONFLICT (health_id) DO NOTHING;


CREATE TABLE IF NOT EXISTS "clientAuth" (
    id SERIAL PRIMARY KEY,
    fullname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    health_id VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW()
);


INSERT INTO "clientAuth" (fullname, email, health_id, password, "createdAt", "updatedAt")
VALUES (
    'Dear User',
    'guest@example.com',
    'GuestUser-001',
    '$2a$10$seIDYPYjvDR.OjYufgXmFOSGswwLDxwN8q87B/qk.508h7XSskOoW',
    NOW(),
    NOW()
)
ON CONFLICT (email) DO NOTHING;

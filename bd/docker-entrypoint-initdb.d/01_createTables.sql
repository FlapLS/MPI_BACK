CREATE TABLE IF NOT EXISTS orders (
    id UUID PRIMARY KEY,
    created_timestamp TIMESTAMP WITH TIME ZONE,
    type VARCHAR(63),
    description TEXT,
    status VARCHAR(63),
    target_name TEXT
);

CREATE TABLE IF NOT EXISTS head_haunt_order (
    order_id UUID PRIMARY KEY,
    succeded_killer_id UUID,
    customer_name TEXT,
    current_price DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS promissory_note_order (
    order_id UUID PRIMARY KEY,
    beneficiary_user_id UUID,
    deptor_user_id UUID
);

CREATE TABLE IF NOT EXISTS regular_order (
    order_id UUID PRIMARY KEY,
    assigned_killer_id UUID,
    price DOUBLE PRECISION,
    customer_name TEXT
);

CREATE TABLE IF NOT EXISTS regular_order_application (
    id UUID PRIMARY KEY,
    applied_killer_id UUID,
    regular_order_id UUID,
    created_timestamp TIMESTAMP WITH TIME ZONE
);

CREATE TABLE IF NOT EXISTS cleaning_request (
    id UUID PRIMARY KEY,
    order_id UUID,
    requested_by UUID,
    applied_cleaner_id UUID,
    created_timestamp TIMESTAMP WITH TIME ZONE,
    price DOUBLE PRECISION,
    status VARCHAR(63),
    details TEXT
);

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY,
    username VARCHAR(63),
    password TEXT,
    role VARCHAR(63),
    display_name TEXT,
    status VARCHAR(63)
);

CREATE TABLE IF NOT EXISTS notification (
    id UUID PRIMARY KEY,
    user_id UUID,
    title TEXT,
    message TEXT,
    created_timestamp TIMESTAMP WITH TIME ZONE,
    is_read BOOLEAN
);

CREATE TABLE IF NOT EXISTS appointments_schedule (
    id UUID PRIMARY KEY,
    host_user_id UUID,
    date DATE,
    from_time TIME WITH TIME ZONE,
    to_time TIME WITH TIME ZONE
);

CREATE TABLE IF NOT EXISTS appointment (
    id UUID PRIMARY KEY,
    booked_by_user_id UUID,
    appointments_schedule_id UUID,
    date DATE,
    from_timestamp TIME WITH TIME ZONE,
    to_timestamp TIME WITH TIME ZONE,
    message TEXT
);



/* Внешние ключи */


ALTER TABLE head_haunt_order
ADD FOREIGN KEY (succeded_killer_id) REFERENCES users(id),
ADD FOREIGN KEY (order_id) REFERENCES orders(id);

ALTER TABLE promissory_note_order
ADD FOREIGN KEY (order_id) REFERENCES orders(id),
ADD FOREIGN KEY (beneficiary_user_id) REFERENCES users(id),
ADD FOREIGN KEY (deptor_user_id) REFERENCES users(id);

ALTER TABLE regular_order
ADD FOREIGN KEY (order_id) REFERENCES orders(id),
ADD FOREIGN KEY (assigned_killer_id) REFERENCES users(id); 

ALTER TABLE regular_order_application
ADD FOREIGN KEY (applied_killer_id) REFERENCES users(id), 
ADD FOREIGN KEY (regular_order_id) REFERENCES regular_order(order_id); 

ALTER TABLE cleaning_request
ADD FOREIGN KEY (order_id) REFERENCES orders(id),
ADD FOREIGN KEY (requested_by) REFERENCES users(id),
ADD FOREIGN KEY (applied_cleaner_id) REFERENCES users(id); 

ALTER TABLE notification
ADD FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE appointments_schedule 
ADD FOREIGN KEY (host_user_id) REFERENCES users(id);

ALTER TABLE appointment
ADD FOREIGN KEY (appointments_schedule_id) REFERENCES appointments_schedule(id);

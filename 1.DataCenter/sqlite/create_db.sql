CREATE TABLE "Users" (
"user_id" varchar(32) NOT NULL,
"username" varchar(32) NOT NULL DEFAULT '',
"password" varchar(32) NOT NULL DEFAULT '',
"email" varchar(32) NOT NULL DEFAULT '',
"role" INTEGER NOT NULL DEFAULT '',
"token" TEXT,
"permissions" TEXT,
PRIMARY KEY (user_id)
);

CREATE TABLE "AccountType" (
    "type_id"       INTEGER PRIMARY KEY AUTOINCREMENT,
    "type_name"     VARCHAR(32) NOT NULL DEFAULT '',
    UNIQUE (type_name)
);

CREATE TABLE "ServiceProvider" (
"service_provider_id" INTEGER PRIMARY KEY AUTOINCREMENT,
"service_provider" varchar(32) NOT NULL DEFAULT '',
UNIQUE (service_provider)
);

CREATE TABLE "Restriction" (
"restriction_id" INTEGER PRIMARY KEY AUTOINCREMENT,
"restriction_name" varchar(32) NOT NULL DEFAULT '',
UNIQUE(restriction_name)
);

CREATE TABLE "Accounts" (
    "account_id"            VARCHAR(32) NOT NULL,
    "user_id"               VARCHAR(32) NOT NULL DEFAULT '',
    "service_provider_id"   INTEGER NOT NULL,
    "account_name"          VARCHAR(32) NOT NULL DEFAULT '',
    "account_type_id"       INTEGER NOT NULL,
    "account_password"      VARCHAR(32) NOT NULL DEFAULT '',
    "restriction_id"        INTEGER NOT NULL,
    "note"                  TEXT,
    "period"                DATETIME,
    PRIMARY KEY (account_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (service_provider_id) REFERENCES ServiceProvider(service_provider_id),
    FOREIGN KEY (account_type_id) REFERENCES AccountType(type_id),
    FOREIGN KEY (restriction_id) REFERENCES Restriction(restriction_id)
);

CREATE TABLE "Dashboard" (
"report_id" varchar(32) NOT NULL,
"user_id" varchar(32) NOT NULL,
"last_update" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
"report_link" varchar(32) NOT NULL,
PRIMARY KEY (report_id),
FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE "FileStorage" (
"file_id" varchar(32) NOT NULL,
"user_id" varchar(32) NOT NULL,
"file_name" varchar(32) NOT NULL DEFAULT '',
"file_type" varchar(32) NOT NULL DEFAULT '',
"file_size" INTEGER NOT NULL DEFAULT 0,
"file_path" varchar(32) NOT NULL DEFAULT '',
"file_code" varchar(32) NOT NULL DEFAULT '',
"file_status" INTEGER NOT NULL DEFAULT 1,
"file_upload" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
"file_modify" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (file_id),
FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
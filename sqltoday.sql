SET SCHEMA data;

CREATE TABLE metric(
    id INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
    vmin DOUBLE PRECISION NULL,
    vmax DOUBLE PRECISION NULL,
    unit VARCHAR(30) NOT NULL,
    snmp_old VARCHAR(100) NOT NULL,
    agnt_scale DOUBLE PRECISION NULL
);
ALTER TABLE
    metric ADD PRIMARY KEY(id);
CREATE TABLE collect(
    node INTEGER NOT NULL,
    metric INTEGER NOT NULL,
    intvar INTEGER NOT NULL
);
CREATE TABLE account(
    id INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
    secret VARCHAR(30) NOT NULL
);
ALTER TABLE
    account ADD PRIMARY KEY(id);
CREATE TABLE session(
    key CHAR(16) NOT NULL,
    account INTEGER NOT NULL,
    t_begin TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    t_end TIMESTAMP(0) WITHOUT TIME ZONE NULL
);
ALTER TABLE
    session ADD PRIMARY KEY(key);
CREATE TABLE sample(
    ts TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    node INTEGER NOT NULL,
    metric INTEGER NOT NULL,
    value DOUBLE PRECISION NOT NULL
);
CREATE TABLE permission(
    account INTEGER NOT NULL,
    func VARCHAR(30) NOT NULL
);
CREATE TABLE link(
    id INTEGER NOT NULL,
    node_a INTEGER NOT NULL,
    node_b INTEGER NOT NULL,
    link_pkey INTEGER NOT NULL,
    node_a_id INTEGER NOT NULL,
    node_b_id INTEGER NOT NULL
);
ALTER TABLE
    link ADD PRIMARY KEY(id);
CREATE TABLE map(
    id INTEGER NOT NULL,
    account INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL
);
ALTER TABLE
    map ADD PRIMARY KEY(id);
CREATE TABLE agent(
    id INTEGER NOT NULL,
    key CHAR(16) NULL,
    name VARCHAR(50) NOT NULL
);
ALTER TABLE
    agent ADD PRIMARY KEY(id);
ALTER TABLE
    agent ADD CONSTRAINT agent_key_unique UNIQUE(key);
CREATE TABLE node(
    id INTEGER NOT NULL,
    map INTEGER NOT NULL,
    x DOUBLE PRECISION NOT NULL,
    y DOUBLE PRECISION NOT NULL,
    ip VARCHAR(15) NOT NULL,
    name VARCHAR(30) NOT NULL,
    agent INTEGER NOT NULL
);
ALTER TABLE
    node ADD PRIMARY KEY(id);
ALTER TABLE
    collect ADD CONSTRAINT collect_metric_foreign FOREIGN KEY(metric) REFERENCES metric(id);
ALTER TABLE
    session ADD CONSTRAINT session_account_foreign FOREIGN KEY(account) REFERENCES account(id);
ALTER TABLE
    sample ADD CONSTRAINT sample_node_foreign FOREIGN KEY(node) REFERENCES node(id);
ALTER TABLE
    sample ADD CONSTRAINT sample_metric_foreign FOREIGN KEY(metric) REFERENCES metric(id);
ALTER TABLE
    permission ADD CONSTRAINT permission_account_foreign FOREIGN KEY(account) REFERENCES account(id);
ALTER TABLE
    map ADD CONSTRAINT map_account_foreign FOREIGN KEY(account) REFERENCES account(id);
ALTER TABLE
    node ADD CONSTRAINT node_agent_foreign FOREIGN KEY(agent) REFERENCES agent(id);
ALTER TABLE
    link ADD CONSTRAINT link_node_a_foreign FOREIGN KEY(node_a) REFERENCES node(id);
ALTER TABLE
    link ADD CONSTRAINT link_node_b_foreign FOREIGN KEY(node_b) REFERENCES node(id);
ALTER TABLE
    collect ADD CONSTRAINT collect_node_foreign FOREIGN KEY(node) REFERENCES node(id);
ALTER TABLE
    node ADD CONSTRAINT node_map_foreign FOREIGN KEY(map) REFERENCES map(id);

ALTER TABLE
    metric OWNER TO myuser;
ALTER TABLE
    collect OWNER TO myuser;
ALTER TABLE
    node OWNER TO myuser;
ALTER TABLE
    map OWNER TO myuser;
ALTER TABLE
    account OWNER TO myuser;
ALTER TABLE
    session OWNER TO myuser;
ALTER TABLE
    sample OWNER TO myuser;
ALTER TABLE
    link OWNER TO myuser;
ALTER TABLE
    permission OWNER TO myuser;
ALTER TABLE
    agent OWNER TO myuser;
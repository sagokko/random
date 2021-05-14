SET SCHEMA data;

CREATE TABLE metric(
    id INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
    vmin DOUBLE PRECISION NULL,
    vmax DOUBLE PRECISION NULL,
    unit VARCHAR(30) NOT NULL,
    snmp_old VARCHAR(100) NOT NULL,
    agnt_scale DOUBLE PRECISION NULL,
    metric_pkey INTEGER NOT NULL
);
ALTER TABLE
    metric ADD PRIMARY KEY(id);
CREATE INDEX metric_metric_pkey_index ON
    metric(metric_pkey);
CREATE TABLE collect(
    node INTEGER NOT NULL,
    metric INTEGER NOT NULL,
    intvar INTEGER NOT NULL,
    node_id INTEGER NOT NULL,
    metric_id INTEGER NOT NULL
);
CREATE INDEX collect_node_id_index ON
    collect(node_id);
CREATE INDEX collect_metric_id_index ON
    collect(metric_id);
CREATE TABLE account(
    id INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
    secret VARCHAR(30) NOT NULL,
    account_pkey INTEGER NOT NULL
);
ALTER TABLE
    account ADD PRIMARY KEY(id);
CREATE INDEX account_account_pkey_index ON
    account(account_pkey);
CREATE TABLE session(
    key CHAR(16) NOT NULL,
    account INTEGER NOT NULL,
    t_begin TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    t_end TIMESTAMP(0) WITHOUT TIME ZONE NULL,
    session_pkey INTEGER NOT NULL,
    account_id INTEGER NOT NULL
);
ALTER TABLE
    session ADD PRIMARY KEY(key);
CREATE INDEX session_session_pkey_index ON
    session(session_pkey);
CREATE INDEX session_account_id_index ON
    session(account_id);
CREATE TABLE sample(
    ts TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    node INTEGER NOT NULL,
    metric INTEGER NOT NULL,
    value DOUBLE PRECISION NOT NULL,
    idx_ts INTEGER NOT NULL,
    idx_node INTEGER NOT NULL
);
CREATE INDEX sample_idx_ts_index ON
    sample(idx_ts);
CREATE INDEX sample_idx_node_index ON
    sample(idx_node);
CREATE TABLE permission(
    account INTEGER NOT NULL,
    func VARCHAR(30) NOT NULL,
    account_id INTEGER NOT NULL
);
CREATE INDEX permission_account_id_index ON
    permission(account_id);
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
    name VARCHAR(50) NOT NULL,
    map_pkey INTEGER NOT NULL,
    account_id INTEGER NOT NULL
);
ALTER TABLE
    map ADD PRIMARY KEY(id);
CREATE INDEX map_map_pkey_index ON
    map(map_pkey);
CREATE INDEX map_account_id_index ON
    map(account_id);
CREATE TABLE agent(
    id INTEGER NOT NULL,
    key CHAR(16) NULL,
    name VARCHAR(50) NOT NULL,
    agent_pkey INTEGER NOT NULL,
    agent_key_key INTEGER NOT NULL
);
ALTER TABLE
    agent ADD PRIMARY KEY(id);
ALTER TABLE
    agent ADD CONSTRAINT agent_key_unique UNIQUE(key);
CREATE INDEX agent_agent_pkey_index ON
    agent(agent_pkey);
CREATE INDEX agent_agent_key_key_index ON
    agent(agent_key_key);
CREATE TABLE node(
    id INTEGER NOT NULL,
    map INTEGER NOT NULL,
    x DOUBLE PRECISION NOT NULL,
    y DOUBLE PRECISION NOT NULL,
    ip VARCHAR(15) NOT NULL,
    name VARCHAR(30) NOT NULL,
    agent INTEGER NOT NULL,
    node_pkey INTEGER NOT NULL,
    map_id INTEGER NOT NULL,
    agent_id INTEGER NOT NULL
);
ALTER TABLE
    node ADD PRIMARY KEY(id);
CREATE INDEX node_node_pkey_index ON
    node(node_pkey);
CREATE INDEX node_map_id_index ON
    node(map_id);
CREATE INDEX node_agent_id_index ON
    node(agent_id);
ALTER TABLE
    collect ADD CONSTRAINT collect_node_foreign FOREIGN KEY(node) REFERENCES metric(id);
ALTER TABLE
    collect ADD CONSTRAINT collect_metric_foreign FOREIGN KEY(metric) REFERENCES node(id);
ALTER TABLE
    session ADD CONSTRAINT session_account_foreign FOREIGN KEY(account) REFERENCES account(id);
ALTER TABLE
    sample ADD CONSTRAINT sample_node_foreign FOREIGN KEY(node) REFERENCES node(id);
ALTER TABLE
    sample ADD CONSTRAINT sample_metric_foreign FOREIGN KEY(metric) REFERENCES metric(id);
ALTER TABLE
    permission ADD CONSTRAINT permission_account_foreign FOREIGN KEY(account) REFERENCES account(id);
ALTER TABLE
    node ADD CONSTRAINT node_agent_foreign FOREIGN KEY(agent) REFERENCES agent(id);
ALTER TABLE
    map ADD CONSTRAINT map_account_foreign FOREIGN KEY(account) REFERENCES account(id);
ALTER TABLE
    link ADD CONSTRAINT link_node_a_foreign FOREIGN KEY(node_a) REFERENCES node(id);
ALTER TABLE
    link ADD CONSTRAINT link_node_b_foreign FOREIGN KEY(node_b) REFERENCES node(id);
ALTER TABLE
    node ADD CONSTRAINT node_map_foreign FOREIGN KEY(map) REFERENCES map(id);

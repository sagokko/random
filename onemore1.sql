SET SCHEMA data;
CREATE TABLE  datametric (
     id  INTEGER NOT NULL,
     name  VARCHAR(30) NOT NULL,
     vmin  DOUBLE PRECISION NULL,
     vmax  DOUBLE PRECISION NULL,
     unit  VARCHAR(30) NOT NULL,
     snmp_old  VARCHAR(100) NOT NULL,
     agnt_scale  DOUBLE PRECISION NULL
);
ALTER TABLE
     datametric  ADD PRIMARY KEY( id );
COMMENT
ON COLUMN
     datametric . name  IS '30';
COMMENT
ON COLUMN
     datametric . unit  IS '30';
CREATE TABLE  datacollect (
     node  INTEGER NOT NULL,
     metric  INTEGER NOT NULL,
     intval  INTEGER NOT NULL
);
CREATE TABLE  datanode (
     id  INTEGER NOT NULL,
     map  INTEGER NOT NULL,
     x  DOUBLE PRECISION NOT NULL,
     y  DOUBLE PRECISION NOT NULL,
     ip  VARCHAR(15) NOT NULL,
     name  VARCHAR(50) NOT NULL,
     agent  INTEGER NOT NULL
);
ALTER TABLE
     datanode  ADD PRIMARY KEY( id );
CREATE TABLE  dataagent (
     id  INTEGER NULL,
     key  CHAR(16) NULL,
     name  VARCHAR(50) NOT NULL
);
ALTER TABLE
     dataagent  ADD PRIMARY KEY( id );
ALTER TABLE
     dataagent  ADD CONSTRAINT  dataagent_key_unique  UNIQUE( key );
CREATE TABLE  datalink (
     id  INTEGER NOT NULL,
     node_a  INTEGER NOT NULL,
     node_b  INTEGER NOT NULL
);
ALTER TABLE
     datalink  ADD PRIMARY KEY( id );
CREATE TABLE  dataaccount (
     id  INTEGER NULL,
     name  VARCHAR(30) NOT NULL,
     secret  VARCHAR(30) NOT NULL
);
ALTER TABLE
     dataaccount  ADD PRIMARY KEY( id );
CREATE TABLE  datamap (
     id  INTEGER NULL,
     account  INTEGER NOT NULL,
     name  VARCHAR(50) NOT NULL
);
ALTER TABLE
     datamap  ADD PRIMARY KEY( id );
CREATE TABLE  datapermission (
     account  INTEGER NOT NULL,
     func  INTEGER NOT NULL
);
CREATE TABLE  datasession (
     key  CHAR(16) NOT NULL,
     account  INTEGER NOT NULL,
     t_begin  TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
     t_end  TIMESTAMP(0) WITHOUT TIME ZONE NULL
);
ALTER TABLE
     datasession  ADD PRIMARY KEY( key );
CREATE TABLE  datasimple (
     ts  TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
     node  INTEGER NOT NULL,
     metric  INTEGER NOT NULL,
     value  DOUBLE PRECISION NOT NULL
);
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

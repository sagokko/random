CREATE TABLE "datametric"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "vmin" DOUBLE PRECISION NULL,
    "vmax" DOUBLE PRECISION NULL,
    "unit" VARCHAR(255) NOT NULL,
    "snmp_old" VARCHAR(255) NOT NULL,
    "agnt_scale" DOUBLE PRECISION NULL,
    "metric_pkey" INTEGER NOT NULL
);
ALTER TABLE
    "datametric" ADD PRIMARY KEY("id");
CREATE INDEX "datametric_metric_pkey_index" ON
    "datametric"("metric_pkey");
COMMENT
ON COLUMN
    "datametric"."name" IS '30';
COMMENT
ON COLUMN
    "datametric"."unit" IS '30';
CREATE TABLE "datacollect"(
    "node" INTEGER NOT NULL,
    "metric" INTEGER NOT NULL,
    "intval" INTEGER NOT NULL,
    "node_id" INTEGER NULL,
    "account_id" INTEGER NULL
);
CREATE INDEX "datacollect_node_id_index" ON
    "datacollect"("node_id");
CREATE INDEX "datacollect_account_id_index" ON
    "datacollect"("account_id");
CREATE TABLE "datanode"(
    "id" INTEGER NOT NULL,
    "map" INTEGER NOT NULL,
    "x" DOUBLE PRECISION NOT NULL,
    "y" DOUBLE PRECISION NOT NULL,
    "ip" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "agent" INTEGER NOT NULL,
    "node_pkey" INTEGER NULL,
    "map_id" INTEGER NULL,
    "agent_id" INTEGER NULL
);
ALTER TABLE
    "datanode" ADD PRIMARY KEY("id");
CREATE INDEX "datanode_node_pkey_index" ON
    "datanode"("node_pkey");
CREATE INDEX "datanode_map_id_index" ON
    "datanode"("map_id");
CREATE INDEX "datanode_agent_id_index" ON
    "datanode"("agent_id");
CREATE TABLE "dataagent"(
    "id" INTEGER NULL,
    "key" CHAR(255) NULL,
    "name" VARCHAR(255) NOT NULL,
    "agent_pkey" INTEGER NULL,
    "agent_key_key" INTEGER NULL
);
ALTER TABLE
    "dataagent" ADD PRIMARY KEY("id");
ALTER TABLE
    "dataagent" ADD CONSTRAINT "dataagent_key_unique" UNIQUE("key");
CREATE INDEX "dataagent_agent_pkey_index" ON
    "dataagent"("agent_pkey");
CREATE INDEX "dataagent_agent_key_key_index" ON
    "dataagent"("agent_key_key");
CREATE TABLE "datalink"(
    "id" INTEGER NOT NULL,
    "node_a" INTEGER NOT NULL,
    "node_b" INTEGER NOT NULL,
    "link_pkey" INTEGER NOT NULL,
    "node_a_id" INTEGER NOT NULL,
    "node_b_id" INTEGER NOT NULL
);
ALTER TABLE
    "datalink" ADD PRIMARY KEY("id");
CREATE INDEX "datalink_link_pkey_index" ON
    "datalink"("link_pkey");
CREATE INDEX "datalink_node_a_id_index" ON
    "datalink"("node_a_id");
CREATE INDEX "datalink_node_b_id_index" ON
    "datalink"("node_b_id");
CREATE TABLE "dataaccount"(
    "id" INTEGER NULL,
    "name" VARCHAR(255) NOT NULL,
    "secret" VARCHAR(255) NOT NULL,
    "account_pkey" INTEGER NULL
);
ALTER TABLE
    "dataaccount" ADD PRIMARY KEY("id");
CREATE INDEX "dataaccount_account_pkey_index" ON
    "dataaccount"("account_pkey");
CREATE TABLE "datamap"(
    "id" INTEGER NULL,
    "account" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "map_pkey" INTEGER NOT NULL,
    "account_id" INTEGER NOT NULL
);
ALTER TABLE
    "datamap" ADD PRIMARY KEY("id");
CREATE INDEX "datamap_map_pkey_index" ON
    "datamap"("map_pkey");
CREATE INDEX "datamap_account_id_index" ON
    "datamap"("account_id");
CREATE TABLE "datapermission"(
    "account" INTEGER NOT NULL,
    "func" INTEGER NOT NULL,
    "account_id" INTEGER NOT NULL
);
CREATE INDEX "datapermission_account_id_index" ON
    "datapermission"("account_id");
CREATE TABLE "datasession"(
    "key" CHAR(255) NOT NULL,
    "account" INTEGER NOT NULL,
    "t_begin" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "t_end" TIMESTAMP(0) WITHOUT TIME ZONE NULL,
    "session_pkey" INTEGER NOT NULL,
    "account_id" INTEGER NOT NULL
);
ALTER TABLE
    "datasession" ADD PRIMARY KEY("key");
CREATE INDEX "datasession_session_pkey_index" ON
    "datasession"("session_pkey");
CREATE INDEX "datasession_account_id_index" ON
    "datasession"("account_id");
CREATE TABLE "datasimple"(
    "ts" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "node" INTEGER NOT NULL,
    "metric" INTEGER NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "idx_ts" INTEGER NOT NULL,
    "ids_node" INTEGER NOT NULL
);
CREATE INDEX "datasimple_idx_ts_index" ON
    "datasimple"("idx_ts");
CREATE INDEX "datasimple_ids_node_index" ON
    "datasimple"("ids_node");
ALTER TABLE
    "datasimple" ADD CONSTRAINT "datasimple_metric_foreign" FOREIGN KEY("metric") REFERENCES "datametric"("id");
ALTER TABLE
    "datacollect" ADD CONSTRAINT "datacollect_node_foreign" FOREIGN KEY("node") REFERENCES "datametric"("id");
ALTER TABLE
    "datacollect" ADD CONSTRAINT "datacollect_metric_foreign" FOREIGN KEY("metric") REFERENCES "datanode"("id");
ALTER TABLE
    "datanode" ADD CONSTRAINT "datanode_ip_foreign" FOREIGN KEY("ip") REFERENCES "datalink"("id");
ALTER TABLE
    "datapermission" ADD CONSTRAINT "datapermission_account_foreign" FOREIGN KEY("account") REFERENCES "dataaccount"("id");
ALTER TABLE
    "datanode" ADD CONSTRAINT "datanode_map_foreign" FOREIGN KEY("map") REFERENCES "datamap"("id");
create or replace TABLE BIFROSTTEST.PUBLIC.TMP_T_AUDIT_VDP_LOG_STATUS (
	VDP_ENVIRONMENT VARCHAR(255),
	VDP_SERVER_NAME VARCHAR(255),
	VDP_LOG_NAME VARCHAR(255),
	LATEST_LOG_TIMESTAMP VARCHAR(255),
	constraint T_AUDIT_VDP_LOG_STATUS_PK primary key (VDP_ENVIRONMENT, VDP_SERVER_NAME, VDP_LOG_NAME)
)COMMENT=
$$philhu01, Temp copy of redundant table T_AUDIT_VDP_QUERIES_LOG.  Will be dropped at some point in the future when no longer neeeded. Stores the latest start time of VDP audit data rows written to CDW staging database for each Denodo server. Data is peristed and not truncated during job runs$$
;

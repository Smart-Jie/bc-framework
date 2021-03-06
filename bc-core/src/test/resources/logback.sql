-- LOGBACK 保存日志到数据库的建表语句 HTTP://LOGBACK.QOS.CH/MANUAL/APPENDERS.HTML

-- 日志id序列
drop sequence if exists LOGGING_EVENT_ID_SEQ;

-- 日志表
DROP TABLE IF EXISTS LOGGING_EVENT_PROPERTY;
DROP TABLE IF EXISTS LOGGING_EVENT_EXCEPTION;
DROP TABLE IF EXISTS LOGGING_EVENT;

-- 日志id序列
CREATE sequence LOGGING_EVENT_ID_SEQ
    minvalue 1
    start with 1
    increment by 1
    cache 20;
SELECT nextval('LOGGING_EVENT_ID_SEQ');
SELECT currval('LOGGING_EVENT_ID_SEQ');

-- SELECT * FROM LOGGING_EVENT;
CREATE TABLE LOGGING_EVENT (
    TIMESTMP          BIGINT NOT NULL,
    FORMATTED_MESSAGE TEXT NOT NULL,
    LOGGER_NAME       VARCHAR(254) NOT NULL,
    LEVEL_STRING      VARCHAR(254) NOT NULL,
    REFERENCE_FLAG    SMALLINT,
    CALLER_FILENAME   VARCHAR(254) NOT NULL,
    CALLER_CLASS      VARCHAR(254) NOT NULL,
    CALLER_METHOD     VARCHAR(254) NOT NULL,
    CALLER_LINE       CHAR(4) NOT NULL,
    EVENT_ID          BIGINT NOT NULL PRIMARY KEY
);
COMMENT ON TABLE LOGGING_EVENT IS 'LOGBACK: event data';
COMMENT ON COLUMN LOGGING_EVENT.TIMESTMP IS 'The timestamp that was valid at the logging event''s creation';
COMMENT ON COLUMN LOGGING_EVENT.FORMATTED_MESSAGE IS 'The message that has been added to the logging event';
COMMENT ON COLUMN LOGGING_EVENT.LOGGER_NAME IS 'The name of the logger used to issue the logging request';
COMMENT ON COLUMN LOGGING_EVENT.LEVEL_STRING IS 'The level of the logging event';
COMMENT ON COLUMN LOGGING_EVENT.REFERENCE_FLAG IS 'identify logging events that have an exception or MDCproperty values associated';
COMMENT ON COLUMN LOGGING_EVENT.CALLER_FILENAME IS 'The name of the file where the logging request was issued';
COMMENT ON COLUMN LOGGING_EVENT.CALLER_CLASS IS 'The class where the logging request was issued';
COMMENT ON COLUMN LOGGING_EVENT.CALLER_METHOD IS 'The name of the method where the logging request was issued';
COMMENT ON COLUMN LOGGING_EVENT.CALLER_LINE IS 'The line number where the logging request was issued';
COMMENT ON COLUMN LOGGING_EVENT.EVENT_ID IS 'The database id of the logging event';

-- SELECT * FROM LOGGING_EVENT_PROPERTY;
CREATE TABLE LOGGING_EVENT_PROPERTY (
    EVENT_ID	      BIGINT NOT NULL,
    MAPPED_KEY        VARCHAR(254) NOT NULL,
    MAPPED_VALUE      TEXT,
    PRIMARY KEY(EVENT_ID, MAPPED_KEY),
    FOREIGN KEY (EVENT_ID) REFERENCES LOGGING_EVENT(EVENT_ID)
);
COMMENT ON TABLE LOGGING_EVENT_PROPERTY IS 'LOGBACK: store the keys and values contained in the MDC or the Context';

-- SELECT * FROM LOGGING_EVENT_EXCEPTION;
CREATE TABLE LOGGING_EVENT_EXCEPTION (
    EVENT_ID         BIGINT NOT NULL,
    I                SMALLINT NOT NULL,
    TRACE_LINE       VARCHAR(254) NOT NULL,
    PRIMARY KEY(EVENT_ID, I),
    FOREIGN KEY (EVENT_ID) REFERENCES LOGGING_EVENT(EVENT_ID)
);
COMMENT ON TABLE LOGGING_EVENT_EXCEPTION IS 'LOGBACK: event exception';


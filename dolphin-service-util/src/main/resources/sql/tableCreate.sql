/*咨询分类*/
CREATE TABLE `Consult` (
  `Id`          INT(11)   NOT NULL AUTO_INCREMENT
  COMMENT '咨询分类Id',
  `AddTime`     DATETIME           DEFAULT NULL,
  `UpdateTime`  TIMESTAMP NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Code`        VARCHAR(100)       DEFAULT NULL
  COMMENT 'code代码',
  `Name`        VARCHAR(100)       DEFAULT NULL
  COMMENT '咨询分类名称',
  `ParentId`    INT(11)            DEFAULT '0'
  COMMENT '父咨询分类Id',
  `SkillId`     INT(11)            DEFAULT NULL
  COMMENT '技能组别ID',
  `IsDelete`    TINYINT(1)         DEFAULT NULL
  COMMENT '是否删除',
  `Rank`        INT(11)            DEFAULT NULL
  COMMENT '顺序',
  `IconUrl`     VARCHAR(100)       DEFAULT NULL
  COMMENT 'Icon的路径',
  `ChannelType` TINYINT(4)         DEFAULT NULL
  COMMENT '渠道（10 微信, 20 网页, 30 手机）',
  PRIMARY KEY (`Id`),
  KEY `IX_UpdateTime` (`UpdateTime`) USING BTREE
)
  ENGINE =InnoDB
  AUTO_INCREMENT =1
  DEFAULT CHARSET =utf8
  COMMENT ='咨询分类表';


/*用户信息*/
CREATE TABLE `Customer` (
  `Id`       INT(11) NOT NULL AUTO_INCREMENT
  COMMENT '顾客ID',
  `OpenId`   VARCHAR(100)     DEFAULT NULL
  COMMENT '账号ID，有业务含义',
  `Status`   VARCHAR(100)     DEFAULT NULL
  COMMENT '状态（0无效1有效）',
  `UserType` VARCHAR(100)     DEFAULT NULL
  COMMENT '顾客类型',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_OPEN_ID_USER_TYPE` (`OpenId`, `UserType`) USING BTREE
)
  ENGINE =InnoDB
  AUTO_INCREMENT =1
  DEFAULT CHARSET =utf8
  COMMENT ='客户信息';

/*在线用户表*/
CREATE TABLE `CustomerOnline` (
  `Id`             INT(11) NOT NULL AUTO_INCREMENT
  COMMENT '在线Id',
  `CustomerId`     INT(11)          DEFAULT NULL
  COMMENT '客户ID',
  `Status`         VARCHAR(100)     DEFAULT NULL
  COMMENT '状态 10 进入 20 排队 30 对话 40 退出 50 超时踢出 60排队超过最大人数 70 没有客服在线 80 客服主观退出',
  `AddTime`        DATETIME         DEFAULT NULL
  COMMENT '进入时间',
  `ChannelType`    VARCHAR(100)     DEFAULT NULL
  COMMENT '来源(10 微信, 20 网页 30 手机)',
  `Subsource`      VARCHAR(100)     DEFAULT NULL
  COMMENT '子来源',
  `Nickname`       VARCHAR(200)     DEFAULT NULL
  COMMENT '客户昵称',
  `SkillId`        INT(11)          DEFAULT NULL
  COMMENT '技能组Id',
  `Priority`       INT(11)          DEFAULT '0'
  COMMENT '优先级',
  `ConsultId`      VARCHAR(100)     DEFAULT NULL
  COMMENT '咨询分类Id',
  `ServerIP`       VARCHAR(100)     DEFAULT NULL,
  `DeviceId`       VARCHAR(100)     DEFAULT NULL
  COMMENT '设备ID，native app支持推送的时候有用',
  `ManualDialogId` INT(11)          DEFAULT '0'
  COMMENT '人工会话Id',
  `GlobalDialogId` INT(11)          DEFAULT '0'
  COMMENT '全局会话Id',
  `Cookie`         VARCHAR(2000)    DEFAULT NULL
  COMMENT '带入的其他补充信息',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_CUSTOMER_ID` (`CustomerId`) USING BTREE
)
  ENGINE =InnoDB
  AUTO_INCREMENT =1
  DEFAULT CHARSET =utf8
  COMMENT ='客户在线信息表';

/**用户进入流水**/
CREATE TABLE `CustomerStatusLog` (
  `Id`             INT(11) NOT NULL AUTO_INCREMENT
  COMMENT '主键ID',
  `CustomerId`     INT(11)          DEFAULT NULL
  COMMENT '顾客ID',
  `ManualDialogId` INT(11)          DEFAULT '0'
  COMMENT '人工会话Id',
  `GlobalDialogId` INT(11)          DEFAULT NULL
  COMMENT '在线全局ID',
  `Status`         VARCHAR(100)     DEFAULT NULL
  COMMENT '状态,10进入，20排队等待，30服务中，40退出，50超时踢出，60排队超过最大数踢出,70没有客服在线退出,80机器人服务中',
  `AddTime`        DATETIME         DEFAULT NULL
  COMMENT '添加时间',
  `ChannelType`    VARCHAR(100)     DEFAULT NULL
  COMMENT '来源(10 微信, 20 网页 30 手机)',
  `Nickname`       VARCHAR(200)     DEFAULT NULL
  COMMENT '账号昵称',
  `IP`             VARCHAR(100)     DEFAULT NULL
  COMMENT 'IP',
  `SkillId`        INT(11)          DEFAULT NULL
  COMMENT '技能组ID',
  `ConsultId`      VARCHAR(100)     DEFAULT NULL
  COMMENT '咨询分类',
  PRIMARY KEY (`ID`),
  KEY `IX_AddTimeStatus` (`AddTime`, `STATUS`) USING BTREE,
  KEY `IX_ManualDialogId` (`ManualDialogId`) USING BTREE,
  KEY `IX_CustomerId` (`CustomerId`) USING BTREE
)
  ENGINE =InnoDB
  AUTO_INCREMENT =1
  DEFAULT CHARSET =utf8
  COMMENT ='客户状态日志';

/*技能组*/
CREATE TABLE `Skill` (
  `Id`         INT(11)   NOT NULL AUTO_INCREMENT
  COMMENT '技能组Id',
  `AddTime`    DATETIME           DEFAULT NULL,
  `UpdateTime` TIMESTAMP NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Name`       VARCHAR(100)       DEFAULT NULL
  COMMENT '技能组名',
  `IsDelete`   TINYINT(4)         DEFAULT NULL
  COMMENT '是否删除',
  `DeptId`     INT(11)            DEFAULT NULL
  COMMENT '部门ID',
  PRIMARY KEY (`Id`),
  KEY `IX_UpdateTime` (`UpdateTime`)
)
  ENGINE =InnoDB
  AUTO_INCREMENT =1
  DEFAULT CHARSET =utf8
  COMMENT ='技能组表';

/*全局对话*/
CREATE TABLE `GlobalDialog` (
  `Id`          INT(11)   NOT NULL AUTO_INCREMENT
  COMMENT '会话Id',
  `AddTime`     DATETIME           DEFAULT NULL,
  `UpdateTime`  TIMESTAMP NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CustomerId`  INT(11)            DEFAULT NULL
  COMMENT '用户Id',
  `ConsultId`   INT(11)            DEFAULT NULL
  COMMENT '咨询类别ID',
  `SkillId`     INT(11)            DEFAULT NULL
  COMMENT '技能组别ID',
  `ChannelType` TINYINT(4)         DEFAULT NULL
  COMMENT '来源（10 微信, 20 网页 30 手机）',
  PRIMARY KEY (`Id`),
  KEY `IX_UpdateTime` (`UpdateTime`) USING BTREE,
  KEY `IX_CustomerID` (`CustomerId`) USING BTREE
)
  ENGINE =InnoDB
  AUTO_INCREMENT =1
  DEFAULT CHARSET =utf8
  COMMENT ='全局会话表';


/*人工对话*/
CREATE TABLE `ManualService` (
  `Id`             INT(11)   NOT NULL AUTO_INCREMENT
  COMMENT '内部ID',
  `StaffId`        INT(11)   NOT NULL
  COMMENT '员工ID',
  `CustomerId`     INT(11)            DEFAULT NULL
  COMMENT '客户ID',
  `GlobalDialogId` INT(11)            DEFAULT NULL
  COMMENT '全局对话Id',
  `SkillId`        INT(11)            DEFAULT NULL
  COMMENT '技能组ID',
  `AddTime`        DATETIME           DEFAULT NULL
  COMMENT '开始时间',
  `EndTime`        DATETIME           DEFAULT NULL
  COMMENT '结束时间',
  `Evaluation`     VARCHAR(100)       DEFAULT NULL
  COMMENT '评价内容(1鲜花，0鸡蛋)',
  `EvaluationTime` DATETIME           DEFAULT NULL
  COMMENT '评价时间',
  `UpdateTime`     TIMESTAMP NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ChannelType`    TINYINT(4)         DEFAULT NULL
  COMMENT '来源（10 微信, 20 网页 30 手机）',
  `EndType`        TINYINT(4)         DEFAULT '0'
  COMMENT '10:用户超时退出，20：用户主动退出，30：客服主动退出，40：allocate后通知失败回滚',
  PRIMARY KEY (`Id`),
  KEY `IX_AddTime` (`AddTime`) USING BTREE,
  KEY `IX_CustomerId` (`CustomerId`) USING BTREE,
  KEY `IX_GlobalDialogId` (`GlobalDialogId`) USING BTREE,
  KEY `IX_AddTime_EndTime_SkillId` (`AddTime`, `EndTime`, `SkillId`) USING BTREE
)
  ENGINE =InnoDB
  AUTO_INCREMENT =1
  DEFAULT CHARSET =utf8
  COMMENT ='人工会话表';

/*机器人对话*/
CREATE TABLE `RobotDialog` (
  `Id`             INT(11)   NOT NULL AUTO_INCREMENT,
  `AddTime`        DATETIME           DEFAULT NULL,
  `UpdateTime`     TIMESTAMP NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `GlobalDialogId` INT(11)            DEFAULT NULL
  COMMENT '会话Id',
  PRIMARY KEY (`Id`),
  KEY `IX_UpdateTime` (`UpdateTime`) USING BTREE,
  KEY `IX_GlobalDialogID` (`GlobalDialogId`) USING BTREE
)
  ENGINE =InnoDB
  AUTO_INCREMENT =957872
  DEFAULT CHARSET =utf8
  COMMENT ='机器人会话表';


/*人工对话消息*/
CREATE TABLE `ManualMessage` (
  `Id`             INT(11)   NOT NULL AUTO_INCREMENT
  COMMENT '人工对话消息Id',
  `AddTime`        DATETIME           DEFAULT NULL,
  `UpdateTime`     TIMESTAMP NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CustomerId`     INT(11)            DEFAULT NULL
  COMMENT '客户Id',
  `StaffId`        INT(11)            DEFAULT NULL
  COMMENT '员工Id',
  `ManualDialogId` INT(11)            DEFAULT NULL
  COMMENT '人工会话Id',
  `ChannelType`    TINYINT(4)         DEFAULT NULL
  COMMENT '来源（10 微信, 20 网页 30 手机）',
  `MsgType`        VARCHAR(100)       DEFAULT NULL
  COMMENT '消息类型,文本，评价，欢迎语等有业务含义的消息',
  `Content`        MEDIUMTEXT COMMENT '消息内容',
  `From`           VARCHAR(100)       DEFAULT NULL
  COMMENT '消息发送方',
  `To`             VARCHAR(100)       DEFAULT NULL
  COMMENT '消息接收方',
  `Status`         VARCHAR(100)       DEFAULT NULL
  COMMENT '0未读；1已读）',
  `SkillId`        INT(11)            DEFAULT NULL
  COMMENT '技能组ID',
  `ConsultId`      INT(11)            DEFAULT NULL
  COMMENT '咨询分类',
  PRIMARY KEY (`Id`),
  KEY `IX_AddTime` (`AddTime`) USING BTREE,
  KEY `IX_UpdateTime` (`UpdateTime`) USING BTREE,
  KEY `IX_CustomerId` (`CustomerId`) USING BTREE
)
  ENGINE =InnoDB
  AUTO_INCREMENT =1
  DEFAULT CHARSET =utf8
  COMMENT ='人工消息';

/**
机器人消息
 */
CREATE TABLE `RobotMessage` (
  `Id`            INT(11)   NOT NULL AUTO_INCREMENT
  COMMENT '机器人对话消息Id',
  `AddTime`       DATETIME           DEFAULT NULL,
  `UpdateTime`    TIMESTAMP NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CustomerId`    INT(11)            DEFAULT NULL
  COMMENT '客户Id',
  `RobotId`       INT(11)            DEFAULT NULL
  COMMENT '机器人Id',
  `RobotDialogId` INT(11)            DEFAULT NULL
  COMMENT '人工会话Id',
  `ChannelType`   TINYINT(4)         DEFAULT NULL
  COMMENT '来源（10 微信, 20 网页 30 手机）',
  `MsgType`       VARCHAR(100)       DEFAULT NULL
  COMMENT '消息类型,文本，评价，欢迎语等有业务含义的消息',
  `Content`       MEDIUMTEXT COMMENT '消息内容',
  `From`          VARCHAR(100)       DEFAULT NULL
  COMMENT '消息发送方',
  `To`            VARCHAR(100)       DEFAULT NULL
  COMMENT '消息接收方',
  `ConsultId`     INT(11)            DEFAULT NULL
  COMMENT '咨询分类',
  PRIMARY KEY (`Id`),
  KEY `IX_AddTime` (`AddTime`) USING BTREE,
  KEY `IX_UpdateTime` (`UpdateTime`) USING BTREE,
  KEY `IX_CustomerId` (`CustomerId`) USING BTREE
)
  ENGINE =InnoDB
  AUTO_INCREMENT =1
  DEFAULT CHARSET =utf8
  COMMENT ='机器人消息';


/**
  员工技能组关系表
 */
CREATE TABLE `StaffSkill` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `AddTime` datetime DEFAULT NULL,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `StaffId` int(11) NOT NULL DEFAULT '0' COMMENT '员工ID，对应staff表',
  `SkillId` int(11) NOT NULL DEFAULT '0' COMMENT '技能组ID，对应技能组表',
  PRIMARY KEY (`Id`),
  KEY `IX_UpdateTime` (`UpdateTime`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


/**
员工基本信息
 */
CREATE TABLE `Staff` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工Id',
  `AddTime` datetime DEFAULT NULL,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DeptId` int(11) DEFAULT NULL COMMENT '部门ID',
  `Grade` varchar(100) DEFAULT NULL COMMENT '坐席等级（10 主管; 20普通员工）',
  `StaffNO` varchar(100) NOT NULL COMMENT '员工工号',
  `RealName` varchar(200) NOT NULL COMMENT '员工姓名',
  `Password` varchar(200) DEFAULT NULL COMMENT '登录密码',
  `Status` varchar(100) NOT NULL COMMENT '状态（0无效1有效）',
  `Sex` varchar(100) DEFAULT NULL COMMENT '性别',
  `Phone` varchar(100) DEFAULT NULL COMMENT '电话',
  `Email` varchar(100) DEFAULT NULL COMMENT '电子邮件',
  `MaxReceptionNum` int(11) DEFAULT NULL COMMENT '最大接待数',
  `MinReceptionNum` int(11) DEFAULT '1' COMMENT '最小接待数',
  `AddStaffId` int(11) DEFAULT NULL COMMENT '创建人ID',
  `UpdateStaffId` int(11) DEFAULT NULL COMMENT '修改人员id',
  `Nickname` varchar(200) DEFAULT NULL COMMENT '员工昵称',
  `Skin` text CHARACTER SET ujis COMMENT '聊天界面的皮肤',
  `WelcomeGreeting` text COMMENT '欢迎语',
  PRIMARY KEY (`Id`),
  KEY `IX_DeptId` (`DeptId`) USING BTREE,
  KEY `IX_StaffNO` (`StaffNO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='员工基本信息';


/*员工在线信息表*/
CREATE TABLE `StaffOnline` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `AddTime` datetime DEFAULT NULL,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `StaffId` int(11) DEFAULT NULL COMMENT '员工ID',
  `ServerIP` varchar(200) DEFAULT NULL COMMENT '登录服务器IP',
  `ReceptionNum` int(11) DEFAULT NULL COMMENT '接待人数',
  `MaxReceptionNum` int(11) DEFAULT NULL COMMENT '最大接待人数',
  `Status` varchar(100) DEFAULT NULL COMMENT '当前状态,10待机，20联机，30忙碌，40公务，50用餐，60退出，70休息,80离线',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_STAFF_ID` (`StaffId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='员工在线信息';


/*员工状态流水*/
CREATE TABLE `StaffStatusLog` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `AddTime` datetime DEFAULT NULL,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `StaffId` int(11) DEFAULT NULL COMMENT '员工ID',
  `ManualDialogId` int(11) DEFAULT NULL COMMENT '在线ID',
  `ServerIP` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '登录服务器IP',
  `ReceptionNum` int(11) DEFAULT NULL COMMENT '接待人数',
  `MaxreceptionNum` int(11) DEFAULT NULL COMMENT '最大接待人数',
  `Status` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '当前状态10待机，20联机，30忙碌，40公务，50用餐，60退出，70休息',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='员工状态日志';


/*部门基本信息表*/
CREATE TABLE `Department` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AddTime` datetime NOT NULL,
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Name` varchar(200) NOT NULL COMMENT '部门名称',
  `ParentId` int(11) NOT NULL COMMENT '父部门ID',
  `IsDelete` int(4) NOT NULL DEFAULT '0' COMMENT '是否删除:1是，0否',
  PRIMARY KEY (`ID`),
  KEY `IX_AddTime` (`AddTime`) USING BTREE,
  KEY `IX_UpdateTime` (`UpdateTime`) USING BTREE,
  KEY `IX_Name` (`Name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*部门配置表*/
CREATE TABLE `DepartmentConfig` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `AddTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DepartmentId` int(11) DEFAULT '0' COMMENT '部门id',
  `ChannelType` smallint(2) DEFAULT '0' COMMENT '渠道类型0=ALL|10=微信|20=网页|30=手机',
  `WorkTimeBegin` varchar(16) DEFAULT NULL COMMENT '开始工作时间',
  `WorkTimeEnd` varchar(16) DEFAULT NULL COMMENT '结束工作时间',
  `ReplyTimeout` int(11) DEFAULT NULL COMMENT '客户回复时间(秒)',
  `UserExitTimeout` int(11) DEFAULT NULL COMMENT '用户超时退出时间(秒)',
  `IsEnableRobot` smallint(1) DEFAULT NULL COMMENT '是否启用机器人',
  `QueueReply` text COMMENT '排队术语',
  `NonWorkTimeReply` text COMMENT '非工作时间术语',
  `TimeoutReply` text,
  `RobotWelcomeReply` text COMMENT '机器人欢迎语',
  `ManualWelcomeReply` text COMMENT '用户接入人工时开头语',
  `UserExitReply` text COMMENT '用户超时未回复被踢出语句',
  `UpdateStaffId` int(11) DEFAULT NULL COMMENT '修改人员id',
  `GlobalWelcomeReply` text COMMENT '全局对话欢迎语',
  `AddStaffId` int(11) DEFAULT NULL COMMENT '添加人员id',
  `UserType` varchar(32) DEFAULT '10' COMMENT '部门所服务的用户类型（10点评用户、20点评商户、30dper、40美团用户、50美团商户）',
  PRIMARY KEY (`Id`),
  KEY `index_AddTime` (`AddTime`) USING HASH,
  KEY `index_UpdateTime` (`UpdateTime`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*客服快捷回复分类*/
CREATE TABLE `ReplyCategory` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `AddTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `DeptId` int(11) DEFAULT NULL COMMENT '部门ID',
  `StaffId` int(11) DEFAULT NULL COMMENT '员工ID',
  `CategoryName` varchar(255) DEFAULT NULL COMMENT '分类名',
  `AddStaffId` int(11) DEFAULT NULL COMMENT '添加人ID',
  `UpdateStaffId` int(11) DEFAULT NULL COMMENT '更新人ID',
  `Rank` int(11) DEFAULT '1' COMMENT '常用术语分类排序',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*客服快捷回复*/
CREATE TABLE `Reply` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `AddTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `ReplyCategoryId` int(11) DEFAULT NULL COMMENT '分类ID',
  `Content` text COMMENT '内容',
  `Title` varchar(255) DEFAULT NULL COMMENT '标题，页面右侧显示的简短内容',
  `AddStaffId` int(11) DEFAULT NULL COMMENT '添加人ID',
  `UpdateStaffId` int(11) DEFAULT NULL COMMENT '更新人ID',
  `Rank` int(11) DEFAULT '1' COMMENT '常用术语排序',
  PRIMARY KEY (`Id`),
  KEY `IX_ReplyCategoryId` (`ReplyCategoryId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;




-- *************** SqlDBM: PostgreSQL ****************;
-- ***************************************************;


-- ************************************** "User"

CREATE TABLE "User"
(
 Email       varchar(50) NOT NULL,
 name        varchar(50) NOT NULL,
 phoneNumber varchar(50) NOT NULL,
 password    varchar(50) NOT NULL,
 CONSTRAINT PK_user PRIMARY KEY ( Email )
);


-- ************************************** Employer

CREATE TABLE Employer
(
 Email varchar(50) NOT NULL,
 CONSTRAINT PK_employer PRIMARY KEY ( Email ),
 CONSTRAINT FK_85 FOREIGN KEY ( Email ) REFERENCES "User" ( Email )
);

CREATE INDEX fkIdx_86 ON Employer
(
 Email
);


-- ************************************** Freelancer

CREATE TABLE Freelancer
(
 Email varchar(50) NOT NULL,
 CONSTRAINT PK_freelancer PRIMARY KEY ( Email ),
 CONSTRAINT FK_88 FOREIGN KEY ( Email ) REFERENCES "User" ( Email )
);

CREATE INDEX fkIdx_89 ON Freelancer
(
 Email
);



-- ************************************** Friend

CREATE TABLE Friend
(
 Email varchar(50) NOT NULL,
 name  varchar(50) NOT NULL,
 CONSTRAINT PK_friend PRIMARY KEY ( Email )
);


-- ************************************** InviteFriend

CREATE TABLE InviteFriend
(
 userEmail      varchar(50) NOT NULL,
 friendEmail    varchar(50) NOT NULL,
 inviteFriendId int NOT NULL,
 "date"           date NOT NULL,
 "time"           time NOT NULL,
 CONSTRAINT PK_invitefriend PRIMARY KEY ( inviteFriendId ),
 CONSTRAINT FK_110 FOREIGN KEY ( userEmail ) REFERENCES "User" ( Email ),
 CONSTRAINT FK_113 FOREIGN KEY ( friendEmail ) REFERENCES Friend ( Email )
);

CREATE INDEX fkIdx_111 ON InviteFriend
(
 userEmail
);

CREATE INDEX fkIdx_114 ON InviteFriend
(
 friendEmail
);


-- ************************************** Project

CREATE TABLE Project
(
 code               varchar(50) NOT NULL,
 name               varchar(50) NOT NULL,
 categories         json NOT NULL,
 deadline           date NOT NULL,
 skills             json NOT NULL,
 money              varchar(50) NOT NULL,
 "size"               money NOT NULL,
 requestDescription varchar(50) NOT NULL,
 employerEmail      varchar(50) NOT NULL,
 CONSTRAINT PK_project PRIMARY KEY ( code ),
 CONSTRAINT FK_228 FOREIGN KEY ( employerEmail ) REFERENCES Employer ( Email )
);

CREATE INDEX fkIdx_229 ON Project
(
 employerEmail
);


-- ************************************** Ticket

CREATE TABLE Ticket
(
 "id"            uuid NOT NULL,
 message       varchar(50) NOT NULL,
 type          varchar(50) NOT NULL,
 name          varchar(50) NOT NULL,
 projectCode   varchar(50) NULL,
 employerEmail varchar(50) NOT NULL,
 CONSTRAINT PK_ticket PRIMARY KEY ( "id" ),
 CONSTRAINT FK_231 FOREIGN KEY ( employerEmail ) REFERENCES "User" ( Email ),
 CONSTRAINT FK_91 FOREIGN KEY ( projectCode ) REFERENCES Project ( code )
);

CREATE INDEX fkIdx_232 ON Ticket
(
 employerEmail
);

CREATE INDEX fkIdx_92 ON Ticket
(
 projectCode
);


-- ************************************** CreateTicket

CREATE TABLE CreateTicket
(
 employerEmail  varchar(50) NOT NULL,
 createTicketId int NOT NULL,
 ticketId       uuid NOT NULL,
 CONSTRAINT PK_createticket PRIMARY KEY ( createTicketId ),
 CONSTRAINT FK_219 FOREIGN KEY ( employerEmail ) REFERENCES "User" ( Email ),
 CONSTRAINT FK_223 FOREIGN KEY ( ticketId ) REFERENCES Ticket ( "id" )
);

CREATE INDEX fkIdx_220 ON CreateTicket
(
 employerEmail
);

CREATE INDEX fkIdx_224 ON CreateTicket
(
 ticketId
);


-- ************************************** FinancialInfo

CREATE TABLE FinancialInfo
(
 bank             varchar(50) NOT NULL,
 shabaNumber      varchar(50) NOT NULL,
 accountOwnerName varchar(50) NOT NULL,
 CONSTRAINT PK_financialinfo PRIMARY KEY ( bank, shabaNumber )
);


-- ************************************** EditFinancialInfo

CREATE TABLE EditFinancialInfo
(
 bank                varchar(50) NOT NULL,
 shabaNumber         varchar(50) NOT NULL,
 userEmail           varchar(50) NOT NULL,
 editFinancialInfoId int NOT NULL,
 CONSTRAINT PK_editfinancialinfo PRIMARY KEY ( editFinancialInfoId ),
 CONSTRAINT FK_172 FOREIGN KEY ( bank, shabaNumber ) REFERENCES FinancialInfo ( bank, shabaNumber ),
 CONSTRAINT FK_176 FOREIGN KEY ( userEmail ) REFERENCES "User" ( Email )
);

CREATE INDEX fkIdx_173 ON EditFinancialInfo
(
 bank,
 shabaNumber
);

CREATE INDEX fkIdx_177 ON EditFinancialInfo
(
 userEmail
);



-- ************************************** InviteFreelancer

CREATE TABLE InviteFreelancer
(
 freelancerEmail    varchar(50) NOT NULL,
 employerEmail      varchar(50) NOT NULL,
 projectCode        varchar(50) NOT NULL,
 inviteFreelancerId int NOT NULL,
 "date"               date NOT NULL,
 "time"               time NOT NULL,
 CONSTRAINT PK_invitefreelancer PRIMARY KEY ( inviteFreelancerId ),
 CONSTRAINT FK_100 FOREIGN KEY ( employerEmail ) REFERENCES Employer ( Email ),
 CONSTRAINT FK_106 FOREIGN KEY ( projectCode ) REFERENCES Project ( code ),
 CONSTRAINT FK_97 FOREIGN KEY ( freelancerEmail ) REFERENCES Freelancer ( Email )
);

CREATE INDEX fkIdx_101 ON InviteFreelancer
(
 employerEmail
);

CREATE INDEX fkIdx_107 ON InviteFreelancer
(
 projectCode
);

CREATE INDEX fkIdx_98 ON InviteFreelancer
(
 freelancerEmail
);


-- ************************************** MonthlyIncome

CREATE TABLE MonthlyIncome
(
 year             int NOT NULL,
 month            int NOT NULL,
 projectIncome    money NOT NULL,
 invitationIncome money NOT NULL,
 status           varchar(50) NOT NULL,
 Email            varchar(50) NOT NULL,
 CONSTRAINT PK_monthlyincome PRIMARY KEY ( year, month, Email ),
 CONSTRAINT FK_202 FOREIGN KEY ( Email ) REFERENCES "User" ( Email )
);

CREATE INDEX fkIdx_203 ON MonthlyIncome
(
 Email
);


-- ************************************** Offer

CREATE TABLE Offer
(
 "id"          int NOT NULL,
 price       money NOT NULL,
 description varchar(50) NOT NULL,
 CONSTRAINT PK_offer PRIMARY KEY ( "id" )
);


-- ************************************** OrderProject

CREATE TABLE OrderProject
(
 orderProjectId int NOT NULL,
 employerEmail  varchar(50) NOT NULL,
 projectCode    varchar(50) NOT NULL,
 "date"           date NOT NULL,
 "time"           time NOT NULL,
 CONSTRAINT PK_orderproject PRIMARY KEY ( orderProjectId ),
 CONSTRAINT FK_207 FOREIGN KEY ( employerEmail ) REFERENCES Employer ( Email ),
 CONSTRAINT FK_210 FOREIGN KEY ( projectCode ) REFERENCES Project ( code )
);

CREATE INDEX fkIdx_208 ON OrderProject
(
 employerEmail
);

CREATE INDEX fkIdx_211 ON OrderProject
(
 projectCode
);



-- ************************************** Profile

CREATE TABLE Profile
(
 "id"              uuid NOT NULL,
 lastSeen        date NOT NULL,
 score           int NOT NULL,
 visits          int NOT NULL,
 signupDate      date NOT NULL,
 freelancerEmail varchar(50) NOT NULL,
 CONSTRAINT PK_profile PRIMARY KEY ( "id", freelancerEmail ),
 CONSTRAINT FK_193 FOREIGN KEY ( freelancerEmail ) REFERENCES Freelancer ( Email )
);

CREATE INDEX fkIdx_194 ON Profile
(
 freelancerEmail
);


-- ************************************** Resume

CREATE TABLE Resume
(
 alias            varchar(50) NOT NULL,
 profileId        uuid NOT NULL,
 freelancerEmail  varchar(50) NOT NULL,
 workExperiences  json NULL,
 favourites       json NULL,
 certificates     json NULL,
 skills           json NULL,
 foreignLanguages json NULL,
 introduction     varchar(50) NULL,
 CONSTRAINT PK_resume PRIMARY KEY ( alias, profileId, freelancerEmail ),
 CONSTRAINT FK_189 FOREIGN KEY ( profileId, freelancerEmail ) REFERENCES Profile ( "id", freelancerEmail )
);

CREATE INDEX fkIdx_190 ON Resume
(
 profileId,
 freelancerEmail
);



-- ************************************** EditResume

CREATE TABLE EditResume
(
 editResumeId    int NOT NULL,
 alias           varchar(50) NOT NULL,
 profileId       uuid NOT NULL,
 freelancerEmail varchar(50) NOT NULL,
 CONSTRAINT PK_editresume PRIMARY KEY ( editResumeId ),
 CONSTRAINT FK_155 FOREIGN KEY ( freelancerEmail ) REFERENCES Freelancer ( Email ),
 CONSTRAINT FK_158 FOREIGN KEY ( alias, profileId, freelancerEmail ) REFERENCES Resume ( alias, profileId, freelancerEmail )
);

CREATE INDEX fkIdx_156 ON EditResume
(
 freelancerEmail
);

CREATE INDEX fkIdx_159 ON EditResume
(
 alias,
 profileId,
 freelancerEmail
);



-- ************************************** SampleWork

CREATE TABLE SampleWork
(
 name         varchar(50) NOT NULL,
 tags         json NOT NULL,
 skills       json NOT NULL,
 description  varchar(50) NOT NULL,
 photoAddress varchar(50) NOT NULL,
 Email        varchar(50) NOT NULL,
 CONSTRAINT PK_samplework PRIMARY KEY ( name, Email ),
 CONSTRAINT FK_199 FOREIGN KEY ( Email ) REFERENCES Freelancer ( Email )
);

CREATE INDEX fkIdx_200 ON SampleWork
(
 Email
);



-- ************************************** SeeIncome

CREATE TABLE SeeIncome
(
 seeIncomeId int NOT NULL,
 year        int NOT NULL,
 month       int NOT NULL,
 Email       varchar(50) NOT NULL,
 CONSTRAINT PK_seeincome PRIMARY KEY ( seeIncomeId ),
 CONSTRAINT FK_134 FOREIGN KEY ( year, month, Email ) REFERENCES MonthlyIncome ( year, month, Email ),
 CONSTRAINT FK_138 FOREIGN KEY ( Email ) REFERENCES "User" ( Email )
);

CREATE INDEX fkIdx_135 ON SeeIncome
(
 year,
 month,
 Email
);

CREATE INDEX fkIdx_139 ON SeeIncome
(
 Email
);


-- ************************************** SeeProfile

CREATE TABLE SeeProfile
(
 seeProfileId    int NOT NULL,
 employerEmail   varchar(50) NOT NULL,
 profileId       uuid NOT NULL,
 freelancerEmail varchar(50) NOT NULL,
 CONSTRAINT PK_seeprofile PRIMARY KEY ( seeProfileId ),
 CONSTRAINT FK_146 FOREIGN KEY ( employerEmail ) REFERENCES Employer ( Email ),
 CONSTRAINT FK_149 FOREIGN KEY ( profileId, freelancerEmail ) REFERENCES Profile ( "id", freelancerEmail )
);

CREATE INDEX fkIdx_147 ON SeeProfile
(
 employerEmail
);

CREATE INDEX fkIdx_150 ON SeeProfile
(
 profileId,
 freelancerEmail
);


-- ************************************** SendOffer

CREATE TABLE SendOffer
(
 offer           int NOT NULL,
 sendOfferId     int NOT NULL,
 freelancerEmail varchar(50) NOT NULL,
 projectCode     varchar(50) NOT NULL,
 "date"            date NOT NULL,
 "time"            time NOT NULL,
 CONSTRAINT PK_sendoffer PRIMARY KEY ( sendOfferId ),
 CONSTRAINT FK_121 FOREIGN KEY ( offer ) REFERENCES Offer ( "id" ),
 CONSTRAINT FK_124 FOREIGN KEY ( freelancerEmail ) REFERENCES Freelancer ( Email ),
 CONSTRAINT FK_127 FOREIGN KEY ( projectCode ) REFERENCES Project ( code )
);

CREATE INDEX fkIdx_122 ON SendOffer
(
 offer
);

CREATE INDEX fkIdx_125 ON SendOffer
(
 freelancerEmail
);

CREATE INDEX fkIdx_128 ON SendOffer
(
 projectCode
);
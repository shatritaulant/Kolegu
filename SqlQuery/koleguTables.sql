CREATE DATABASE IF NOT EXISTS Kolegu;
USE Kolegu;

CREATE TABLE IF NOT EXISTS User(
	Username varchar(50) PRIMARY KEY,
    Password BINARY(128)NOT NULL,
    Description varchar(1000),
    Avatar varchar(100),
    Rank varchar(50),
    Role varchar(50),
    Reputation int
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Achievement(
	Title varchar(50) PRIMARY KEY,
    Description varchar(300) NOT NULL,
    ReputationAward int NOT NULL,
    Difficulty varchar(20) NOT NULL	CHECK (Difficulty = 'Easy' OR 'Medium' OR 'Hard')
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS UserAchievement(
	UserAchievementID int PRIMARY KEY AUTO_INCREMENT,
    
    AchievementTitle varchar(50) NOT NULL,
    Username varchar(50) NOT NULL NOT NULL,
    CONSTRAINT fk_UserAchievement_Achievement_Title FOREIGN KEY (AchievementTitle ) REFERENCES Achievement(Title),
    CONSTRAINT fk_UserAchievement_Username FOREIGN KEY (Username) REFERENCES User(Username),
	UNIQUE KEY `AchievementTitleUsername`(`AchievementTitle`,`Username`)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Settings(
	SettingsID int PRIMARY KEY AUTO_INCREMENT,
    SeeQuestion varchar(10) CHECK(SeeQuestion='Yes' OR 'No'),
    SeeReplies varchar(10) CHECK(SeeReplies='Yes' OR 'No'),
    SeeBadges varchar(10) CHECK(SeeBadges='Yes' OR 'No'),
    
    Username varchar(50) UNIQUE,
    CONSTRAINT fk_Settings_Username FOREIGN KEY (Username) REFERENCES User(Username)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE  TABLE IF NOT EXISTS Suggestion(
	SuggestionID int PRIMARY KEY AUTO_INCREMENT,
    Title varchar(50) NOT NULL,
    Content varchar(600) NOT NULL,
    Date date,
    
    Username varchar(50) NOT NULL,
    CONSTRAINT fk_Suggestion_Username FOREIGN KEY (Username) REFERENCES User(Username)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Message (
	MessageID int PRIMARY KEY AUTO_INCREMENT,
    Content varchar(500) NOT NULL,
    Date Date,
    
    SenderID varchar(50) NOT NULL,
    RecieverID varchar(50) NOT NULL,
    CONSTRAINT fk_Message_Sender_ID FOREIGN KEY (SenderID) REFERENCES User(Username),
    CONSTRAINT fk_Message_Reciever_ID FOREIGN KEY (RecieverID) REFERENCES User(Username)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Notification(
	NotificationID int PRIMARY KEY AUTO_INCREMENT,
    Type varchar(50) NOT NULL,
    Content varchar(100) NOT NULL,
    Date date,
    
    Username varchar(50) NOT NULL,
    CONSTRAINT fk_Notification_Username FOREIGN KEY (Username) REFERENCES User(Username)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Category(
	Name varchar(50) PRIMARY KEY NOT NULL,
    Desctription varchar(200) NOT NULL
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS SelectedCategory(
	SelectedCategoryID int PRIMARY KEY AUTO_INCREMENT,
    
    CategoryName varchar(50) NOT NULL,
    Username varchar(50) NOT NULL,
    CONSTRAINT fk_SelectedCategory_CategoryName  FOREIGN KEY (CategoryName) REFERENCES Category(Name) ,
    CONSTRAINT fk_SelectedCategory_Username  FOREIGN KEY (Username) REFERENCES User(Username)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Subject(
	SubjectID int PRIMARY KEY AUTO_INCREMENT , 
    Title varchar (50) NOT NULL,
    Content varchar(500) NOT NULL,
    Date Date,
    
    CategoryName varchar(50) NOT NULL,
    Username varchar (50) NOT NULL,
    CONSTRAINT fk_Subject_CategoryName FOREIGN KEY (CategoryName) REFERENCES Category(Name),
	CONSTRAINT fk_Subject_Username FOREIGN KEY (Username) REFERENCES User(Username)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS SubjectEvaluation(
	SubjectEvaluationID int PRIMARY KEY AUTO_INCREMENT,
    Vote varchar(3) NOT NULL CHECK(Vote='Yes' OR 'No'), 
    
    SubjectID int NOT NULL,
    Username varchar(50) NOT NULL,
    CONSTRAINT fk_SubjectEvaluation_SubjectID FOREIGN KEY (SubjectID) REFERENCES Subject(SubjectID),
    CONSTRAINT fk_SubjectEvaluation_Username FOREIGN KEY (Username) REFERENCES User(Username),
    UNIQUE KEY `SubjectIDUsername`(`SubjectID`,`Username`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS SubjectReply (
	SubjectReplyID int PRIMARY KEY AUTO_INCREMENT ,
    Content varchar (500) NOT NULL,
    Date date,
    
    SubjectID int NOT NULL,
    CONSTRAINT fk_SubjectReply_SubjectID FOREIGN KEY (SubjectID) REFERENCES Subject(SubjectID)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS SubjectReplyEvaluation(
	SubjectReplyEvaluationID int PRIMARY KEY AUTO_INCREMENT,
    Vote varchar(3) NOT NULL CHECK(Vote='Yes' OR 'No'), 
    
    SubjectReplyID int NOT NULL,
    Username varchar(50) NOT NULL,
    CONSTRAINT fk_SubjectReplyEvaluation_SubjectReplyID FOREIGN KEY (SubjectReplyID) REFERENCES SubjectReply(SubjectReplyID),
    CONSTRAINT fk_SubjectReplyEvaluation_Username FOREIGN KEY (Username) REFERENCES User(Username),
	UNIQUE KEY `SubjectReplyIDUsername`(`SubjectReplyID`,`Username`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Question (
	QuestionID int PRIMARY KEY AUTO_INCREMENT , 
    Title varchar (50) NOT NULL,
    Content varchar(500) NOT NULL,
    Date Date,
    
    CategoryName varchar(50) NOT NULL,
    Username varchar (50) NOT NULL,
	CONSTRAINT fk_Question_CategoryName FOREIGN KEY (CategoryName) REFERENCES Category(Name),
    CONSTRAINT fk_Question_Username FOREIGN KEY (Username) REFERENCES User(Username)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS QuestionEvaluation(
	QuestionEvaluationID int PRIMARY KEY AUTO_INCREMENT,
    Vote varchar(3) NOT NULL CHECK(Vote='Yes' OR 'No'), 
    
    QuestionID int NOT NULL,
    Username varchar(50) NOT NULL,
    CONSTRAINT fk_QuestionEvaluation_QuestionID FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID),
    CONSTRAINT fk_QuestionEvaluation_Username FOREIGN KEY (Username) REFERENCES User(Username),
    UNIQUE KEY `QuestionIDUsername`(`QuestionID`,`Username`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Answer (
	AnswerID int PRIMARY KEY AUTO_INCREMENT ,
    Content varchar (500) NOT NULL,
    Date date ,
    Best varchar(5) NOT NULL,
    
    QuestionID int NOT NULL, 
    Username varchar(50),
    CONSTRAINT fk_Answer_QuestionID FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID),
    CONSTRAINT fk_Answer_Username FOREIGN KEY (Username) REFERENCES User(Username)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS AnswerEvaluation(
	AnswerEvaluationID int PRIMARY KEY AUTO_INCREMENT,
    Vote varchar(3) NOT NULL CHECK(Vote='Yes' OR 'No'), 
    
    AnswerID int NOT NULL,
    Username varchar(50) NOT NULL,
    CONSTRAINT fk_AnswerEvaluation_AnswerID FOREIGN KEY (AnswerID) REFERENCES Answer(AnswerID),
    CONSTRAINT fk_AnswerEvaluation_Username FOREIGN KEY (Username) REFERENCES User(Username),
    UNIQUE KEY `AnswerIDUsername`(`AnswerID`,`Username`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Resource (
	ResourceID int PRIMARY KEY AUTO_INCREMENT , 
    Title varchar (50) NOT NULL,
    Content varchar(500) NOT NULL,
    Date Date,
    
    CategoryName varchar(50) NOT NULL,
    Username varchar (50) NOT NULL,
    CONSTRAINT fk_Resource_CategoryName FOREIGN KEY (CategoryName) REFERENCES Category(Name),
    CONSTRAINT fk_Resource_Username FOREIGN KEY (Username) REFERENCES User(Username)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS ResourceEvaluation(
	ResourceEvaluationID int PRIMARY KEY AUTO_INCREMENT,
    Vote varchar(3) NOT NULL CHECK(Vote='Yes' OR 'No'), 
    
    ResourceID int NOT NULL,
    Username varchar(50) NOT NULL,
    CONSTRAINT fk_ResourceEvaluation_ResourceID FOREIGN KEY (ResourceID) REFERENCES Resource(ResourceID),
    CONSTRAINT fk_ResourceEvaluation_Username FOREIGN KEY (Username) REFERENCES User(Username),
    UNIQUE KEY `ResourceIDUsername`(`ResourceID`,`Username`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS ResourceReply (
	ResourceReplyID int PRIMARY KEY AUTO_INCREMENT ,
    Content varchar (500) NOT NULL,
    Date date ,
    
    ResourceID int NOT NULL,
    CONSTRAINT fk_ResourceReply_ResourceID FOREIGN KEY (ResourceID) REFERENCES Resource(ResourceID)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS ResourceReplyEvaluation(
	ResourceReplyEvaluationID int PRIMARY KEY AUTO_INCREMENT,
    Vote varchar(3)  NOT NULL CHECK(Vote='Yes' OR 'No'), 
    
    ResourceReplyID int  NOT NULL,
    Username varchar(50)  NOT NULL,
    CONSTRAINT fk_ResourceReplyEvaluation_ResourceReplyID FOREIGN KEY (ResourceReplyID) REFERENCES ResourceReply(ResourceReplyID),
    CONSTRAINT fk_ResourceReplyEvaluation_Username FOREIGN KEY (Username) REFERENCES User(Username),
    UNIQUE KEY `ResourceReplyIDUsername`(`ResourceReplyID`,`Username`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


USE kolegu ;
INSERT INTO User VALUES('admini', SHA2('12345',512),'bllablla','foto','begginer','admin','0');
SELECT * FROM USER ;
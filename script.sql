USE [master]
GO
/****** Object:  Database [Vote]    Script Date: 1/6/2021 9:00:30 PM ******/
CREATE DATABASE [Vote]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Vote', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Vote.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Vote_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Vote_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Vote] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Vote].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Vote] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Vote] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Vote] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Vote] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Vote] SET ARITHABORT OFF 
GO
ALTER DATABASE [Vote] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Vote] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Vote] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Vote] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Vote] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Vote] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Vote] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Vote] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Vote] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Vote] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Vote] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Vote] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Vote] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Vote] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Vote] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Vote] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Vote] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Vote] SET RECOVERY FULL 
GO
ALTER DATABASE [Vote] SET  MULTI_USER 
GO
ALTER DATABASE [Vote] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Vote] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Vote] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Vote] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Vote] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Vote', N'ON'
GO
USE [Vote]
GO
/****** Object:  Table [dbo].[Evaluate]    Script Date: 1/6/2021 9:00:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Evaluate](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Descriptions] [nvarchar](500) NULL,
	[Rate] [int] NULL,
	[TopicId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoleN]    Script Date: 1/6/2021 9:00:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleN](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Selection]    Script Date: 1/6/2021 9:00:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Selection](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[TopicId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tag]    Script Date: 1/6/2021 9:00:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tag](
	[Id] [nchar](4) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK__Tag__3214EC076DB6F7EF] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Topics]    Script Date: 1/6/2021 9:00:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topics](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[TagId] [nchar](4) NULL,
	[Descriptions] [nvarchar](1000) NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Photo] [nvarchar](100) NULL,
	[IsMany] [bit] NOT NULL,
	[IsCreate] [bit] NOT NULL,
	[Exp] [date] NULL,
 CONSTRAINT [PK__Topics__3214EC072AA37100] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 1/6/2021 9:00:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[Password] [nvarchar](100) NOT NULL,
	[Fullname] [nvarchar](100) NOT NULL,
	[Gender] [bit] NOT NULL,
	[Birthday] [date] NULL,
	[Photo] [nvarchar](500) NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Phone] [char](20) NULL,
	[Ban] [bit] NULL,
 CONSTRAINT [PK__Users__A9D10535C9B96188] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UsersRole]    Script Date: 1/6/2021 9:00:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersRole](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[IdRole] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vote]    Script Date: 1/6/2021 9:00:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vote](
	[IdVote] [bigint] IDENTITY(1,1) NOT NULL,
	[Id] [bigint] NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Evaluate] ON 

INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (1, N'dtphat.c3ntrai@gmail.com', N'Câu hỏi hay <3', 5, 1)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (2, N'dtphat.c3ntrai@gmail.com', N'Chắc chắn Among Us là game hay nhất rồi', 5, 2)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (3, N'nhoxharryever1@gmail.com', N'Cyberbug 2077', 5, 2)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (6, N'nhoxharryever1@gmail.com', N'Vấn đề thú vị', 5, 5)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (7, N'abc@gmail.com', N'Không cần lửa chùa', 5, 2)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (9, N'dtphat.c3ntrai@gmail.com', N'Pain', 4, 4)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (11, N'Abc@gmail.com', N'Rap ziệt', 5, 5)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (13, N'Abc@gmail.com', N'Chắc chắn không phải thằng cùng phòng r', 5, 1)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (14, N'nhoxharryever1@gmail.com', N':)) ok vậy thì khỏi đi', 5, 13)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (15, N'abc@gmail.com', N'Siêng lên các bạn', 5, 13)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (16, N'nhoxharryever1@gmail.com', N'exelent', 5, 1)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (17, N'dtphat.c3ntrai@gmail.com', N'From MixiGaming with love <3', 5, 8)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (19, N'nhoxharryever1@gmail.com', N'ga', 4, 4)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (22, N'nhoxharryever1@gmail.com', N'ok', 5, 7)
INSERT [dbo].[Evaluate] ([Id], [Email], [Descriptions], [Rate], [TopicId]) VALUES (26, N'admin@admin', N'bổ ích', 5, 20)
SET IDENTITY_INSERT [dbo].[Evaluate] OFF
SET IDENTITY_INSERT [dbo].[RoleN] ON 

INSERT [dbo].[RoleN] ([Id], [Name]) VALUES (1, N'ROLE_ADMIN')
INSERT [dbo].[RoleN] ([Id], [Name]) VALUES (2, N'ROLE_USER')
SET IDENTITY_INSERT [dbo].[RoleN] OFF
SET IDENTITY_INSERT [dbo].[Selection] ON 

INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (1, N'Tôi', 1)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (2, N'Bạn', 1)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (3, N'Học sinh lớp 6', 1)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (4, N'Người thông minh hơn học sinh thông minh nhất lớp 5', 1)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (5, N'Among Us', 2)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (6, N'The Last Of Us 2', 2)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (7, N'Cyberpunk 2077', 2)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (8, N'Genshin Impact', 2)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (13, N'Covid 19', 4)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (14, N'Mưa sao băng', 4)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (15, N'Nhật thực', 4)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (16, N'Siêu trí tuệ', 5)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (17, N'Rap Việt', 5)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (18, N'Liên Minh Huyền Thoại', 2)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (19, N'Động Phong Nha - Kẽ Bàng', 6)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (20, N'Dinh Độc Lập', 6)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (21, N'Đà Lạt', 6)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (22, N'Biển Nha Trang', 6)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (23, N'MoMo', 7)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (24, N'VNPay', 7)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (25, N'ZaloPay', 7)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (26, N'ViettelPay', 7)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (28, N'Chạy đi chờ chi', 5)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (39, N'Độ Mixi', 8)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (40, N'Misthy', 8)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (41, N'Thầy Giáo Ba', 8)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (42, N'Trâu', 8)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (49, N'Java', 12)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (50, N'JavaScript', 12)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (51, N'Python', 12)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (52, N'C/C++', 12)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (53, N'C#', 12)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (54, N'Pascal', 12)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (55, N'Ruby', 12)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (56, N'Có', 13)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (57, N'Không', 13)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (58, N'Nên', 14)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (59, N'Không', 14)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (63, N'Không ai', 1)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (71, N'BN17', 4)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (75, N'Sơn Tùng MTP', 20)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (76, N'Sofm', 20)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (77, N'JACK', 20)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (78, N'Đen Vâu', 20)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (79, N'Thủy Tiên', 20)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (80, N'Nhóm Việt Sử Kiêu Hùng', 20)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (82, N'Bạn', 2)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (92, N'Alo', 38)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (94, N'được', 4)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (95, N'được', 39)
INSERT [dbo].[Selection] ([Id], [Name], [TopicId]) VALUES (96, N'Bạn', 39)
SET IDENTITY_INSERT [dbo].[Selection] OFF
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'AN  ', N'Âm Nhạc')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'DL  ', N'Du Lịch')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'GAME', N'Game')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'GS  ', N'Gameshow')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'KHAC', N'Khác')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'MT  ', N'Mỹ Thuật')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'NGNT', N'Người Nổi Tiếng')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'QT  ', N'Câu Đố')
SET IDENTITY_INSERT [dbo].[Topics] ON 

INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (1, N'Ai thông minh hơn học sinh lớp 5', N'GS  ', N'Ai là người thông minh hơn học sinh lớp 5', N'dtphat.c3ntrai@gmail.com', N'files/cach-dang-ky-tham-gia-chuong-trinh-ai-thong-minh-hon-hoc-sinh-lop-5-hang-nam-100525.jpg', 1, 0, CAST(N'2021-01-14' AS Date))
INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (2, N'Game hay nhất 2020', N'GAME', N'Game hay nhất được đánh giá trong năm 2020 là game nào ?', N'dtphat.c3ntrai@gmail.com', N'files/The-Game-Awards-2020-2.jpg', 0, 1, CAST(N'2020-12-31' AS Date))
INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (4, N'Sự kiện đáng nhớ nhất năm 2020', N'KHAC', N'Sự kiện cả tôt lẫn xấu đáng nhớ nhất năm 2020 đối với bạn là gì?', N'nhoxharryever1@gmail.com', N'files/event.jpg', 0, 1, CAST(N'2021-01-08' AS Date))
INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (5, N'Gameshow hay nhất 2020', N'GS  ', N'Rất nhiều gameshow hay được tổ chức trong năm 2020. Nhưng chương trình nào hay và ý nghĩa nhất ?', N'nhoxharryever1@gmail.com', N'files/tv-game-show.jpg', 0, 1, NULL)
INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (6, N'Địa danh đáng để du lịch nhất', N'DL  ', N'Đâu là nơi tốt nhất để ghé thăm. Xét trên tất cả phương diện', N'abc@gmail.com', N'files/blogcover-1.jpg', 0, 1, NULL)
INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (7, N'Ví điện tử xài ổn nhất hiện tại', N'KHAC', N'Chuyển đổi số làm xuất hiện nhiều loại ví điện tử, trong số đó loại ví điện tử nào xài ổn nhất hiện tại ?', N'abc2@gmail.com', N'files/images.png', 1, 1, NULL)
INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (8, N'Top 3 streamer nổi nhất Việt Nam', N'KHAC', N'Top những Streamer nổi tiếng nhất ở Việt Nam năm 2020', N'abc@gmail.com', N'files/streamer.jpg', 1, 1, NULL)
INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (12, N'Ngôn ngữ lập trình thịnh hành nhất 2020', N'KHAC', N'Bạn đã sử dụng những ngôn ngữ lập trình nào trong năm 2020', N'abc@gmail.com', N'files/8-ngon-ngu-lap-trinh-phan-mem.png', 1, 1, NULL)
INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (13, N'Có nên đi học không ?', N'QT  ', N'Mai có nên đi học không? ', N'dtphat.c3ntrai@gmail.com', N'files/pngtree-a-lazy-bed-student-png-image_3468424.jpg', 0, 0, CAST(N'2021-01-09' AS Date))
INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (14, N'Nên đeo khẩu trang không?', N'DL  ', N'Nên đeo khẩu trang khi ra ngoài không?', N'abc5@gmail.com', N'files/Corona-iqnvkd0011.jpg', 0, 0, NULL)
INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (20, N'Nhân vật truyền cảm hứng của năm 2020', N'NGNT', N'Nhân vật truyền cảm hứng của năm 2020 là ai ?', N'nhoxharryever1@gmail.com', N'files/wechoice.png', 1, 1, CAST(N'2021-12-15' AS Date))
INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (38, N'abcd', N'GAME', N'Alo', N'admin@admin', NULL, 1, 1, NULL)
INSERT [dbo].[Topics] ([Id], [Name], [TagId], [Descriptions], [Email], [Photo], [IsMany], [IsCreate], [Exp]) VALUES (39, N'hi hi ha ha', N'GAME', N'', N'nhoxharryever1@gmail.com', NULL, 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[Topics] OFF
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$F8izfHA6quLoO/CWC4/fXuaxp4jAcZu.u4eTx9MsdFcXarJTJA1mO', N'Nguyễn Văn Sửa', 1, NULL, N'files/ava/favi.png', N'abc@gmail.com', N'                    ', 0)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$F8izfHA6quLoO/CWC4/fXuaxp4jAcZu.u4eTx9MsdFcXarJTJA1mO', N'Nguyễn Văn C', 1, NULL, N'https://lh5.googleusercontent.com/-R3rhibATI1s/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmtOCTFOv9Xw1h4PRxIZN81Rpxogw/s96-c/photo.jpg', N'abc2@gmail.com', N'                    ', 1)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$F8izfHA6quLoO/CWC4/fXuaxp4jAcZu.u4eTx9MsdFcXarJTJA1mO', N'Nguyễn Văn E', 1, NULL, N'files/ava/2unnamed.png', N'abc21@gmail.com', N'                    ', 0)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$F8izfHA6quLoO/CWC4/fXuaxp4jAcZu.u4eTx9MsdFcXarJTJA1mO', N'Nguyễn Văn D', 1, NULL, NULL, N'abc3@gmail.com', N'                    ', 0)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$F8izfHA6quLoO/CWC4/fXuaxp4jAcZu.u4eTx9MsdFcXarJTJA1mO', N'Nguyễn Văn F', 1, CAST(N'2020-12-15' AS Date), N'files/ava/images.png', N'abc4@gmail.com', N'0935351234          ', 0)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$04$GYGsaJj9l6kH2GikK6QVzO0v3sOCxt3vdkiA2/tcoSw8erI85ZYDG', N'Nguyễn Văn K', 1, NULL, N'files/ava/favicon1.png', N'abc5@gmail.com', N'                    ', 0)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$It3U/6VAcgp7lcAsFpYf2ekyC3uE5yag7TZENRElbqookeW6s/QTW', N'Dương Tấn Phát2', 1, NULL, NULL, N'abcd@gmail.com', N'                    ', 0)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$9ytKqLKwZVnbsAhT8Ew43uwGXYV7IIV5/s0j/BHz2fvqaJkpRnQZ.', N'Admin', 0, NULL, N'files/ava/1unnamed.png', N'admin@admin', N'                    ', 0)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$kEazHwHPEy0xfguRu18guua8kGjYToNSjzXh6wQ4FsOB54CnluHn2', N'Dương Tấn Phát', 1, CAST(N'1999-12-15' AS Date), N'files/ava/ORANGE.png', N'dtphat.c3ntrai@gmail.com', N'0935351234          ', 1)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$RYDV27H1o9wpbx/OCes3VOmm.YLXQ5Xwx9aJRxaCqMFv8fDmdcfA.', N'Dương Tấn Phát234', 1, NULL, NULL, N'dtphat.c3ntrai345@gmail.com', N'                    ', 0)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$F8izfHA6quLoO/CWC4/fXuaxp4jAcZu.u4eTx9MsdFcXarJTJA1mO', N'Nguyễn Văn Ha', 1, CAST(N'1999-02-09' AS Date), N'files/ava/unnamed.png', N'nhoxharryever1@gmail.com', N'0123456789          ', 0)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$RYDV27H1o9wpbx/OCes3VOmm.YLXQ5Xwx9aJRxaCqMFv8fDmdcfA.', N'Dương Tấn Phát2', 1, NULL, NULL, N'nhoxharryever12@gmail.com', N'                    ', 0)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$zbjwlXrfnJpM4CFwp8iSte.icFWBGn4mhXeUuLj7K3WrNBGAxcyPe', N'Dương Tấn Phát245', 1, NULL, N'files/ava/1Corona-iqnvkd0011.jpg', N'nhoxharryever14@gmail.com', N'                    ', 0)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$07/kzrcS7HqWygqYSvsQee8zIRF//p0XybPGz40xbXJ676m8q7S8u', N'Nguyễn Văn E 5', 1, NULL, NULL, N'nhoxharryever5@gmail.com', N'                    ', 0)
INSERT [dbo].[Users] ([Password], [Fullname], [Gender], [Birthday], [Photo], [Email], [Phone], [Ban]) VALUES (N'$2a$10$cGCGiOGacTKoP86ll00bveigIauUULl6RXy8QTYa2.eHm1Po1lfMy', N'Dương Tấn Phát6', 1, NULL, NULL, N'nhoxharryever6@gmail.com', N'                    ', 0)
SET IDENTITY_INSERT [dbo].[UsersRole] ON 

INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (1, N'abc5@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (2, N'admin@admin', 1)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (3, N'admin@admin', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (4, N'nhoxharryever6@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (5, N'abc@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (6, N'abc2@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (7, N'abc21@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (8, N'abc3@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (9, N'abc4@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (10, N'dtphat.c3ntrai@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (11, N'dtphat.c3ntrai345@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (12, N'nhoxharryever1@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (13, N'nhoxharryever12@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (14, N'nhoxharryever14@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (15, N'nhoxharryever5@gmail.com', 2)
INSERT [dbo].[UsersRole] ([Id], [Email], [IdRole]) VALUES (17, N'abcd@gmail.com', 2)
SET IDENTITY_INSERT [dbo].[UsersRole] OFF
SET IDENTITY_INSERT [dbo].[Vote] ON 

INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (97, 5, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (102, 1, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (104, 3, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (105, 16, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (107, 4, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (111, 16, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (114, 1, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (116, 1, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (117, 2, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (118, 3, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (119, 4, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (120, 5, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (121, 20, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (122, 5, N'abc2@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (123, 1, N'abc2@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (124, 3, N'abc2@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (125, 22, N'abc2@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (126, 2, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (127, 4, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (128, 7, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (129, 23, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (133, 17, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (135, 3, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (136, 39, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (137, 41, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (143, 1, N'admin@admin')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (146, 50, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (147, 51, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (148, 19, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (149, 5, N'admin@admin')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (150, 3, N'admin@admin')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (151, 42, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (152, 40, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (154, 57, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (155, 57, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (156, 57, N'admin@admin')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (157, 56, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (158, 55, N'abc@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (159, 57, N'abc5@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (160, 58, N'abc5@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (161, 39, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (162, 41, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (163, 58, N'admin@admin')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (164, 49, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (165, 50, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (166, 51, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (167, 1, N'abc3@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (168, 3, N'abc3@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (169, 4, N'abc3@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (171, 39, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (172, 13, N'dtphat.c3ntrai@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (173, 49, N'admin@admin')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (174, 39, N'admin@admin')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (181, 15, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (185, 23, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (186, 49, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (191, 75, N'admin@admin')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (192, 80, N'admin@admin')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (194, 19, N'admin@admin')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (195, 51, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (196, 75, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (197, 63, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (198, 92, N'admin@admin')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (199, 92, N'nhoxharryever1@gmail.com')
INSERT [dbo].[Vote] ([IdVote], [Id], [Email]) VALUES (200, 96, N'nhoxharryever1@gmail.com')
SET IDENTITY_INSERT [dbo].[Vote] OFF
ALTER TABLE [dbo].[Evaluate]  WITH CHECK ADD  CONSTRAINT [FK__Evaluate__EmailU__1ED998B2] FOREIGN KEY([Email])
REFERENCES [dbo].[Users] ([Email])
GO
ALTER TABLE [dbo].[Evaluate] CHECK CONSTRAINT [FK__Evaluate__EmailU__1ED998B2]
GO
ALTER TABLE [dbo].[Evaluate]  WITH CHECK ADD  CONSTRAINT [FK__Evaluate__TopicI__1FCDBCEB] FOREIGN KEY([TopicId])
REFERENCES [dbo].[Topics] ([Id])
GO
ALTER TABLE [dbo].[Evaluate] CHECK CONSTRAINT [FK__Evaluate__TopicI__1FCDBCEB]
GO
ALTER TABLE [dbo].[Selection]  WITH CHECK ADD  CONSTRAINT [FK__Selection__Topic__182C9B23] FOREIGN KEY([TopicId])
REFERENCES [dbo].[Topics] ([Id])
GO
ALTER TABLE [dbo].[Selection] CHECK CONSTRAINT [FK__Selection__Topic__182C9B23]
GO
ALTER TABLE [dbo].[Topics]  WITH CHECK ADD  CONSTRAINT [FK__Topics__EmailUse__15502E78] FOREIGN KEY([Email])
REFERENCES [dbo].[Users] ([Email])
GO
ALTER TABLE [dbo].[Topics] CHECK CONSTRAINT [FK__Topics__EmailUse__15502E78]
GO
ALTER TABLE [dbo].[Topics]  WITH CHECK ADD  CONSTRAINT [FK__Topics__TagId__145C0A3F] FOREIGN KEY([TagId])
REFERENCES [dbo].[Tag] ([Id])
GO
ALTER TABLE [dbo].[Topics] CHECK CONSTRAINT [FK__Topics__TagId__145C0A3F]
GO
ALTER TABLE [dbo].[UsersRole]  WITH CHECK ADD FOREIGN KEY([Email])
REFERENCES [dbo].[Users] ([Email])
GO
ALTER TABLE [dbo].[UsersRole]  WITH CHECK ADD FOREIGN KEY([IdRole])
REFERENCES [dbo].[RoleN] ([Id])
GO
ALTER TABLE [dbo].[Vote]  WITH CHECK ADD  CONSTRAINT [FK__Vote__EmailUser__1BFD2C07] FOREIGN KEY([Email])
REFERENCES [dbo].[Users] ([Email])
GO
ALTER TABLE [dbo].[Vote] CHECK CONSTRAINT [FK__Vote__EmailUser__1BFD2C07]
GO
ALTER TABLE [dbo].[Vote]  WITH CHECK ADD FOREIGN KEY([Id])
REFERENCES [dbo].[Selection] ([Id])
GO
USE [master]
GO
ALTER DATABASE [Vote] SET  READ_WRITE 
GO

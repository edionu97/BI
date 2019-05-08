go
create function getDateInfo(@d date) returns @result table (
	DateNum float,
	[Date] date,
	[DayName] nvarchar(255),
	[MonthName] nvarchar(255),
	[Year] nvarchar(255),
	[DayNumber] nvarchar(255),
	[MonthNumber] nvarchar(255),
	[WeekNumber] int,
	[QuarterNumber] int,
	[QuarterName] nvarchar(255)
) as begin

	declare @dayPart varchar(3) = CAST(DATEPART(d, @d) AS VARCHAR); --dNr
	declare @monthPart varchar(3) = CAST(DATEPART(m, @d) AS VARCHAR); --mNr
	declare @yearPart varchar(5) = CAST(DATEPART(yy, @d) AS VARCHAR); --yNr
	declare @weekPart varchar(3) = CAST(DATEPART(wk, @d) AS int); --wNr
	declare @quarterYear varchar(5) = CAST(DATEPART(qq, @d) AS int); --qNr
	declare @quarterYearName varchar(7) = CONCAT('Qtr ', @quarterYear);

	if cast(@dayPart as int ) < 10 begin
		set @dayPart = concat('0', @dayPart)
	end 

	if cast(@monthPart as int ) < 10 begin
		set @monthPart = concat('0', @monthPart)
	end 

	declare @dateId int = cast(concat(@yearPart, concat(@dayPart, @monthPart)) as float); --DateNum

	declare @dayWeekName varchar(155) =  --dName
	  DATENAME(
		  dw, @monthPart  + '/' + @dayPart+ '/' + @yearPart
	);

	declare @monthName varchar(155) = --mName
	  DATENAME(
		  m, @monthPart  + '/' + @dayPart+ '/' + @yearPart
	);

	insert into @result values(
		@dateId, @d, @dayWeekName, @monthName, @yearPart, @dayPart, @monthPart, @weekPart, @quarterYear, @quarterYearName
	 )

	return
end

go





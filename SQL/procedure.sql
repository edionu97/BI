
go
create function createDimTable () returns @result table (
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
	
	declare @start date = '01/01/1950';
	declare @end date = '12/31/2039';

	while @start != @end begin
		insert into @result select * from dbo.getDateInfo(getDate());
		set @start = dateadd(day, 1, @start);
	end

	return;
end

go
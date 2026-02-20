--Write a query to provide the for nth occurance of sunday in future from given date
--datepart
--sunday-1
--monday-2
--friday-6
--saturday-7

declare @today_date date;
declare @n int;
set @today_date = '2022-01-03'; -- saturday
set @n = 3;

select dateadd(week,@n-1,dateadd(day,8-DATEPART(WEEKDAY,@today_date),@today_date))
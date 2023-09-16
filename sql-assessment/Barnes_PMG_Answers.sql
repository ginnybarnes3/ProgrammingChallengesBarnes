# Ginny Barnes SQL Query Answers
#Write a query to get the sum of impressions by day.
select date, sum(impressions) from marketing_data group by date;

#Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?
select state, sum(revenue) from website_revenue group by state order by sum(revenue) desc limit 3;
select sum(revenue) from website_revenue group by state order by sum(revenue) desc limit 1 offset 2;

#Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.
create table webRevTots as select campaign_id, sum(revenue) as RevenueTotals from website_revenue group by campaign_id;
create table markets as select campaign_id, sum(cost) costTot, sum(impressions) impressionsTot, sum(clicks) clicksTot from marketing_data  group by campaign_id;
create table final_Totals as select  markets.campaign_id, markets.costTot, markets.impressionsTot, markets.clicksTot, webRevTots.RevenueTotals from markets inner join webRevTots where markets.campaign_id = webRevTots.campaign_id;
select * from final_Totals;

#Write a query to get the number of conversions of Campaign 5 by state. Which state generated the most conversions for this campaign?
select campaign_id, geo, sum(conversions) from marketing_data where campaign_id = 55304737 group by geo;
select geo from marketing_data where campaign_id = 55304737 group by geo order by sum(conversions) desc limit 1;


# In your opinion, which campaign was the most efficient, and why?
create table marketing_Efficiency select campaign_id, RevenueTotals/costTot as MER from final_Totals;
select * from marketing_Efficiency

# Campaign 99058240 had the highest marketing efficiency ratio (Revenue/Costs) and therefore was most efficient.



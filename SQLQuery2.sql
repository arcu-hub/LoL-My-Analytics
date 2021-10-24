--champion winrates and games played ordered by weighted total winrate

select c11.champion, c11.Winrate as 'S11 Winrate',c10.Winrate as 'S10 Winrate', c11.wins + c11.Losses as 'S11 Games Picked',c10.wins + c10.Losses as 'S10 Games Picked'
from PortfolioProject..ChampionS11$ as c11 JOIN PortfolioProject..ChampionS10$ as c10 On c10.Champion=c11.Champion 
where c11.Wins+c11.Losses>70 and c10.Wins+c10.Losses>50
order by (c11.Winrate*(c11.wins + c11.Losses)/(c11.wins + c11.Losses+c10.wins + c10.Losses) + c10.Winrate*(c10.wins + c10.Losses)/(c11.wins + c11.Losses+c10.wins + c10.Losses))asc


--DPM weighted

select c11.champion, c11.DPM, c10.DPM
from PortfolioProject..ChampionS11$ as c11 JOIN PortfolioProject..ChampionS10$ as c10 On c10.Champion=c11.Champion 
where c11.Wins+c11.Losses>50 and c10.Wins+c10.Losses>50
order by c11.DPM*(c11.wins + c11.Losses)/(c11.wins + c11.Losses+c10.wins + c10.Losses)+c10.DPM*(c10.wins + c10.Losses)/(c11.wins + c11.Losses+c10.wins + c10.Losses) DESC

-- best early game champions
select c11.champion, c11.GD@15,c10.GD@15
from PortfolioProject..ChampionS11$ as c11 JOIN PortfolioProject..ChampionS10$ as c10 On c10.Champion=c11.Champion 
where c11.Wins+c11.Losses>70 and c10.Wins+c10.Losses>50
order by c11.gD@15*(c11.wins + c11.Losses)/(c11.wins + c11.Losses+c10.wins + c10.Losses)+c10.gD@15*(c10.wins + c10.Losses)/(c11.wins + c11.Losses+c10.wins + c10.Losses) asc

--season 11 views on metrics on different positions
select Position, round(avg(KDA),1) AS KDA, round(avg([Avg kills]),1)AS Kills,round(avg([Avg deaths]),1)AS Deaths,round(avg([CSM]),1)AS CSM
,round(avg([GPM]),0)AS GPM,round(avg([DPM]),0)AS DPM,round(avg([KP%]),2)AS 'KP%',round(avg([DMG%]),1)AS 'DMG%'
from PortfolioProject..PlayersS11$
group by Position
order by CASE WHEN Position = 'TOP' THEN '1'
              WHEN Position  = 'JUNGLE' THEN '2'
              WHEN Position  = 'MID' THEN '3'
			  WHEN Position  = 'ADC' THEN '4'
			  WHEN Position  = 'SUPPORT' THEN '5' END ASC


--season 11 views on metrics on different regions

select Region,round(avg([GPM]),1) AS GPM,round(avg([DPM]),1) AS DPM,round(avg([Towers killed]),1) AS 'Towers killed'
from PortfolioProject..TeamsS11$
where region in ('KR', 'CN','EUW','NA')
group by Region
order by CASE WHEN Region = 'CN' THEN '1'
              WHEN Region  = 'KR' THEN '2'
              WHEN Region  = 'EUW' THEN '3'
		      WHEN Region = 'NA' THEN '4'
			  ELSE '5'END ASC


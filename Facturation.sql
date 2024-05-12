create database "Facturation.mdf"
USE Facturation
--************************************************************************************************************************************************************************************************************************************************
create table agence (numag char (15) primary key not null,nomag char (20) not null,adresseag char (20) not null,telag char (15) not null)
create table produit (ref char (15) primary key not null,desg char (15) not null,pu float not null)
create table client (numclt char (15) primary key not null,nomclt char (15)not null,prenomclt char (15) not null,adresseclt char (20) not null,telclt char (15) not null)
create table facture (numfact char (15) primary key not null,datefact datetime,tht float,tva float,ttc float,numclt char (15), foreign key(numclt) references client(numclt),numag char (15), foreign key(numag) references  agence(numag))
create table facturer (numfact char (15) foreign key references facture not null,ref char (15) foreign key references produit not null,qt int not null,montant float not null primary key (numfact,ref))
--*************************************************************************************************************************************************************************************************************************************************
insert into  client values('CLT001','Hicham','RADI','Rabat','05375895814')
insert into  client values('CLT002','Mohamed','ALAMI','Casa','05224113260')
insert into  client values('CLT003','Yassine','ALAOUI','Kénitra','05370254311')
insert into  client values('CLT005','Hamid','ARABI','Oujda','05443187766')
insert into  client values('CLT006','Younes','MADANI','Tanger','05390079401')
insert into  client values('CLT007','Younes','MADANI','Tanger','05390079401')
insert into  client values('CLT008','Amine','SEBTI','Kénitra','05373542185')
insert into  client values('CLT009','Hicham','RADI','Rabat','05375895814')
select *from client
--**************************************************************************************************
insert into  produit values('PRD111','Clavier',100)
insert into  produit values('PRD112','Haut_parleur',250)
insert into  produit values('PRD113','Lecteur DVD',600)
insert into  produit values('PRD114','Souris',25)
insert into  produit values('PRD115','Ecran LCD',720)
insert into  produit values('PRD116','Scanner',830)
select *from produit
--***************************************************************************************************
insert into  agence values('AG00001','Service Parck','Témara','0537986542')
insert into  agence values('AG00002','Info Sales','Salé','0537112355')
insert into  agence values('AG00003','Maintenance Info','Ksar','0539773640')
insert into  agence values('AG00004','Agence MedV','Tanger','0539332101')
insert into  agence values('AG00005','Agence Zerktouni','Casa','0539332101')
insert into  agence values('AG00008','Agence Zerktouni','Oujda','0539332101')
insert into  agence values('AG00007','Agence Zerktouni','Casa','0539332101')
select *from agence
select * from facture
--***************************************************************************************************
insert into  facture values('FACT001/12','12/06/2012',995,199,1194,'CLT001','AG00001')
insert into  facture values('FACT002/10','02/08/2010',830,166,996,'CLT001','AG00002')
insert into  facture values('FACT013/09','17/01/2009',5150,1030,6180,'CLT002','AG00001')
insert into  facture values('FACT034/11','28/12/2011',3000,600,3600,'CLT003','AG00002')
insert into  facture values('FACT045/13','30/01/2013',7150,1430,8580,'CLT003','AG00002')
insert into  facture values('FACT076/10','19/11/2010',1200,240,1440,'CLT005','AG00003')
insert into  facture values('FACT097/03','12/06/2003',1420,284,1704,'CLT006','AG00004')
insert into  facture values('FACT028/12','12/06/2012',2000,400,2400,'CLT006','AG00004')
insert into  facture values('FACT059/13','04/02/2013',150,30,180,'CLT006','AG00004')
insert into  facture values('FACT021/13','04/04/2013',1000,200,1200,'CLT008','AG00002')
select *from facture
drop table  produit
--***************************************************************************************************
insert into  facturer values('FACT001/12','PRD111',2,200)
insert into  facturer values('FACT001/12','PRD114',3,75)
insert into  facturer values('FACT001/12','PRD115',1,720)
insert into  facturer values('FACT002/10','PRD116',1,830)
insert into  facturer values('FACT013/09','PRD112',4,1000)
insert into  facturer values('FACT013/09','PRD116',5,4150)
insert into  facturer values('FACT034/11','PRD113',5,3000)
insert into  facturer values('FACT045/13','PRD116',5,4150)
insert into  facturer values('FACT045/13','PRD113',5,3000)
insert into  facturer values('FACT076/10','PRD111',12,1200)
insert into  facturer values('FACT097/03','PRD114',8,200)
insert into  facturer values('FACT097/03','PRD112',2,500)
insert into  facturer values('FACT097/03','PRD115',1,720)
insert into  facturer values('FACT028/12','PRD113',3,1800)
insert into  facturer values('FACT028/12','PRD111',2,200)
insert into  facturer values('FACT059/13','PRD114',6,150)
insert into  facturer values('FACT021/13','PRD114',40,1000)
--**********************************************************************************
--*************** 3: Afficher les clients qui n'ont éffectué aucun achat************
--**********************************************************************************

SELECT * FROM Client WHERE numclt not in(SELECT numclt FROM Facture)

--**********************************************************************************
--*************** 4: Afficher les clients qui ont au moin deux factures*************
--**********************************************************************************
 SELECT c.numclt,nomclt,adresseclt,telclt ,COUNT(numfact) as [nombre facture]
 FROM facture f,Client c
 WHERE c.numclt = f.numclt
 Group by c.numclt,nomclt,adresseclt,telclt
 having COUNT(numfact)>=2
 --**********************************************************************************
--*************** 5:afficher le client de Rabat est de kenitra***********************
--**********************************************************************************
SELECT * FROM client WHERE  adresseclt='Kénitra' OR adresseclt='Rabat'
SELECT * FROM client WHERE  adresseclt in('Kénitra','Rabat')
 --*********************************************************************************
--*************** 6:selectionner les clients qui ont la facture la plus elevée******
--**********************************************************************************
SELECT c.numclt,nomclt,adresseclt,telclt 
FROM facture f,client c
WHERE c.numclt=f.numclt and ttc>=(SELECT MAX(ttc)FROM facture)
GROUP BY c.numclt,nomclt,adresseclt,telclt 
--**************************************************************************************
--*************** 7:Afficher les clients et le Total des achats pour chaque client******
--**************************************************************************************
SELECT  c.numclt,nomclt,adresseclt,telclt,SUM(ttc) 
FROM facture f,client c
WHERE c.numclt=f.numclt
GROUP BY  c.numclt,nomclt,adresseclt,telclt 
SELECT*FROM facture
--***********************************************************************$*
--** 8:Afficher les client qui ont le total des achats le plus élevé ******
--*************************************************************************
SELECT  c.numclt,nomclt,adresseclt,telclt, sum(ttc) FROM facture f,client c
WHERE c.numclt = f.numclt
group by c.numclt,nomclt,adresseclt,telclt
HAVING sum(ttc) >= ALL (SELECT sum(ttc) from facture
						group by numclt);
--***********************************************************************
--** 9: Selection les agences qui ont effectuée au moins deux ventes ****
--***********************************************************************
	SELECT a.numag,nomag,adresseag,telag,count(f.numag)
	from agence a,facture f
	where a.numag=f.numag
	group by a.numag,nomag,adresseag,telag
	having count(f.numag)>=2
--***************************************************************************
--** 10: Selection les agences et le nombre de factures pour chaque ageence ******
--*****************************************************************************
SELECT a.numag,nomag,adresseag,telag,count(f.numag )
from agence a, facture f
where a.numag=f.numag
group by a.numag,nomag,adresseag,telag
--***************************************************************************
--** 11: afficher les agences et le nombre de clients de chaque agence ******
--*****************************************************************************
select a.numag,nomag,adresseag,telag,count(distinct f.numclt)as [Nombre des clients]
from agence a,facture f
where a.numag=f.numag 
group by a.numag,nomag,adresseag,telag 
select * from facture
select * from agence
/*****************************************************************************/
/*** 12: afficher les factures qui contient au moins trois produits */
/****************************************************************************/
SELECT f.numfact,datefact,tva,tht,ttc,numclt,numag,count(ref) 
FROM facture f,facturer fr
where f.numfact=fr.numfact
group by  f.numfact,datefact,tva,tht,ttc,numclt,numag
having count(ref)>=3
/*****************************************************************************/
/********************** Transact-SQL ****************************/
/****************************************************************************/
DECLARE @nbreclt int
SELECT @nbreclt= COUNT(*) FROM Client
PRINT'Nombre de clients est:'+ LTRIM(str(@nbreclt))
/*****************************************************************************/
--*****************Réaliser des instructions transact-sql permettant**********/
--*****************d'attribuser a une varible le totale de la facture*********/ 
--*****************le plus élevé et d'afficher son contenu *******************/
/*****************************************************************************/
declare @totalP float 
SELECT @TOTALp = max(ttc) from facture
print'Total de facteur le plus élevé est:'+ltrim(str(@TOTALp))
/*****************************************************************************/
--********************* Réaliser des instructions transact-sql permettant*****/
--**********************d'affichage le nombre de factures qui contiennent*****/
--**********************plus de deux produits:********************************/
/*****************************************************************************/
DECLARE @nombre_facture int
SELECT @nombre_facture=COUNT (numfact) FROM Facture
WHERE numfact In (SELECT numfact FROM Facturer
GROUP BY numfact
Having COUNT (ref)>2)
print'nombre de fature dans les produits >2:'+LTRIM (str(@nombre_facture))
/*****************************************************************************/
--********************* Réaliser des instructions transact-sql permettant*****/
--**********************d'affichage le nombre des agences qui ont éffectué****/
--**********************des ventes les plus élevées***************************/
/*****************************************************************************/
DECLARE @nombre_agence int
SELECT @nombre_agence=COUNT (numag) FROM Agence
WHERE numag IN(SELECT  numag  FROM facture
				group by numag
				HAVING sum(ttc) >= ALL (SELECT sum(ttc) from facture
										group by numag))
print'nombre d''agences éffectuant des ventes les plus élevées:'+LTRIM (str(@nombre_agence))
/************************************************************************************/
--********************* Réaliser des instructions transact-sql permettant************/
--**********************de supprimer un client bien precis s'il existe sinon ********/
--**********************afficher un message******************************************/
/************************************************************************************/
DECLARE @numclient varchar(15)
SET @numclient='CLT009'
IF EXISTS(SELECT numclt FROM client where numclt=@numclient )
BEGIN
	DELETE FROM client where numclt=@numclient
	
	print'le client est bien supprimer'
END

ELSE
print'le client n''existe pas'
/************************************************************************************/
--********************* Réaliser des instructions transact-sql permettant************/
--**********************de supprimer une agence bien precise si elle existe**********/
--**********************sinon afficher un message************************************/
/************************************************************************************/
DECLARE @numagence varchar(15)
SET @numagence='AG00008'
IF EXISTS(SELECT numag FROM Agence where numag=@numagence )
BEGIN
	IF (select count (numag) from Agence)>6 
	begin 
		DELETE FROM Agence where numag=@numagence
		print'L''agence est bien supprimée'
	END 
	ELSE
		print ' Le nombre d''agence est insuffisant' 
END
ELSE
	print'L''agence n''existe pas'
/************************************************************************************/
--********************* Réaliser des instructions transact-sql permettant************/
--**********************de supprimer une agence bien precise si elle existe**********/
--**********************sinon afficher un message************************************/
/************************************************************************************/
DECLARE @numagence varchar(15)
SET @numagence='AG00007'
IF EXISTS(SELECT numag FROM Agence where numag=@numagence )
	And(select count (numag) from Agence)>6 
BEGIN
		DELETE FROM Agence where numag=@numagence
		print'le l''agence est bien supprimée' 
END
ELSE
	print'L''agence n''existe pas ou le nombre d''agences est insuffisant'
SELECT * FROM Agence
/************************************************************************************/
--********************* Réaliser des instructions transact-sql permettant************/
--*********************d'afficher les clients en ajoutant un nouveau champ***********/
--**********************qui contient Ancien, Pas si vieu,Recent ou*******************/ 
--**********************On ne sait pas trop *****************************************/
/************************************************************************************/
Select 'Anciennete'= CASE numclt
		WHEN 'CLT001' THEN 'Ancien'	
		WHEN 'CLT002' then 'Pas si vieu'
		WHEN 'CLT003' THEN 'Recent'	
		ELSE 'On ne sait pas trop'	
		END,numclt,nomclt From Client
		ORDER BY Anciennete
		
--/*******************************************************************************/
--/******* afficher la numero  les spms les prinoms  et les type ses clients****/
--/********* sachant que  les types clients disponiblees sont  ()*************/
--/*************************************************************************/
SELECT  c.numclt ,nomclt,prenomclt,sum(ttc),'typeclt'= case
		WHEN SUM(ttc)<2000 THEN 'Passager'
		WHEN SUM(ttc) between 2000 and 5000 THEN 'Fidele'
		ELSE 'Potentiel'
	END FROM client c,facture f
WHERE c.numclt=f.numclt
group by c.numclt ,nomclt,prenomclt 
--/*******************************************************************************/
--/******* afficher les agences et leurs régions**********************************/
--/*******************************************************************************/
select * from Agence
---------------------
select numag, nomag, adresseag, telag, 'Régions' = case 
		when adresseag in('Témara', 'Salé') then  'Ouest'
		when adresseag in('Ksar','Tanger') then  'Nord'
		when adresseag='Casa' then 'Grand Casa'
		when adresseag='Oujda' then  'Est'
		else 'Region inconnue'
		end 
	FROM Agence 
	
---------------------------------------------------------------
--****AFFICHER LES CLIENTS LES TOTOUX D4ACHAT ET LA REMISE ACCORD2E AUX CLIENTS
--*******************LA REMISE EST CALCULER DE LA FACON  SUIVANTE / 

select c.numclt,prenomclt,adresseclt,telclt ,sum(f.ttc),
case
when sum(f.ttc)<5000 then sum(f.ttc)*0.3
when sum(f.ttc) between 5000 and 10000 then sum(f.ttc)*0.5
else  sum(f.ttc)*0.7 
end  as remise
from client c,facture f
where c.numclt=f.numclt
group by c.numclt,nomclt,prenomclt,adresseclt,telclt
---------------AFFICHER LES CLIENTS LES TOTOUX D4ACHT ET TYPE DE CLIENT  -------------------------------
select c.numclt,prenomclt,adresseclt,telclt ,sum(f.ttc),
case
when sum(f.ttc)<5000 then 'passager'
when sum(f.ttc) between 5000 and 10000 then  'Fidele'
else   'potontiel'
end  as type_client
from client c,facture f
where c.numclt=f.numclt
group by c.numclt,nomclt,prenomclt,adresseclt,telclt
------------AFFICHER  QUI ONT DES  CLIENTS FIDELES----------------------------------
select a.numag,nomag,adresseag,telag from agence a,facture f
where a.numag=f.numag and f.numclt in(select numclt from facture
group by numclt HAVING sum(ttc)between 5000 and 10000 )
--******************************exercice*******************************************
declare @i int 
declare @var varchar (15)
declare @nom varchar (15)
declare @prn varchar (15)
declare @adr varchar (30)
set @i =1
while (@i<=3)
begin
	set @var=convert(varchar(15),'CLT00'+ltrim(str(@i)))
	select @nom = nomclt,@prn=prenomclt,@adr=adresseclt from client where numClt = @var
	print space(5)+ltrim((@var))+space(5)+ltrim((@nom))+'     '+ltrim((@prn))+space(5)+ltrim((@adr)) 
	set @i = @i +1
end 
--/*******************************************************************************/
--/******* exsomple 1  pour afficher le premire, --
--le dernier et l'avant dernier clinet******************************/
--/*******************************************************************************/
DECLARE @nom VARCHAR(15),@prenom VARCHAR(15)
DECLARE curseur_client SCROLL CURSOR FOR 
SELECT nomclt,prenomclt FROM client 
OPEN curseur_client
	FETCH curseur_client INTO @nom,@prenom
		PRINT convert (varchar(50), @nom+' '+@prenom)
	FETCH LAST from curseur_client INTO @nom,@prenom
		PRINT convert (VARCHAR(50), @nom+' '+@prenom)
	FETCH prior from curseur_client INTO @nom,@prenom
		PRINT convert (VARCHAR(50), @nom+' '+@prenom)
CLOSE curseur_client
DEALLOCATE curseur_client
--/*******************************************************************************/
--/******* exemple 2   afficher le nom et le prenom de tous les clients, --
--/*******************************************************************************/
DECLARE @nom varchar(15),@prenom varchar(15)
DECLARE curseur_client  CURSOR FOR 
SELECT nomclt,prenomclt FROM client
open  curseur_client
fetch curseur_client into @nom,@prenom
WHILE @@FETCH_STATUS=0
begin
	print convert(varchar(35),@nom+' '+@prenom)
	fetch curseur_client into @nom,@prenom
end
--/*******************************************************************************/
--/******* exemple 2   afficher les valeurs envoyer par les fonction
--/**************** @@FETCH_STATUS et @@cursor_rows  --
--/*******************************************************************************/
DECLARE @nom varchar(15),@prenom varchar(15) 
declare curseur_client scroll cursor for
select nomclt,prenomclt from client 
open curseur_client
print @@cursor_rows 
fetch curseur_client into @prenom,@nom
	fetch prior  from curseur_client into @prenom,@nom
	print @@fetch_status
		fetch last  from curseur_client into @prenom,@nom
	print @@fetch_status
		fetch next  from curseur_client into @prenom,@nom
	print @@fetch_status
	close curseur_client
	deallocate curseur_client
	--
	SELECT * FROM client
--/*******************************************************************************/
--------------------------------------------------------------------------------
	--		1)	Créer un Curseur pour afficher le 3 eme et le 5 eme client		----
	--------------------------------------------------------------------------------
--/*******************************************************************************/
	DECLARE @numC varchar (15),@nomC varchar (15),@prnC varchar (15)
	DECLARE curseur_Trois_Cinq scroll cursor 
	FOR SELECT numclt, nomclt, prenomclt FROM client 
		open curseur_Trois_Cinq 
		FETCH ABSOLUTE 3 from curseur_Trois_Cinq into @numC, @nomC, @prnC
		print 'le troisieme : ' 
		print convert(varchar (50),@numC +space(5)+ @nomC+space(5)+ @prnC)
		FETCH ABSOLUTE 5 from curseur_Trois_Cinq into @numC, @nomC, @prnC
		print 'le cinqieme :'
		print convert(varchar (50),@numC +space(5)+ @nomC+space(5)+ @prnC)
--/*******************************************************************************/		
---2crée un curseur pour affichier les agence qui ont réalisé un chiffre d'affaire
--superieur a la moyenne des venteset qui ont plus d'un client--------
--/*******************************************************************************/
			DECLARE @numa varchar(15),@noma varchar(15),@adressa varchar(35),@chaf float,@nc int 
			DECLARE curseur_agence scroll cursor
			for select a.numag,nomag,adresseag ,sum(f.ttc),count(distinct f.numclt)from agence a ,facture f
			where a.numag =f.numag
			group by a.numag,nomag,adresseag 
			having sum(f.ttc)>(select avg (ttc)from facture) and count(distinct f.numclt)>1
			  open curseur_agence 
			  FETCH curseur_agence into @numa,@noma,@adressa,@chaf,@nc
			  while @@FETCH_STATUS=0
			  begin
					print convert (varchar (80),@numa+space(4)+@noma+space(4)+@adressa
					+str(@chaf)+str(@nc))
					FETCH curseur_agence into @numa,@noma,@adressa,@chaf,@nc
			  end 
			  close curseur_agence
			  deallocate curseur_agence
--/*******************************************************************************/
--2crée un curseur pour affichier les clients et les achat effectues par chaque client et une observation comme 
--une observation comme suivant :--
--moins impotant si ensemble de achat est inferuir a 3000
-- peu important si ensemble de achat est entre 3000 et 7000
-- impotant si ensemble de achat est superieur a 7000
--/*******************************************************************************/
DECLARE @numc varchar (15), @prenomc varchar(15),@nomc varchar(15),@adressec varchar(35),@achat float, @ob varchar (15)
DECLARE curseur_client scroll cursor
FOR SELECT c.numclt, nomclt, prenomclt, sum(ttc), case 
		when sum(ttc) <3000 then 'Moins impotant'
		when sum(ttc)>=3000 and sum(ttc) <=7000 then 'Peu important'
		else 'Important'  end as observation  FROM client c, facture f
		where c.numclt = f.numclt 
		group by c.numclt, nomclt, prenomclt 
open curseur_client
FETCH curseur_client into @numc, @nomc, @prenomc, @achat, @ob
while @@FETCH_STATUS=0 
begin
		print convert(varchar(82) , ltrim(@numc)+ space(4)+ ltrim(@nomc)+ space(4)+ ltrim(@prenomc)+ space(4)+ ltrim(str(@achat))+ space(4)+ltrim(@ob))
		FETCH curseur_client into @numc, @nomc, @prenomc, @achat, @ob

end 
close curseur_client
deallocate curseur_client
--/*******************************************************************************/
--/******* exemple 1: Les fonctions tables simples --
--/*******************************************************************************/
CREATE FUNCTION facturesClient(@num_clt varchar(15))
RETURNS TABLE 
As
RETURN (Select *From facture Where numclt =@num_clt)
select * from facturesClient('CLT006')
--/*******************************************************************************/
--/******* exemple 2: Les fonctions tables multi-instructions --
--/*******************************************************************************/
CREATE FUNCTION table_multi(@na varchar(15))
returns @variable TABLE(numf varchar(15),tot float,Nom_Agence varchar(20))
as
begin
	insert into @variable SELECT numfact,ttc,nomag
	from agence a, facture f
	where a.numag=f.numag and f.numag=@na
	return
end
select*from dbo.table_multi('AG00002')
--/*******************************************************************************/
--/******* exemple 3: Les fonctions scalaires --
--/*******************************************************************************/
create function nombre_client(@nclt varchal(15))
returns int 
as
begin 
	declare @nb int
	select @nb=count(*)
	from client
	where Numclt = @nclt
	return @nb
	

end
print str (dbo.nombre_client("clt003"))

--/************************************************************
--/		Réaliser une fonction qui retourne les clients 
--/		d'une agence bien precise
--/************************************************************
CREATE FUNCTION client_Agence(@numAgence varchar(15))
returns table
as	
	RETURN (SELECT c.numclt, nomclt, prenomclt, adresseclt FROM client c,facture f
	where f.numclt = c.numclt and f.numag = @numAgence
	GROUP BY c.numclt, nomclt, prenomclt, adresseclt )

select*from client_Agence('AG00002')
--/************************************************************
--/		Réaliser une fonction qui retourne les clients 
--/		d'une agence bien precise
--/************************************************************
create function clients_agence(@num varchar(15))
returns table
as
return(select  c.numclt,nomclt,prenomclt,adresseclt,telclt 
from client c , facture f
where f.numclt = c.numclt and numag=@num
group by c.numclt ,nomclt,prenomclt ,adresseclt,telclt)
select*from dbo.clients_agence('AG00002')
--/************************************************************
--/		Réaliser une fonction qui retourne les Factures
--/		d'un client bien precis
--/************************************************************
create function factures_client(@nc varchar(15))
returns @tfactclt table(nf varchar(15) , df datetime ,ttc float )
as 
begin
	INSERT INTO @tfactclt SELECT numfact,datefact,ttc FROM facture
	where numclt=@nc
	return
	
	                 	
end 
select*from dbo.factures_client('CLT006')
--/************************************************************
--/		Réaliser une fonction qui retourne le nombre 
--/ de Factures d'un client bien precis
--/************************************************************
create function nombre_factures(@num varchar(15))
returns int
as 
begin 
	Declare @nf int
	select @nf=COUNT(numfact) from facture
	where numclt=@num
	return @nf
end  
--**--
Print str(dbo.nombre_factures('CLT006'))
--/************************************************************
--/******** Réaliser une fonction qui retourne les clients*****
--/******** et leurs types d'une agence bien precise    ********
--/************************************************************
create function  type_clients( @nag varchar (15))
returns  table 
as
	return SELECT c.numclt,nomclt,prenomclt,case 
		WHEN sum(ttc)<100 then 'Passager'
		WHEN sum(ttc)between 100 and 5000  then 'Fidele'
		ELSE 'Potentiel'
	end	as  [type de client]
	FROM client c,facture f
	where c.numclt=f.numclt AND numag=@nag
	GROUP BY c.numclt,nomclt,prenomclt

SELECT * FROM type_clients( 'AG00001')
--/************************************************************
--/******** Réaliser une procédure stockéé qui retourne les noms
--/********et les prénoms des clients spécifiés ***************
--/************************************************************
create procedure clt_info @nom varchar(40),@prenom varchar(40) 
as
select nomclt,prenomclt FROM client
where nomclt=@nom AND prenomclt =@prenom

execute clt_info 'Hicham','RADI'
--ou
execute clt_info @prenom='RADI',@nom='Hicham'

execute clt_info @nom='Hicham',@prenom='RADI'

--EXEMPLE B (PARAMETRES OUTPUT)

create PROCEDURE Proced_sum @Som float OUTPUT, @nag varchar(40)='%'
As 
Select @Som=SUM(TTC) From facture where numag LIKE @nag
declare @total float
Execute Proced_sum	@total output 
print convert(nvarchar(12),@total)
--/************************************************************
--/******** Réaliser une procédure stockéé qui retourne 
--/********si une agence bien précise réalise des vents ou non ***************
--/************************************************************
create PROCEDURE verifierVentes @bl varchar(3)output ,@na varchar(15)
as
select @bl = case 
		when numag in(SELECT numag from facture) then  'Oui'
		else 'Non'
		end  
from agence where numag = @na
declare @vt varchar(3)
Execute verifierVentes @vt output ,'AG00004'
print convert(varchar(3),@vt)
--/************************************************************
--/******** Réaliser une procédure stockéé qui retourne******** 
--/********le nombre de clients d'une agence bien précise *****
--/************************************************************
create PROC NombreClientsAgences @nca int output, @numagence varchar(15)
as
select @nca = COUNT(DISTINCT (numclt)) from facture where numag=@numagence
declare @nbr int 
Execute NombreClientsAgences @nbr output, 'AG00004'
print convert (varchar(10),@nbr)
--/************************************************************
--/********creer une procudure stockée qui permet de routoure les******* 
--/******** achats d'un client dans une peiode *****
--/************************************************************
create proc achats_client_periode @achat float output,@nc varchar(15),@dtd datetime, @dtf datetime
as 
	select @achat=SUM(ttc) from facture where numclt=@nc and datefact between @dtd and @dtf

declare @ach float;
execute achats_client_periode @ach output , 'CLT001','01/01/2010','12/12/2012'
print convert (varchar(15),@ach)
--/************************************************************
--/********	creer une fnuction scalairr qui permet routoure	*** 
--/******** la moyenne des ventes et ajouter le resultat	***
--/********	aux ttc des factures qui ont un ttc < 3500	*******
--/***********************************************************
create function sclaireMoyenne()
returns float 
as
begin
declare @moy float;
	select @moy=avg(ttc) from facture
	return @moy	
end
print convert (varchar(15),dbo.sclaireMoyenne())
update facture set tva = tva+dbo.sclaireMoyenne()/6,tht = tht + dbo.sclaireMoyenne()*5/6,ttc = ttc+dbo.sclaireMoyenne() 
where ttc < 3500
select * from facture
---********************************************************************************-
/***CREER UNE FONCTION TABLE MULTI-INSTRUCTION QUI PERMET DENVOQUER LES CLIENT ***-
***DUNE VILLE QUI ONT EFFECTUER DES ACHATS DANS  UNE AGENCE  DUNE AUTRE VILLE **/

create function ClientVilleAgenceAutreVille(@vc VARCHAR(15),@va varchar(15))
RETURNS @clientstable table(
numclt varchar(15) primary key not null,
nomclt varchar(15) not null,
prenom varchar (15) not null,
adresseclt varchar (20)not null
)
as
begin 

	insert into @clientstable select c.numclt, nomclt, prenomclt , adresseclt from client c, agence a, facture f
	where c.numclt=f.numclt and a.numag = f.numag and a.adresseag = @va and c.adresseclt=@vc
	return ;
end

select* from dbo.ClientVilleAgenceAutreVille('Rabat','Salé')

--******creer une procedeure stockée qui permet de renvoyer les clients d'une agences et***************
--******retourner la somme des achats de ces clients *********************

create proc client_agence_achat @sa float output , @na varchar(15) 
as
begin
	select @na= SUM(ttc) from facture where numag=@na 
	select c.numclt ,nomclt ,adresseclt from client c ,facture f  where c.numclt =f.numclt and numag =@na  
end 

